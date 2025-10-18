//
//  PerInfoViewModel.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/16.
//

import UIKit

class PerInfoViewModel: NSObject {
    
    func getUserInfo2(proID:String,completion: @escaping (Bool, PerInfoModel) -> Void){
        ShowTip.showLoading()
        NetworkManager.shared.request(API.getUserInfo2(proID: proID), modelType: PerInfoModel.self) { mm, responseModel in
            ShowTip.hideLoading()
            DispatchQueue.main.async {completion(true, mm)}
        } failure:{ error,responseModel in
            DispatchQueue.main.async {
                ShowTip.showMessage(responseModel.msg!)
            }
        }
    }
}
