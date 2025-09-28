//
//  LoginViewModel.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/26.
//

import UIKit

class LoginViewModel: NSObject {
    func getSMSCode(phoneNum:String!){
        NetworkManager.shared.request(API.getLoginCode(phoneNum: phoneNum), modelType: ResponseModel.self) { mm, responseModel in
            ShowTip.showMessage(responseModel.msg!)
        } failureCallback: { responseModel in
            ShowTip.showMessage(responseModel.msg!)
        }
    }
    
    func goLogin(phoneNum:String!,codeNum:String!){
        NetworkManager.shared.request(API.goLogin(phoneNum: phoneNum, codeNum: codeNum), modelType: LoginResponseModel.self) { mm, responseModel in
            print(mm.invented as Any)
            ToolManager.shared.saveData(mm.invented!, forKey: "PhoneNum")
            ToolManager.shared.saveData(mm.undertaking!, forKey: "ATM_SessionId")
            PageRouter.changeHomeOrLoginPage()
        } failureCallback: { responseModel in
            ShowTip.showMessage(responseModel.msg!)
        }
    }
}
