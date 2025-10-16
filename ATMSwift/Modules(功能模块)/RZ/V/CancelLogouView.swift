//
//  CancelLogouView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/16.
//

import UIKit

class CancelLogouView: UIView {
    
    // cancle closeButton
    var cancelHander: ((_ customView:CancelLogouView) -> Void)?
    //left Button
    var leftHander: ((_ customView:CancelLogouView) -> Void)?
    
    
      private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
  private  lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "common1"), for: .normal)
      closeButton.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        return closeButton
    }()
    
    private lazy var topImageView: UIImageView = {
        let topImageView = UIImageView(frame: .zero)
        topImageView.tintColor = Default_BackGround_Color!
        return topImageView
    }()
    
    private lazy var tipLabel: UILabel = {
        tipLabel = UILabel().bb_LabelWithFrame(frame: .zero, text: "", textColor: .white, fontSize: 12, textAlignment: .center)
        tipLabel.numberOfLines = 0
        tipLabel.font = UIFont.boldSystemFont(ofSize: 13)
        return tipLabel
    }()
    
    var isSelect: Bool = false {
          didSet {
              // 状态变化时更新 UI
              tipButton.setImage(isSelect ? UIImage(named: "id3") : UIImage(named: "id4"), for: .normal)
          }
      }
    
    private  lazy var tipButton: UIButton = {
        
        let tipButton = UIButton(type: .custom)
        tipButton.setTitle("I have read and agree to the above", for: .normal)
        tipButton.setImage(UIImage(named: "id3"), for: .normal)
        tipButton.setTitleColor(UIColorFromHex("0xA29B91"), for: .normal)
        tipButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        tipButton.setImagePosition(.left, spacing: 5)
      
        tipButton.addTarget(self, action: #selector(tipButtonClick), for: .touchUpInside)
        return tipButton
    }()
     
    @objc func tipButtonClick(sender:UIButton){
        self.isSelect = !self.isSelect
    }
    
    
    lazy var logOutBtn: UIButton = {
        logOutBtn = UIButton(frame: .zero)
        logOutBtn.setBackgroundImage(UIImage(named: "tc_tc_b"), for: .normal)
        logOutBtn.setBackgroundImage(UIImage(named: "tc_tc_b"), for: .highlighted)
        logOutBtn.addTarget(self, action: #selector(logOutBtnClick), for: .touchUpInside)
        return logOutBtn
    }()
    
    
    
    @objc func logOutBtnClick(){
        self.leftHander?(self)
    }
    
    lazy var cancelBtn: UIButton = {
        cancelBtn = UIButton(frame: .zero)
        cancelBtn.setBackgroundImage(UIImage(named: "tc_tc_b_01"), for: .normal)
        cancelBtn.setBackgroundImage(UIImage(named: "tc_tc_b_01"), for: .highlighted)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    @objc func cancelBtnClick(){
        self.cancelHander?(self)
    }
    
    init(frame: CGRect,type: Int,
         cancelHander:((_ customView:CancelLogouView) -> Void)?,
         leftHander:((_ customView:CancelLogouView) -> Void)?
    ) {
        super.init(frame: frame)
        self.cancelHander = cancelHander
        self.leftHander = leftHander
        let imageString = (type==0 || type == 2) ? "tc_tc_bg" : "zx_tc_bg"
        imageView.image = UIImage(named: imageString)
        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.equalTo(345)
            make.height.equalTo((type == 0 || type == 2) ? 280 : 320)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-50)
        }
        
        self.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.centerX.equalTo(imageView.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(15)
        }
        
        var imageTopString: String
        switch type {
        case 0:
            imageTopString = "Logout"
        case 1:
            imageTopString = "CancelAccount"
        case 2:
            imageTopString = "GiveUp"
        default:
            // 根据实际需求设置默认值，例如空字符串或其他默认值
            imageTopString = ""
        }
        topImageView.image = UIImage(named: imageTopString)
        imageView.addSubview(topImageView)
        topImageView.snp.makeConstraints { make in
            make.centerX.equalTo(imageView.snp.centerX)
            make.width.equalTo((type == 0 || type == 2) ? 61 : 136)
            make.top.equalTo(42)
            make.height.equalTo(16)
        }
        
        var tt: String
        switch type {
        case 0:
            tt = "Feel safe when you leave temporarily, and exit with confidence. Automatically clear temporary data, leaving no trace of your privacy."
        case 1:
            tt = "Are you sure you want to log out? You will need to log in again after logging out. Any unfinished operations may be interrupted. Safety protection starts with standard operation."
        case 2:
            tt = "Completing the authentication information can increase your chances of obtaining loan approval."
        default:
            // 处理未匹配的 type（根据实际需求设置默认文本，例如空字符串）
            tt = ""
        }
        
        imageView.addSubview(tipLabel)
        tipLabel.text = tt
        tipLabel.snp.makeConstraints { make in
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.top.equalTo(topImageView.snp.bottom).offset(14)
        }
        
        
        if type == 1{
            imageView.addSubview(tipButton)
            tipButton.snp.makeConstraints { make in
                make.left.equalTo(tipLabel.snp.left)
                make.top.equalTo(200)
            }
        }
        
        imageView.addSubview(logOutBtn)
        logOutBtn.setImage(UIImage(named: imageTopString), for: .normal)
        logOutBtn.snp.makeConstraints { make in
            make.width.equalTo(126)
            make.height.equalTo(38)
            make.left.equalTo(42)
            make.bottom.equalTo(imageView.snp.bottom).offset(-18)
        }
        
        var imageString1: String
        if type == 0 || type == 1 {
            imageString1 = "Cancel"
        } else if type == 2 {
            imageString1 = "Continue"
        } else {
            // 处理 type 为其他值的情况，根据实际需求设置默认值
            imageString1 = ""
        }
        
        cancelBtn.setImage(UIImage(named: imageString1), for: .normal)
        imageView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.width.equalTo(126)
            make.height.equalTo(38)
            make.right.equalTo(-42)
            make.centerY.equalTo(logOutBtn.snp.centerY)
        }
        
        
        
        
        
    }
    
    @objc private func closeTapped() {
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
