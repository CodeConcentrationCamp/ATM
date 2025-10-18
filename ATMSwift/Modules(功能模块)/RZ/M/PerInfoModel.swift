//
//  PerInfoModel.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/16.
//

import HandyJSON

struct PerInfoModel:HandyJSON{
    // 咨询记录数组（包含 CounseledModel 类型）
      var counseled: [CounseledModel]?
}

struct CounseledModel:HandyJSON{
    var shook: String?
       var excited: String?
       var andy: String?
       var sailed: String?
       var lamps: String?
       
       // 包含 EighthModel 类型的数组
       var eighth: [EighthModel]?
       var amid: String?
       var bigger: String?
       
       // 嵌套的 CounseledModel 数组（自嵌套）
       var counseled: [CounseledModel]?
       var somewhere: String?
       var attached: String?
}


struct EighthModel:HandyJSON{
    // 单选框的key（字符串类型）
       var lamps: String?
       // 单选框的值（用于显示和回显）
       var subsided: String?
       var steel: String?
}
