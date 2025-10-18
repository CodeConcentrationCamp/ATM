//
//  IDCardFinishView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/15.
//

import UIKit

class IDCardFinishView: UIView {
    
    var closeHandler: ((_ customView:IDCardFinishView) -> Void)?
    var commitHandler: ((_ customView:IDCardFinishView,_ name:String?,_ num:String?,_ dateBirth:String?) -> Void)?
    
    lazy var dayLabel: UILabel = {
        let dayLabel = UILabel().bb_LabelWithFrame(frame: .zero, text: "", textColor: Default_Black0_Color, fontSize: 14, textAlignment: .center)
        return dayLabel
    }()
    
    lazy var nameTextFild: UITextField = {
        nameTextFild = UITextField(frame: .zero)
        nameTextFild.font = UIFont.systemFont(ofSize: 14)
        nameTextFild.textColor = Default_Black3_Color
        nameTextFild.textAlignment = .center
        return nameTextFild
    }()
    
    lazy var idTextFild: UITextField = {
        idTextFild = UITextField(frame: .zero)
        idTextFild.font = UIFont.systemFont(ofSize: 14)
        idTextFild.textColor = Default_Black3_Color
        idTextFild.textAlignment = .center
        return idTextFild
    }()
    
    lazy var nextStepButton: NextStepButton = {
        let nextStepButton = NextStepButton(frame:CGRectZero)
        nextStepButton.setClickHandler { [self] in
            self.commitHandler?(self,self.nameTextFild.text,self.idTextFild.text,self.dayLabel.text)
        }
        return nextStepButton
    }()
    
    lazy var closeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "common1"), for: .normal)
        btn.addTarget(self, action: #selector(closeButtonClick), for: .touchUpInside)
        return btn
    }()
    
    @objc func closeButtonClick(){
        self.closeHandler?(self)
    }
    
    init(frame: CGRect,name:String?,num:String?,data:String?, closeHandler: ((_ customView:IDCardFinishView) -> Void)?,commitHandler: ((_ customView:IDCardFinishView,_ name:String?,_ num:String?,_ dateBirth:String?) -> Void)?) {
        super.init(frame: frame)
        self.closeHandler = closeHandler
        self.commitHandler = commitHandler
        let bgView = UIImageView(frame: .zero)
        bgView.image = UIImage(named: "rz40")
        bgView.isUserInteractionEnabled = true
        bgView.contentMode = .scaleToFill;
        self.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(325)
            make.height.equalTo(444)
        }
        
        let topImg = UIImageView(frame: .zero)
        topImg.image = UIImage(named: "rz41")
        bgView.addSubview(topImg)
        topImg.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(27)
            make.width.equalTo(230)
            make.height.equalTo(19)
        }
        
        let card1 = UIImageView(frame: .zero)
        card1.image = UIImage(named: "rz42")
        card1.isUserInteractionEnabled = true
        bgView.addSubview(card1)
        card1.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(topImg.snp.bottom).offset(10)
            make.height.equalTo(86)
        }
        
        let cardL = UILabel().bb_LabelWithFrame(frame: .zero, text: "Full Name", textColor: Default_Black3_Color, fontSize: 14, textAlignment: .center)
        cardL.font = UIFont.boldSystemFont(ofSize: 14)
        card1.addSubview(cardL)
        cardL.snp.makeConstraints { make in
            make.centerX.equalTo(card1.snp.centerX)
            make.top.equalTo(card1.snp.top).offset(12)
        }
        
        card1.addSubview(nameTextFild)
        nameTextFild.snp.makeConstraints { make in
            make.centerX.equalTo(card1.snp.centerX)
            make.bottom.equalTo(-3)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(44)
        }
        
        let card2 = UIImageView(frame: .zero)
        card2.image = UIImage(named: "rz42")
        card2.isUserInteractionEnabled = true
        bgView.addSubview(card2)
        card2.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(86)
            make.top.equalTo(card1.snp.bottom).offset(15)
            make.centerX.equalTo(bgView.snp.centerX)
        }
        
        card2.addSubview(idTextFild)
        idTextFild.snp.makeConstraints { make in
            make.centerX.equalTo(card2.snp.centerX)
            make.bottom.equalTo(-3)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(44)
        }
        
        let card2L = UILabel().bb_LabelWithFrame(frame: .zero, text: "ID NO.", textColor: Default_Black3_Color, fontSize: 14, textAlignment: .center)
        card2L.font = UIFont.boldSystemFont(ofSize: 14)
        card2.addSubview(card2L)
        card2L.snp.makeConstraints { make in
            make.centerX.equalTo(card2.snp.centerX)
            make.top.equalTo(card2.snp.top).offset(12)
        }
        
        let card3 = UIImageView(frame: .zero)
        card3.image = UIImage(named: "rz42")
        card3.isUserInteractionEnabled = true
        bgView.addSubview(card3)
        card3.isUserInteractionEnabled = false
        card3.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(86)
            make.top.equalTo(card2.snp.bottom).offset(15)
            make.centerX.equalTo(bgView.snp.centerX)
        }
        
        let card3L = UILabel().bb_LabelWithFrame(frame: .zero, text: "Date of Birth", textColor: Default_Black3_Color, fontSize: 14, textAlignment: .center)
        card3L.font = UIFont.boldSystemFont(ofSize: 14)
        card3.addSubview(card3L)
        card3L.snp.makeConstraints { make in
            make.centerX.equalTo(card3.snp.centerX)
            make.top.equalTo(card3.snp.top).offset(12)
        }
      
        card3.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.centerX.equalTo(card3.snp.centerX)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(-3)
            make.height.equalTo(44)
        }
        
        let dayRButton = UIButton(type: .custom)
        dayRButton.setImage(UIImage(named: "rz43"), for: .normal)
        card3.addSubview(dayRButton)
        dayRButton.snp.makeConstraints { make in
            make.centerY.equalTo(dayLabel.snp.centerY);
            make.right.equalTo(-20)
            make.width.equalTo(10)
            make.height.equalTo(14)
        }
        
        bgView.addSubview(nextStepButton)
        nextStepButton.snp.makeConstraints { make in
            make.width.equalTo(246);
            make.height.equalTo(43);
            make.centerX.equalTo(bgView.snp.centerX);
            make.bottom.equalTo(bgView.snp.bottom).offset(-22);
        }
        self.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(15)
            make.centerX.equalTo(bgView.snp.centerX)
            make.width.height.equalTo(34)
        }
        
     
        self.nameTextFild.text = name ?? ""
        self.idTextFild.text = num ?? ""
        self.dayLabel.text = data ?? ""
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
