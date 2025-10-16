//
//  VerIDViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/13.
//

import UIKit
import HandyJSON

class VerIDViewController: CustomBaseTableViewController {
    
    var productID:String = ""
    var selectTitle:String = ""
    var reflection:String = ""
    
    lazy var stepView: RZStepView = {
        let stepView = RZStepView(frame: CGRectMake(24, navigationFullHeight+20,KScreenWidth - 48 , 68), step: 1)
        stepView.clipsToBounds = true
        return stepView
    }()
    
    
    lazy var samllItemView: TopItemView = {
        let samllItemView = TopItemView(frame: CGRectMake(12, 12, KScreenWidth-54, 225), height: 225, topBg: "id5", titleStr: self.selectTitle)
        samllItemView.isUserInteractionEnabled = true
        return samllItemView
    }()
    
    
    lazy var nextStepButton: NextStepButton = {
        let nextStepButton = NextStepButton(frame: CGRect(x: 15, y:  KScreenHeight - 80 , width: KScreenWidth - 30, height: 50))
        nextStepButton.setClickHandler { [self] in
            
        }
        return nextStepButton
    }()
    
    
    lazy var addButton: UIButton = {
        let addButton = UIButton(frame: .zero)
        addButton.setImage(UIImage(named: "rz15"), for: .normal)
        addButton.setBackgroundImage(UIImage(named: "rz14"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonClick), for: .touchUpInside)
        return addButton
    }()
    
    @objc func addButtonClick(){
        let viewModel = RZViewModel()
        let phoneBox = PhoneBoxView(frame: CGRectMake(0, 0, KScreenWidth, 209+50)) { customView in
            self.reflection = "1"
            PopupAnimator.shared.dismiss(view: customView)
            PhotoLibraryManager.shared.openPhotoLibrary(from: self) { [weak self] image in
                if image == nil{
                    return
                }
                viewModel.getKYCVerID(image: image!, reflection: self!.reflection, says: self!.productID, lamps: "11", church: self!.selectTitle, submit: "1")
                viewModel.upDataBlock = { state, mm in
                    if state == "success"{
                        let finishView = IDCardFinishView(frame: CGRectMake(0, 0, KScreenWidth, KScreenHeight), name: mm?.subsided, num: mm?.excitement ,data: mm?.slice) { customView in
                            PopupAnimator.shared.dismiss(view: customView)
                        } commitHandler:{ customView in
                            viewModel.saveUserInfo(withId: self?.productID ?? "", subsided: (mm?.subsided)!, excitement: mm?.excitement ?? "", slice: mm?.slice ?? "", church: self?.selectTitle ?? "") { isSuccess, msg in
                                if isSuccess{
                                    PopupAnimator.shared.dismiss(view: customView)
                                    let vc = FaceViewController()
                                    vc.productID = self?.productID
                                    vc.titleString = self?.selectTitle
                                    self?.navigationController?.pushViewController(vc, animated: true)
                                }else{
                                    ShowTip.showMessage(msg)
                                }
                            }
                        }
                        PopupAnimator.shared.present(
                            view: finishView,
                            type: .fromCenter){}
                    }
                }
            }
        } cameraHandler: { customView in
            self.reflection = "2"
            PopupAnimator.shared.dismiss(view: customView)
        } closaHandler: { customView in
            PopupAnimator.shared.dismiss(view: customView)
        }
        
        PopupAnimator.shared.present(
            view: phoneBox,
            type: .fromBottom){
                
            }
    }
    
    override func backClick() {
        PageRouter.jumpWanLiuBox(proID: self.productID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Verify Identity"
        self.view.addSubview(stepView)
        
        let bgView = UIImageView(frame: CGRectMake(15, CGRectGetMaxY(self.stepView.frame), KScreenWidth - 30, 374))
        bgView.image = UIImage(named: "rz6")
        bgView.isUserInteractionEnabled = true
        self.view.addSubview(bgView)
        
        bgView.addSubview(samllItemView)
        samllItemView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.width.equalTo(240)
            make.height.equalTo(159)
            make.top.equalTo(51)
            make.centerX.equalTo(samllItemView.snp.centerX)
        }
        
        let errImg = UIImageView(frame: CGRectMake(15, CGRectGetMaxY(samllItemView.frame)+20, KScreenWidth - 60, 101))
        errImg.image = UIImage(named: "rz13")
        bgView.addSubview(errImg)
        self.view .addSubview(nextStepButton)
        
    }
    
}
