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
    //申请
    case clickProduct(proID:String)
    //产品详情
    case productDetail(proID:String)
    //获取用户身份信息（第一项）
    case getUserInfo(proID:String)
    //保存用户身份证信息（第一项）
    case saveUserInfo(proID:String,subsided:String,excitement:String,slice:String,church:String)
    //订单ID 获取URL
    case orderIDGetUrl(westwards:String)
    
    //相册
    case uploadAvatar(imageData: Data, reflection: String,says: String,lamps: String,church: String,submit :String,ruling: String = "")
    
    
    //退出Out
    case outLogin
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
        case .productDetail:
            return "/miles/forest"
        case .clickProduct:
            return "/miles/inquirer"
        case .getUserInfo:
            return "/miles/comparative"
        case .orderIDGetUrl:
            return "/miles/whirl"
        case .uploadAvatar:
            return "/miles/return"
        case .saveUserInfo:
            return "/miles/apartthe"
        case .outLogin:
            return "/miles/flats"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getLoginCode,.goLogin,.orderDetail,.productDetail,.clickProduct,.orderIDGetUrl,        .uploadAvatar,.saveUserInfo:
            return .post
        case .homeDetail,.getUserInfo,.outLogin:
            return .get
        }
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
        case .productDetail(proID: let proID):
            let parameters = [
                "says": proID,
                "vegetarians": String.randomAlphanumeric(),
                "turn": String.randomAlphanumeric()
            ]
            return .requestParameters(parameters: parameters, encoding:URLEncoding.httpBody)
        case .clickProduct(proID: let proID):
            let parameters = [
                "says": proID,
            ]
            return .requestParameters(parameters: parameters, encoding:URLEncoding.httpBody)
        case .getUserInfo(proID: let proID):
            let parameters = [
                "says": proID,
                "pushed":String.randomAlphanumeric()
            ]
            return .requestParameters(parameters: parameters, encoding:URLEncoding.queryString)
        case .orderIDGetUrl(westwards: let westwards):
            let parameters = [
                "westwards": westwards,
                "pushed":String.randomAlphanumeric()
            ]
            return .requestParameters(parameters: parameters, encoding:URLEncoding.httpBody)
            
            //相册
        case .uploadAvatar(imageData: let imageData, reflection: let reflection, says: let says, lamps: let lamps, church: let church, submit: let submit, ruling: let ruling):
            // 1. 构建所有 multipart 字段
                       var multiparts: [MultipartFormData] = []
                       
                       // 添加文本参数（非文件字段）
                       multiparts.append(
                           MultipartFormData(
                               provider: .data("\(reflection)".data(using: .utf8)!),
                               name: "reflection"
                           )
                       )
                       multiparts.append(
                           MultipartFormData(
                               provider: .data("\(says)".data(using: .utf8)!),
                               name: "says"
                           )
                       )
                       multiparts.append(
                           MultipartFormData(
                               provider: .data("\(lamps)".data(using: .utf8)!),
                               name: "lamps"
                           )
                       )
                       multiparts.append(
                           MultipartFormData(
                               provider: .data(church.data(using: .utf8)!),
                               name: "church"
                           )
                       )
                       multiparts.append(
                           MultipartFormData(
                               provider: .data(ruling.data(using: .utf8)!),
                               name: "ruling"
                           )
                       )
                  
                       multiparts.append(
                           MultipartFormData(
                               provider: .data(submit.data(using: .utf8)!),
                               name: "submit"
                           )
                       )
                       
                       // 2. 添加图片文件（consoled 是压缩后的图片 Data）
                       multiparts.append(
                           MultipartFormData(
                               provider: .data(imageData),
                               name: "consoled",
                               fileName: "identity_image.jpg", // 文件名（可自定义，需带扩展名）
                               mimeType: "image/jpeg"        // 图片 MIME 类型（根据实际图片格式调整）
                           )
                       )
                       
                       // 3. 返回 multipart 任务
                       return .uploadMultipart(multiparts)
        case .saveUserInfo(proID: let proID, subsided: let subsided, excitement: let excitement, slice: let slice, church: let church):
            let parameters = [
                "proID": proID,
                "subsided":subsided,
                "excitement":excitement,
                "slice":slice,
                "church":church,
                "lamps": "11"
            ]
            return .requestParameters(parameters: parameters, encoding:URLEncoding.httpBody)
        case .outLogin:
            return .requestParameters(parameters: [:], encoding:URLEncoding.queryString)
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
