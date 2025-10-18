//
//  FaceViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/30.
//

import UIKit

class FaceViewController: CustomBaseTableViewController {
    
    var productID:String = ""
    var selectTitle:String = ""
    var reflection:String = ""
    
    lazy var stepView: RZStepView = {
        let stepView = RZStepView(frame: CGRectMake(24, navigationFullHeight+20,KScreenWidth - 48 , 68), step: 1)
        stepView.clipsToBounds = true
        return stepView
    }()
    lazy var samllItemView: TopItemView = {
        let samllItemView = TopItemView(frame: CGRectMake(12, 12, KScreenWidth-54, 225), height: 225, topBg: "id5", titleStr: "Face")
        samllItemView.isUserInteractionEnabled = true
        return samllItemView
    }()
    lazy var nextStepButton: NextStepButton = {
        let nextStepButton = NextStepButton(frame: CGRect(x: 15, y:  KScreenHeight - 80 , width: KScreenWidth - 30, height: 50))
        nextStepButton.setClickHandler { [self] in
            addButtonClick()
        }
        return nextStepButton
    }()
    lazy var addButton: UIButton = {
        let addButton = UIButton(frame: .zero)
        addButton.setImage(UIImage(named: "rz15"), for: .normal)
        addButton.setBackgroundImage(UIImage(named: "rz60"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonClick), for: .touchUpInside)
        return addButton
    }()
    
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
            make.width.equalTo(164)
            make.height.equalTo(159)
            make.top.equalTo(51)
            make.centerX.equalTo(samllItemView.snp.centerX)
        }
        
        let errImg = UIImageView(frame: CGRectMake(15, CGRectGetMaxY(samllItemView.frame)+20, KScreenWidth - 60, 101))
        errImg.image = UIImage(named: "rz61")
        bgView.addSubview(errImg)
        self.view .addSubview(nextStepButton)
    }
    override func backClick() {
        PageRouter.jumpWanLiuBox(proID: self.productID)
    }
}

extension FaceViewController{
    
    @objc func addButtonClick(){
        PhotoLibraryManager.shared.openCamera(from: self,state: true) { [weak self] image in
            if image == nil{
                return
            }
            self!.takePhone(image: image!)
        }
    }
    // 上传图片
    func takePhone(image:UIImage?){
        let viewModel = RZViewModel()
        viewModel.getKYCVerID(image: image!, reflection: "2", says: self.productID, lamps: "10", church: self.selectTitle, submit: "1")
        viewModel.upDataBlock = { state, mm in
            if state == "success"{
                let vc = PerInfoViewController()
                vc.productID = self.productID
                vc.state = "0"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
