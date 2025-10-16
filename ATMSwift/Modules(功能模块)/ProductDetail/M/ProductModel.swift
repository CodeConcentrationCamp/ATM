//
//  ProductModel.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/28.
//

import UIKit
import HandyJSON

struct ProductModel: HandyJSON {
    var starve:String?
    var patent:String?
    var creatures:CreaturesModel?
    var plums:PlumsModel?
    var pumpkins:[PumpkinsModel]?
    
}

struct PlumsModel: HandyJSON{
    var later: String?
    var hum: String?
    var toward: String?
    var reversed: String?
    var seems: String?
    var potatoes: String?
    var stranger: String?
    var field: String?
    var cracky: String?
    var corn: String?
}

struct CreaturesModel: HandyJSON{
    var peaches:String?
    var amid:String?
}


struct PumpkinsModel: HandyJSON{
      var amid: String?
      var bigger: String?
      var lamps: String?
      var patent: String?
      var vines: String?
      var peaches: String?
      var suggestion: String?
}
