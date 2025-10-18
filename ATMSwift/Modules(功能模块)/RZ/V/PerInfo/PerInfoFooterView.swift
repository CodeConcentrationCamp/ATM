//
//  PerInfoFooterView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/16.
//

import UIKit


class PerInfoCellView: UIView{
    
    // MARK: - 属性
    lazy var model:CounseledModel  = {
        let model = CounseledModel()
        return model
    }()
    
    lazy var textFiled: UITextField = {
        let textFiled = UITextField(frame: .zero)
        textFiled.font = UIFont.boldSystemFont(ofSize: 14)
        textFiled.textColor =  UIColorFromHex("0X1C1F1F")
        textFiled.textAlignment = .center
        textFiled.addTarget(self, action: #selector(textFieldChangeMethod), for: .editingChanged)
        textFiled.isHidden = true
        return textFiled
    }()
    
    lazy var titleL: UILabel = {
        let titleL = UILabel().bb_LabelWithFrame(frame: .zero, text:"", textColor: Default_Black0_Color, fontSize: 14, textAlignment: .center)
        return titleL
    }()
    
    lazy var putLabel: UILabel = {
        let putLabel = UILabel().bb_LabelWithFrame(frame: .zero, text: "", textColor: UIColorFromHex("0xA29B91")!, fontSize: 14, textAlignment: .center)
        putLabel.font = UIFont.boldSystemFont(ofSize: 14)
        putLabel.isHidden = true
        putLabel.isUserInteractionEnabled = true
        putLabel.addTapGesture { [weak self] tap in
            guard let self = self else {
                return
            }
            self.jumpCell()
                     
        }
        return putLabel
    }()
    
    
    
    typealias ValueBlock = (String, String) -> Void
    var myBlock: ValueBlock?
    

    
    @objc func textFieldChangeMethod(){
        if (self.myBlock != nil){
            self.myBlock?(self.textFiled.text!,self.model.shook!)
        }
    }
    
   
    
    
 
    
    
    func jumpCell(){
        // 统一处理标签文字颜色（避免重复赋值）
        let targetTextColor = Default_Black0_Color ?? .black

        // 根据 excited 类型分支处理，用 switch 替代多个 if，逻辑更聚焦
        switch self.model.excited {
        case "groundk":
            // 创建单选弹窗，简化闭包参数捕获
            let danXunBox = DanGeXuanZeView(
                frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight),
                mm: self.model,
                title: self.model.amid,
                normalDate: self.putLabel.text ?? ""
            ) { customView in
                PopupAnimator.shared.dismiss(view: customView)
            } commitHandler: { [weak self] customView, value in
                guard let self = self, let value = value, !value.isEmpty else {
                    PopupAnimator.shared.dismiss(view: customView)
                    return
                }
                // 更新标签并触发回调
                self.putLabel.text = value
                self.putLabel.textColor = targetTextColor
                self.model.eighth?.forEach { mm in
                    if mm.subsided == value {
                        self.myBlock?(mm.lamps ?? "", self.model.shook ?? "")
                    }
                }
                PopupAnimator.shared.dismiss(view: customView)
            }
            PopupAnimator.shared.present(view: danXunBox)
            
        case "groundm":
            // 创建地址选择弹窗，简化回调逻辑
            let addressSelectView = AddressCictSelectView()
            addressSelectView.confirmHandler = { [weak self] selectedRegion in
                guard let self = self else { return }
                self.putLabel.text = selectedRegion
                self.putLabel.textColor = targetTextColor
                self.myBlock?(selectedRegion, self.model.shook ?? "")
            }
            addressSelectView.show()
            
        default:
            // 可添加默认分支（如异常处理），避免漏处理其他 excited 类型
            break
        }
    }
    
    lazy var backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.isHidden = true
        backButton.setImage(UIImage(named: "rz43"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        return backButton
    }()
    
    @objc func backButtonClick(){
        jumpCell()
    }
    
    init(frame: CGRect,model:CounseledModel,state:String?,isCard:Bool,isPic:Bool) {
        super.init(frame: frame)
        
        self.model = model;
        
        let bgView = UIImageView(frame: CGRectMake(0, 0, self.width, self.height))
        bgView.image = UIImage(named: "info3")
        bgView.isUserInteractionEnabled = true
        self.addSubview(bgView)
        
        bgView.addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.centerX.equalTo(bgView.snp.centerX)
            make.top.equalTo(13)
        }
        
        self.titleL.text = model.amid
        
        bgView.addSubview(putLabel)
        putLabel.snp.makeConstraints { make in
            make.centerX.equalTo(bgView.snp.centerX)
            make.top.equalTo(titleL.snp.bottom).offset(25)
            if isPic && isCard{}else{
                make.left.equalTo(50)
                make.right.equalTo(-50)
            }
        }
        
        if (isCard && isPic) {
            
        }
        
        bgView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalTo(putLabel.snp.centerY)
            make.width.equalTo(10)
            make.height.equalTo(14)
        }
        
        
        if model.excited == "groundk"{
            //单选
            if isCard{
                
            }else{
                self.putLabel.text = state == "1" ? model.sailed:model.bigger
                self.putLabel.textColor = state == "1" ?Default_Black0_Color:UIColorFromHex("0xA29B91")
            }
            self.putLabel.isHidden = false
            backButton.isHidden = false
        }
        
        bgView.addSubview(self.textFiled)
        self.textFiled.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(-3)
            make.height.equalTo(40)
            make.centerX.equalTo(bgView.snp.centerX)
        }
        
        if model.excited == "groundl"{
            // 输入框
            self.textFiled.isHidden = false
            if isCard {
                self.textFiled.text = model.sailed
            }else{
                self.textFiled.text = state == "1" ? model.sailed : ""
            }
            // 创建富文本属性（设置占位文字颜色）
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColorFromHex("0xA29B91")!
            ]

            let placeholder = NSAttributedString(string: model.bigger ?? "", attributes: attributes)
            self.textFiled.attributedPlaceholder = placeholder
            // 根据条件设置键盘类型（mm.andy 为 "1" 时使用数字键盘，否则使用默认键盘）
            self.textFiled.keyboardType = model.andy == "1" ? .numberPad : .default
            
        }
        
        if model.excited == "groundm"{
            self.putLabel.text = state == "1" ? model.sailed:model.bigger;
            self.putLabel.textColor = state == "1" ? Default_Black0_Color : UIColorFromHex("0xA29B91")!;
            self.putLabel.isHidden = false;
            backButton.isHidden = false;
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class PerInfoFooterView: UIView {

    typealias ValueBlock = (String, String) -> Void
    var myBlock: ValueBlock?
    
    init(frame: CGRect,model:PerInfoModel,state:String?) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        
        let bgView = UIImageView(frame: CGRectMake(15, 10, KScreenWidth - 30, self.height - 15))
        bgView.isUserInteractionEnabled = true
        bgView.image = UIImage(named: "info2")
        self.addSubview(bgView)
        
        for i in 0..<model.counseled!.count {
            let perView = PerInfoCellView(frame: CGRectMake(15, CGFloat(15+(100)*i), KScreenWidth - 60, 86), model: model.counseled![i], state: state, isCard: false, isPic: false)
            perView.myBlock = { [self] value, key in
                self.myBlock?(value,key)
            }
            bgView.addSubview(perView)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
