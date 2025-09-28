//
//  StandingModel.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/27.
//

import UIKit
import HandyJSON

struct OrderModel: HandyJSON {
    var standing:[StandingModel]?
}

struct StandingModel: HandyJSON{
    
    var reversed:String?
    var whites:WhitesModel?
    var medal:String?
}

struct WhitesModel: HandyJSON{
    var reversed:String?
    var departure:String?
    var generate:String?
    var hum:String?
    var paris:String?
    var medal:String?
    var likewise:String?
    var adjudged:String?
    var does:String?
    var accomplish:String?
    var gradual:String?
}
