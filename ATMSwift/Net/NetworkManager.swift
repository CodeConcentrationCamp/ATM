//
//  NetworkManager.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/26.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON
import HandyJSON


// 单个模型的成功回调 包括： 模型，网络请求的模型(code,message,data等，具体根据业务来定)
typealias RequestModelSuccessCallback<T:HandyJSON> = ((_ mm:T,_ responseModel:ResponseModel) -> Void)
// 网络请求的回调 包括：网络请求的模型(code,message,data等，具体根据业务来定)
typealias RequestCallback = ((ResponseModel) -> Void)
/// 网络错误的回调
typealias errorCallback = (() -> Void)

// MARK: - 网络错误定义
enum NetworkError: Error {
    case invalidURL
    case invalidStatusCode(code: Int)
    case parsingFailed
    case networkError(Error)
}

// MARK: - 错误描述
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "无效的URL"
        case .invalidStatusCode(let code):
            return "请求失败，状态码: \(code)"
        case .parsingFailed:
            return "数据解析失败"
        case .networkError(let error):
            return error.localizedDescription
        }
    }
}

extension NetworkManager{
    
    //网络请求，当模型为dict类型
    @discardableResult
    func request<T: HandyJSON>(_ target: TargetType, needShowFailAlert: Bool = true, modelType: T.Type, successCallback:@escaping RequestModelSuccessCallback<T>, failureCallback: RequestCallback? = nil) -> Cancellable? {
        return HttpManager(target, needShowFailAlert: needShowFailAlert, successCallback: { (responseModel) in

            if let model = JSONDeserializer<T>.deserializeFrom(dict: responseModel.data)
               {
                successCallback(model, responseModel)
            } else {
                self.errorHandler(code: responseModel.code! , message: "解析失败", needShowFailAlert: needShowFailAlert, failure: failureCallback)
            }
        }, failureCallback: failureCallback)
    }
    
    @discardableResult
    func HttpManager(_ target: TargetType, needShowFailAlert: Bool = true, successCallback:@escaping RequestCallback, failureCallback: RequestCallback? = nil) -> Cancellable? {
//        // 先判断网络是否有链接 没有的话直接返回--代码略
//        if !UIDevice.isNetworkConnect {
//            // code = 9999 代表无网络  这里根据具体业务来自定义
//            errorHandler(code: 9999, message: "网络似乎出现了问题", needShowFailAlert: needShowFailAlert, failure: failureCallback)
//            return nil
//        }
        
        return provider.request(target as! API) { result in
            switch result {
            case let .success(response):
                do {
                    let jsonData = try JSON(data: response.data)
                    print("返回结果是：\(jsonData)")
//                    if !validateRepsonse(response: jsonData.dictionary, needShowFailAlert: needShowFailAlert, failure: failureCallback) { return }
                    //字典转模型
                    if let respModel = JSONDeserializer<ResponseModel>.deserializeFrom(json: jsonData.description){
                        if respModel.code == 0 {
                            successCallback(respModel)
                        } else {
                            self.errorHandler(code: respModel.code! , message: respModel.msg! , needShowFailAlert: needShowFailAlert, failure: failureCallback)
                            return
                        }
                    }else{
                        
                    }
                } catch {
                    // code = 1000000 代表JSON解析失败  这里根据具体业务来自定义
                    self.errorHandler(code: 1000000, message: String(data: response.data, encoding: String.Encoding.utf8)!, needShowFailAlert: needShowFailAlert, failure: failureCallback)
                }
            case let .failure(error as NSError):
                self.errorHandler(code: error.code, message: "网络连接失败", needShowFailAlert: needShowFailAlert, failure: failureCallback)
            }
        }
        
    }
    private func errorHandler(code: Int, message: String, needShowFailAlert: Bool, failure: RequestCallback?) {
        print("发生错误：\(code)--\(message)")
        let model = ResponseModel()
        model.code = code
        model.msg = message
        if needShowFailAlert {
            // 弹框
            print("弹出错误信息弹框\(message)")
        }
        failure?(model)
    }
    
    
    
}

// 网络请求管理类
class NetworkManager {
    /// 单例实例
    static let shared = NetworkManager()
    
    // 创建MoyaProvider
    private let provider : MoyaProvider<API>
    
    /// 私有初始化
    private init() {
        // 配置Provider
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        
        // 可以添加插件，如网络活动指示器、日志等
        let plugins: [PluginType] = [
            NetworkActivityPlugin { change, _ in
                // 处理网络活动状态变化（如显示/隐藏加载指示器）
                DispatchQueue.main.async {
                    switch change {
                    case .began:
                        ShowTip.showLoading()
                        
                    case .ended:
                        ShowTip.hideLoading()
                    }
                }
            },
            CommonParamsPlugin()
            // 日志插件，开发环境使用
            //  NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        ]
        
        provider = MoyaProvider<API>(
            session: Session(configuration: configuration),
            plugins: plugins
        )
    }
    
    
//    func request<T: HandyJSON>(
//        _ target: API,
//        model type: T.Type,
//        completion: @escaping (Result<T, Error>) -> Void
//    ) {
//        provider.request(target) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let jsonData = try JSON(data: response.data)
//                    print("返回结果是：\(jsonData)")
//                    //字典转模型
//                    if let respModel = JSONDeserializer<ResponseModel>.deserializeFrom(json: jsonData.description){
//                        completion(.success(respModel as! T))
//                    }
//                    
//                } catch {
//                    completion(.failure(NetworkError.parsingFailed))
//                }
//                
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
    
    /// 发送请求（仅返回原始数据）
    /// - Parameters:
    ///   - target: API目标
    ///   - completion: 完成回调
    func request(
        _ target: API,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                if (200...299).contains(response.statusCode) {
                    completion(.success(response.data))
                } else {
                    completion(.failure(NetworkError.invalidStatusCode(code: response.statusCode)))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

