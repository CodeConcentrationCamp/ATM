//
//  VerIDModel.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/30.
//

import Foundation
import HandyJSON

struct VerIDModel:HandyJSON{
    var steeple:SteepleMdoel?
    var remarked:String?
    var patent:String?
    var sport:[[String]]?
    var lamps:String?
    
    // 相册获取数据
    var subsided:String?
    var excitement:String?
    var slice:String?
}


struct SteepleMdoel:HandyJSON{
    var vines:String?
    var patent:String?
    var church:String?
    var taller:TallerModel?
}

struct TallerModel:HandyJSON{
    var subsided:String?
    var excitement:String?
    var slice:String?
}
