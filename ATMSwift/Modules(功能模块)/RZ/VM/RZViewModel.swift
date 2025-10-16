//
//  RZViewModel.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/30.
//

import UIKit

class RZViewModel: NSObject {
    var verIDModel : VerIDModel?
    
    // - 数据源更新
    var upDataBlock:((String,VerIDModel?) -> (Void))?
    
    func saveUserInfo(withId productID: String, subsided: String, excitement:String, slice:String,church:String,completion: @escaping (Bool, String) -> Void) {
        ShowTip.showLoading()
        NetworkManager.shared.request(API.saveUserInfo(proID: productID, subsided: subsided, excitement:excitement, slice: slice, church: church), modelType: ResponseModel.self) { mm, responseModel in
            ShowTip.hideLoading()
            if responseModel.code == 0 {
                DispatchQueue.main.async {
                    completion(true, responseModel.msg ?? "")
                }
            }else{
                DispatchQueue.main.async {
                    completion(false, responseModel.msg ?? "")
                }
            }
        }failureCallback: { responseModel in
            completion(false, responseModel.msg ?? "")
            ShowTip.hideLoading()
        }
    }
    
    
    func getKYCVerID(image: UIImage, reflection: String,says: String,lamps: String,church: String,submit :String,ruling: String = ""){
        ShowTip.showLoading()
        let imageWaterData =  ShowTip.resetSize(ofImageData: image, maxSize: 800)
        NetworkManager.shared.request(API.uploadAvatar(imageData: imageWaterData, reflection: "10", says: says, lamps: "11", church: church, submit: "1", ruling: ""), modelType: VerIDModel.self) { mm, responseModel in
            ShowTip.hideLoading()
            self.verIDModel = mm
            self.upDataBlock?("success",mm)
        }failureCallback: { responseModel in
            ShowTip.hideLoading()
        }
    }
    
    func getUserInfo(proID:String?){
        ShowTip.showLoading()
        NetworkManager.shared.request(API.getUserInfo(proID: proID ?? ""), modelType: VerIDModel.self) { [self] mm, responseModel in
            ShowTip.hideLoading()
            self.verIDModel = mm
            self.upDataBlock?("success",mm)
        } failureCallback: { responseModel in
            
        }
    }
    
    func getOrderUrl(toward:String?){
        ShowTip.showLoading()
        NetworkManager.shared.request(API.orderIDGetUrl(westwards: toward!), modelType: VerIDModel.self) { mm, responseModel in
          //  print(responseModel)
            ShowTip.hideLoading()
            let url = responseModel.data!["patent"] as? String ?? ""
            if url.isEmpty == false{
                ToolManager.shared.jumpWebWithUrl(url: url)
            }
        } failureCallback: { responseModel in
            
        }
    }
    
    
}
