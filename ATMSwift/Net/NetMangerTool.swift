//
//  NetMangerTool.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/18.
//


import Foundation
import Moya
import Alamofire
import SwiftyJSON
import HandyJSON
import Combine


// MARK: - 网络错误定义（整合所有可能的错误）
enum NetworkError: Error, LocalizedError {
    case invalidURL                  // URL无效
    case invalidStatusCode(code: Int) // 状态码错误（非200系列）
    case parsingFailed(model: String) // 模型解析失败（附带模型名）
    case businessError(code: Int, msg: String) // 业务错误（后端code非0）
    case moyaError(MoyaError)        // Moya原生错误（网络、超时等）
    case unknown                     // 未知错误
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "无效的请求地址"
        case .invalidStatusCode(let code):
            return "请求失败（状态码：\(code)）"
        case .parsingFailed(let model):
            return "\(model)数据解析失败"
        case .businessError(_, let msg):
            return msg
        case .moyaError(let error):
            return error.localizedDescription
        case .unknown:
            return "未知错误"
        }
    }
}


// MARK: - 网络请求管理类（单例 + Combine响应式）
final class NetworkManager {
    static let shared = NetworkManager()
    private let provider: MoyaProvider<API> // 明确依赖API类型，避免as!强转
    
    // 初始化（支持自定义provider，便于测试）
    init(provider: MoyaProvider<API> = defaultProvider) {
        self.provider = provider
    }
    
    // 默认Provider配置（提取为静态属性，简化初始化）
    private static var defaultProvider: MoyaProvider<API> {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30 // 超时时间
        
        let plugins: [PluginType] = [
            // 网络活动指示器（显示/隐藏加载框）
            NetworkActivityPlugin { change, _ in
                DispatchQueue.main.async {
                    switch change {
                    case .began: ShowTip.showLoading()
                    case .ended: ShowTip.hideLoading()
                    }
                }
            },
            CommonParamsPlugin() // 公共参数插件
            // 开发环境可添加日志插件：NetworkLoggerPlugin(configuration: .verbose)
        ]
        
        return MoyaProvider<API>(
            session: Session(configuration: configuration),
            plugins: plugins,
            trackInflights: true// 防止重复请求
        )
    }
}


// MARK: - 核心请求方法（泛型解析）
extension NetworkManager{
    /// 发起请求并解析为指定模型
    /// - Parameters:
    ///   - target: API请求目标（必须是API类型，避免强转）
    ///   - modelType: 要解析的模型类型（需遵循HandyJSON）
    ///   - needShowFailAlert: 是否自动显示错误弹窗
    ///   - success: 成功回调（返回模型和原始响应）
    ///   - failure: 失败回调（返回错误信息和响应模型）
    /// - Returns: Cancellable（可取消请求）
    @discardableResult
    func request<T: HandyJSON>(
        _ target: API, // 明确参数类型为API，消除as!强转
        modelType: T.Type,
        needShowFailAlert: Bool = true,
        success: @escaping (T, ResponseModel) -> Void,
        failure: ((NetworkError, ResponseModel) -> Void)? = nil
    ) -> Moya.Cancellable {
        // 发起请求（使用Moya的闭包回调）
        return provider.request(target) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.handleSuccessResponse(
                    response: response,
                    modelType: modelType,
                    needShowFailAlert: needShowFailAlert,
                    success: success,
                    failure: failure
                )
                
            case .failure(let error):
                self.handleFailure(
                    error: .moyaError(error),
                    needShowFailAlert: needShowFailAlert,
                    failure: failure
                )
            }
        }
    }
    /// 仅获取响应模型（不解析具体业务数据）
    @discardableResult
    func request(
        _ target: API,
        needShowFailAlert: Bool = true,
        success: @escaping (ResponseModel) -> Void,
        failure: ((NetworkError, ResponseModel) -> Void)? = nil
    ) -> Moya.Cancellable {
        return provider.request(target) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.handleSuccessResponse(
                    response: response,
                    needShowFailAlert: needShowFailAlert,
                    success: success,
                    failure: failure
                )
                
            case .failure(let error):
                self.handleFailure(
                    error: .moyaError(error),
                    needShowFailAlert: needShowFailAlert,
                    failure: failure
                )
            }
        }
    }
}
    
    
    // MARK: - 私有工具方法（拆分处理逻辑，避免代码臃肿）
private extension NetworkManager {
        /// 处理成功响应（解析为ResponseModel）
        func handleSuccessResponse(
            response: Response,
            needShowFailAlert: Bool,
            success: @escaping (ResponseModel) -> Void,
            failure: ((NetworkError, ResponseModel) -> Void)?
        ) {
            do {
                // 解析为ResponseModel
                guard let jsonString = String(data: response.data, encoding: .utf8),
                      let respModel = ResponseModel.deserialize(from: jsonString) else {
                    throw NetworkError.parsingFailed(model: "ResponseModel")
                }
                
                // 检查业务状态码
                guard respModel.code == 0 else {
                    
                    if respModel.code == -2 {
                        ToolManager.shared.saveData("", forKey: "ATM_SessionId")
                        PageRouter.changeHomeOrLoginPage()
                        return
                    }
                    
                    throw NetworkError.businessError(
                        code: respModel.code ?? -1,
                        msg: respModel.msg ?? "未知业务错误"
                    )
                }
                
                success(respModel)
                
            } catch {
                // 解析失败或业务错误
                let networkError = error as? NetworkError ?? .unknown
                let errorRespModel = ResponseModel(
                    code: (networkError as? BusinessCodeConvertible)?.code ?? -1,
                    msg: networkError.localizedDescription,
                    data: nil
                 
                )
                handleFailure(
                    error: networkError,
                    responseModel: errorRespModel,
                    needShowFailAlert: needShowFailAlert,
                    failure: failure
                )
            }
        }
        
