//
//  ResponseModel.swift
//  WuZhouLoanSwift
//
//  Created by binbin.c on 2023/10/11.
//

import UIKit
import HandyJSON

class ResponseModel:HandyJSON{

    var code:Int?
    var msg:String?
    var data:Dictionary<String, Any>?
    
    var list:Array<Any>?
    var valueData:String?
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {

     mapper.specify(property: &code, name: "shook")
     mapper.specify(property: &data, name: "trip")
     mapper.specify(property: &msg, name: "chums")
   }
}


