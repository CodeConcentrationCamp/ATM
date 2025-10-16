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
    
    var upClickDataBlock:((_ patent:String) -> (Void))?
    
    func homeDetail(){
        NetworkManager.shared.request(API.homeDetail, modelType: HomeModel.self) { [self] mm, responseModel in
            homeModel = mm
            self.upDataBlock?("success",mm)
        } failureCallback: { responseModel in
            
        }
    }
    
    
    func clickApply(proID:String?){
        NetworkManager.shared.request(API.clickProduct(proID: proID!), modelType: HomeModel.self) { mm, responseModel in
            self.upClickDataBlock?(mm.patent!)
        } failureCallback: { responseModel in
            
        }
    }
    
    
    func homeCardAndItemCellClick(hoemModel:HomeModel?,proID:String?,vc:UIViewController){
        if homeModel == nil{
            ShowTip.showMessage("Data not obtained")
        }
        
        if hoemModel?.overhauling == "1"{
            
        }else{
            
        }
    }
    
    
    
}
