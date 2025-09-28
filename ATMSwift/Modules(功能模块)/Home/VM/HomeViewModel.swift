//
//  HomeViewModel.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/26.
//

import UIKit

class HomeViewModel: NSObject {
    
    var homeModel:HomeModel?
    // - 数据源更新
    var upDataBlock:((String,HomeModel?) -> (Void))?
    
    func homeDetail(){
        NetworkManager.shared.request(API.homeDetail, modelType: HomeModel.self) { [self] mm, responseModel in
            homeModel = mm
            self.upDataBlock?("success",mm)
        } failureCallback: { responseModel in
            
        }
    }
}
