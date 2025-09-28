//
//  API.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/26.
//

import Foundation
import Moya
// API接口定义
enum API {
    //获取验证码
    case getLoginCode(phoneNum: String)
    //登陆
    case goLogin(phoneNum: String,codeNum: String)
    //首页
    case homeDetail
    //订单
    case orderDetail(state: String)
}

// 扩展API实现TargetType协议
extension API: TargetType{
    var baseURL: URL {
        URL(string: "http://8.212.166.255:8097/examined")!
    }
    
    var path: String {
        switch self{
        case .getLoginCode: 
            return "/miles/hills"
        case .goLogin:
            return "/miles/fringed"
        case .homeDetail:
            return "/miles/hillswe"
        case .orderDetail:
            return "/miles/sailedi"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getLoginCode,.goLogin,.orderDetail:
            return .post
        case .homeDetail:
            return .get        }
    }
    
    var task: Moya.Task {
        switch self{
        case .getLoginCode(phoneNum: let codeNum):
            let parameters = [
                "bye": codeNum,
                "warmly": String.randomAlphanumeric()
            ]
            return .requestParameters(parameters: parameters, encoding:URLEncoding.queryString)
            
        case .goLogin(phoneNum: let phoneNum, codeNum: let codeNum):
            let parameters = [
                "invented": phoneNum,
                "porpoise": codeNum,
                "deal": String.randomAlphanumeric()
            ]
            return .requestParameters(parameters: parameters, encoding:URLEncoding.queryString)
        case .homeDetail:
            let parameters = [
                "brilliancy": String.randomAlphanumeric(),
                "brightened": String.randomAlphanumeric()
            ]
            return .requestParameters(parameters: parameters, encoding:URLEncoding.queryString)
        case .orderDetail(state: let state):
            let parameters = [
                "purchased": state
            ]
            return .requestParameters(parameters: parameters, encoding:URLEncoding.httpBody)
        }
    }
    
    var headers: [String : String]? {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json"
        ]
        return headers
    }
}
