//
//  ProductModelView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/28.
//

import UIKit

class ProductModelView: NSObject {
    
    var productModel : ProductModel?
    
    // - 数据源更新
    var upDataBlock:((String,ProductModel?) -> (Void))?
    
    func getProductDetail(proID:String?){
        NetworkManager.shared.request(API.productDetail(proID: proID ?? ""), modelType: ProductModel.self) { [self] mm, responseModel in
            self.productModel = mm
            self.upDataBlock?("success",mm)
        } failureCallback: { responseModel in
            
        }
    }
}
