//
//  HomeViewModel.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/26.
//

import UIKit
import Combine


class HomeViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
   
    @Published var isDataLoaded: Bool = false // 新增一个发布者标识数据加载状态
   
    
    // MARK: - 处理 HeadView 数据 （供 View 直接使用）
    var investMoney: String = ""
    var rate: String = ""
    var day: String = ""
    var titleArray: [String] = []
    var urlArray: [String] = []
    // UI 状态（供 View 绑定，无需 View 计算）
    var isYqBgHidden: Bool = true // yqBgImageView 是否隐藏
    var viewHeight: CGFloat = 410 // 视图高度
    var topBgImageName: String = "home11" // 顶部背景图名称
    var adaptHeadHeight: CGFloat = 0.0
    var isShowFoot: Bool = false
    
    @Published var homeModel:HomeModel?{
        didSet{
            processData()
            isDataLoaded = true 
        }
    }
    
    // MARK: - 处理数据和计算 UI 状态
     private func processData() {
         self.investMoney = homeModel?.glow?.filaments?.first?.wiped ?? ""
         self.rate = homeModel?.glow?.filaments?.first?.gives ?? ""
         self.day = homeModel?.glow?.filaments?.first?.repairs ?? ""
         self.adaptHeadHeight =  (homeModel?.lighting?.lamps == "groundd" && homeModel?.glow?.lamps == "groundc") ? 450 : 410
         self.isShowFoot =  homeModel?.xx == "1" && homeModel?.glow?.lamps == "groundb" ? true : false
         
         // 解析 titleArray 和 urlArray
         guard let filaments = homeModel?.lighting?.filaments, !filaments.isEmpty else {
             titleArray = []
             urlArray = []
             return
         }
         titleArray = filaments.compactMap { $0.chums }
         urlArray = filaments.compactMap { $0.patent }
         
         // 计算 UI 状态
         let isSpecialCase = homeModel?.lighting?.lamps == "groundd" && homeModel?.glow?.lamps == "groundc"
         isYqBgHidden = !isSpecialCase
         viewHeight = isSpecialCase ? 450 : 410
         topBgImageName = isSpecialCase ? "home1" : "home11"
     }
    
    // MARK: - Net
    func homeDetail(){
        HomeService.shared.fetchHomeDetail { result in
            switch result{
            case .success(let model):
                   // 处理成功数据（更新UI等）
                   print("获取数据成功：\(model)")
                self.homeModel = model
               case .failure(let error):
                   // 处理错误（提示用户等）
                   print("获取数据失败：\(error.localizedDescription)")
               }
        }
    }
    
    //处理 Go Borrow 按钮
    func goBorrowTapped(_ vc:UIViewController){
        clickApply(proID: homeModel?.glow?.filaments?.first?.later!)
        upClickDataBlock = { patent in
            BBAllLog("当前的请求跳转URL:\(patent)")
            if patent.isEmpty == false{
                PageRouter.schemeType(patent, vc: vc)
            }
        }
    }
    
    
    

    var upClickDataBlock:((_ patent:String) -> (Void))?
    
    
    // - numofrow
    func numRowHeight() -> Int {
        homeModel?.candle?.lamps == "grounde" && homeModel?.glow?.lamps == "groundc"
            ? homeModel?.candle?.filaments?.count ?? 0
            : 0
    }
    
    func getCellModel() -> [ProductDeatilModel]?{
        homeModel?.candle?.filaments
    }
    
    
    func clickApply(proID:String?){
        
        guard let proID = proID else {
               ShowTip.showMessage("Invalid product ID")
               return
           }
        
        NetworkManager.shared.request(API.clickProduct(proID: proID), modelType: HomeModel.self) { mm, responseModel in
            self.upClickDataBlock?(mm.patent!)
        } failure: { error,responseModel in
        }
    }
    
    
    func homeCardAndItemCellClick(hoemModel:HomeModel?,proID:String?,vc:UIViewController){
        if homeModel == nil{
            ShowTip.showMessage("Data not obtained")
        }
        
        if hoemModel?.overhauling == "1"{
            
        }else{
            
        }
    }
    
    
    
}
