//
//  OrderViewModel.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/27.
//

import UIKit

class OrderViewModel: NSObject {
    
    var orderModel:OrderModel?
    // - 数据源更新
    var upDataBlock:((String,OrderModel?) -> (Void))?

    
    func getProductDetailState(state:String){
        NetworkManager.shared.request(API.orderDetail(state: state), modelType: OrderModel.self) { mm, responseModel in
            self.orderModel = mm
            self.upDataBlock?("success",mm)
        } failureCallback: { responseModel in
            
        }
    }
    
}


