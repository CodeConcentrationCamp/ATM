//
//  HomeModel.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/26.
//

import UIKit
import HandyJSON
struct HomeModel: HandyJSON {
    var glow: ProducrModel?
    var lighting:ProducrModel?
    var candle:ProducrModel?
    var mermaid:ProducrModel?
    var xx:String?   //  首页1大卡位下面的模块    显示状态，1表示显示，0表示不显示
    /*
     ！！！重中之重！！！： 强制定位字段：1强制，0不强制，
       当等于1时候，点击申请需要判断是否有定位权限，如果有正常跳转，如果没有，点击申请不要调用接口，只弹出提示弹窗，点击弹窗跳转系统设置，和不给相机权限效果类似
       当等于0时候，点击申请正常跳转，不用判断是否有定位权限
     */
     
    var overhauling:String?
}

struct ProducrModel : HandyJSON{
    var lamps:String?
    var filaments:[ProductDeatilModel]?
}

struct ProductDeatilModel: HandyJSON{
  
    var later:String?   //产品ID 点击申请按钮从这拿产品ID
    var hum:String?  // 产品名称
    var generate:String? // 图片
    var waste:String?  // 大/小卡位按钮的文案
    var wiped:String?  //贷款金额
    var inventor:String?  //贷款金额的描述文案
    var repairs:String? //贷款期限
    var lack:String? //
    var handicapped:String? //贷款期限的描述文案
    var gives:String? //贷款利率
    var apparatus:String? //贷款利率的描述文案

    var torch:String? //List money
    var cracky:String?
    
    var chums:String? //显示文案，直接展示
    var patent:String?  //跳转地址：一般是个H5的地址，直接跳转就行
}