        /// 处理成功响应（进一步解析为业务模型）
        func handleSuccessResponse<T: HandyJSON>(
            response: Response,
            modelType: T.Type,
            needShowFailAlert: Bool,
            success: @escaping (T, ResponseModel) -> Void,
            failure: ((NetworkError, ResponseModel) -> Void)?
        ) {
            // 先解析为ResponseModel
            handleSuccessResponse(
                response: response,
                needShowFailAlert: needShowFailAlert,
                success: { [weak self] respModel in
                    guard let self = self else { return }
                    // 再解析为业务模型
                    guard let dataDict = respModel.data,
                          let model = T.deserialize(from: dataDict) else {
                        let error = NetworkError.parsingFailed(model: String(describing: T.self))
                        self.handleFailure(
                            error: error,
                            responseModel: respModel,
                            needShowFailAlert: needShowFailAlert,
                            failure: failure
                        )
                        return
                    }
                    success(model, respModel)
                },
                failure: failure
            )
        }
        
        /// 处理失败场景
        func handleFailure(
            error: NetworkError,
            responseModel: ResponseModel? = nil,
            needShowFailAlert: Bool,
            failure: ((NetworkError, ResponseModel) -> Void)?
        ) {
            // 构建错误响应模型
            let respModel = responseModel ?? ResponseModel(
                code: (error as? BusinessCodeConvertible)?.code ?? -1,
                msg: error.localizedDescription,
                data: nil
            )
            
            // 自动显示错误弹窗
            if needShowFailAlert {
                ShowTip.showMessage(error.localizedDescription)
            }
            
            // 回调失败
   //         failure?(error, respModel)
        }
     
    
}


// MARK: - 核心请求方法（Combine响应式 + 泛型解析）
extension NetworkManager {
    /// 发起请求并解析为指定模型+ Combine响应式
    /// - Parameters:
    ///   - target: API请求目标（遵循TargetType）
    ///   - modelType: 要解析的模型类型（需遵循HandyJSON）
    ///   - needShowFailAlert: 是否显示错误弹窗
    /// - Returns: AnyPublisher（发布模型或错误）
    func request<T: HandyJSON>(
        _ target: API, // 明确参数类型为API，避免强转
        modelType: T.Type,
        needShowFailAlert: Bool = true
    ) -> AnyPublisher<(model: T, response: ResponseModel), NetworkError> {
        provider.requestPublisher(target) // Moya的Combine扩展，返回Publisher
            .tryMap { response -> ResponseModel in
                // 1. 解析响应为通用ResponseModel
                guard let jsonString = String(data: response.data, encoding: .utf8),
                      let respModel = ResponseModel.deserialize(from: jsonString) else {
                    throw NetworkError.parsingFailed(model: "ResponseModel")
                }
                // 2. 处理业务错误（后端code非0）
                guard respModel.code == 0 else {
                    throw NetworkError.businessError(
                        code: respModel.code ?? -1,
                        msg: respModel.msg ?? "未知业务错误"
                    )
                }
                return respModel
            }
            .tryMap { respModel -> (T, ResponseModel) in
                // 3. 解析业务数据为目标模型
                guard let dataDict = respModel.data,
                      let model = T.deserialize(from: dataDict) else {
                    throw NetworkError.parsingFailed(model: String(describing: T.self))
                }
                return (model, respModel)
            }
            .mapError { error -> NetworkError in
                // 4. 统一错误转换
                if let networkError = error as? NetworkError {
                    return networkError
                } else if let moyaError = error as? MoyaError {
                    return .moyaError(moyaError)
                } else {
                    return .unknown
                }
            }
            .handleEvents(receiveCompletion: { [weak self] completion in
                // 5. 错误弹窗处理（非业务逻辑，通过handleEvents副作用处理）
                guard case .failure(let error) = completion, needShowFailAlert else { return }
                self?.showErrorAlert(message: error.localizedDescription)
            })
            .eraseToAnyPublisher()
    }
    
    /// 仅获取响应模型（不解析具体业务数据）
    func request(
        _ target: API,
        needShowFailAlert: Bool = true
    ) -> AnyPublisher<ResponseModel, NetworkError> {
        
        provider.requestPublisher(target)
            .tryMap { response -> ResponseModel in
                guard let jsonString = String(data: response.data, encoding: .utf8),
                      let respModel = ResponseModel.deserialize(from: jsonString) else {
                    throw NetworkError.parsingFailed(model: "ResponseModel")
                }
                
                guard respModel.code == 0 else {
                    throw NetworkError.businessError(
                        code: respModel.code ?? -1,
                        msg: respModel.msg ?? "未知业务错误"
                    )
                }
                return respModel
            }
            .mapError { error -> NetworkError in
                error as? NetworkError ?? .moyaError(error as! MoyaError) // 简化转换（实际可更严谨）
            }
            .handleEvents(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion, needShowFailAlert else { return }
                self?.showErrorAlert(message: error.localizedDescription)
            })
            .eraseToAnyPublisher()
    }
    
    // 错误弹窗（提取为私有方法，避免重复代码）
    private func showErrorAlert(message: String) {
        DispatchQueue.main.async {
            print("弹出错误信息：\(message)") // 实际项目中替换为UIAlertController
        }
    }
}


// MARK: - 辅助协议（用于提取错误码）
protocol BusinessCodeConvertible {
    var code: Int { get }
}

extension NetworkError: BusinessCodeConvertible {
    var code: Int {
        switch self {
        case .invalidStatusCode(let code): return code
        case .businessError(let code, _): return code
        case .moyaError(let error): return error.response?.statusCode ?? -1
        case .parsingFailed: return 1000000 // 解析失败固定码
        default: return -1
        }
    }
}
