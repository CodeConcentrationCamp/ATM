//
//  HomeService.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/17.
//

import Foundation
import Combine

class HomeService {
    private var cancellables = Set<AnyCancellable>()
    static let shared = HomeService()
    private init() {} // 私有初始化，防止外部创建实例
    var homeCompletion: ((HomeModel) -> Void)?
    
    /// 获取首页详情数据
        /// - Parameter completion: 回调结果（主线程）
        func fetchHomeDetail(completion: @escaping (Result<HomeModel, Error>) -> Void) {
            NetworkManager.shared.request(API.homeDetail, modelType: HomeModel.self)
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { completionResult in
                        if case .failure(let error) = completionResult {
                            completion(.failure(error))
                        }
                    },
                    receiveValue: { model, _ in
                        completion(.success(model))
                    }
                )
                .store(in: &cancellables)
        }
        
        /// 取消所有请求
        func cancelAllRequests() {
            cancellables.removeAll()
        }
    
}



