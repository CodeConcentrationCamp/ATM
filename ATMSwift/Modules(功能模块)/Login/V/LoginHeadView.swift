//
//  LoginHeadView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/26.
//

import UIKit

class LoginHeadView: UIView {
    
    
    var isGXXY: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView().bb_ViewWithFrame(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height), backgroundColor: UIColor.clear)
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView(frame:CGRectZero)
        logoImageView.image = UIImage(named: "dl_logo")
        return logoImageView
    }()
    
    
    lazy var phoneNumBgImageView: UIImageView = {
        let phoneNumBgImageView = UIImageView(frame:CGRectZero)
        phoneNumBgImageView.image = UIImage(named: "dl_bg")
        phoneNumBgImageView.isUserInteractionEnabled = true
        let centerLabel = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "Cellphone Number", textColor: UIColorFromHex("0x183C59")! , fontSize: 14, textAlignment: .center)
        phoneNumBgImageView.addSubview(centerLabel)
        centerLabel.snp.makeConstraints { make in
            make.top.equalTo(13)
            make.centerX.equalTo(phoneNumBgImageView.snp.centerX)
        }
        return phoneNumBgImageView
    }()
    
    lazy var SMSBgImageView: UIImageView = {
        let SMSBgImageView = UIImageView(frame:CGRectZero)
        SMSBgImageView.image = UIImage(named: "dl_bg")
        SMSBgImageView.isUserInteractionEnabled = true
        let centerLabel = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "SMS Code", textColor: UIColorFromHex("0x183C59")! , fontSize: 14, textAlignment: .center)
        SMSBgImageView.addSubview(centerLabel)
        centerLabel.snp.makeConstraints { make in
            make.top.equalTo(13)
            make.centerX.equalTo(SMSBgImageView.snp.centerX)
        }
        return SMSBgImageView
    }()
    
    lazy var loginBgButton: UIImageView = {
        let loginBgButton = UIImageView(frame:CGRectZero)
        loginBgButton.image = UIImage(named: "dl_b")
        loginBgButton.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1 // 单击
        loginBgButton.addGestureRecognizer(tapGesture)
        return loginBgButton
    }()
    
    lazy var loginButton: UIImageView = {
        let loginButton = UIImageView(frame:CGRectZero)
        loginButton.image = UIImage(named: "Login")
        return loginButton
    }()
    
    
    lazy var agreementView: UIView = {
        let agreementView = UIView().bb_ViewWithFrame(frame: CGRectZero, backgroundColor: UIColor.white)
        agreementView.cornerRadius = 8
        agreementView.layer.borderColor = UIColorFromHex("0x1C1F1F")?.cgColor
        agreementView.layer.borderWidth = 1
        agreementView.isUserInteractionEnabled = true
        
        let imageV = UIImageView(frame: CGRectZero)
        imageV.image = UIImage(named: "money")
        agreementView.addSubview(imageV)
        imageV.snp.makeConstraints { make in
            make.width.height.equalTo(38)
            make.right.equalTo(-10)
            make.centerY.equalTo(agreementView.snp.centerY)
        }
        
        let titleLabel = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "By logging in, you agree to the", textColor: UIColorFromHex("0xA29B91")!, fontSize: 12, textAlignment: .left)
        agreementView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(38)
            make.centerY.equalTo(agreementView.snp.centerY).offset(-8)
        }
        
        let tipLable = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "'Privacy Policy'", textColor: UIColorFromHex("0x23BEC7")!, fontSize: 12, textAlignment: .left)
        agreementView.addSubview(tipLable)
        tipLable.snp.makeConstraints { make in
            make.left.equalTo(38)
            make.centerY.equalTo(agreementView.snp.centerY).offset(8)
        }
        return agreementView
    }()
    
    lazy var agreementBtn: UIButton = {
        let agreementBtn = UIButton(type: .custom)
        agreementBtn.setImage(UIImage(named: "id4"), for: .normal)
        agreementBtn.setImage(UIImage(named: "id3"), for: .selected)
        agreementBtn.addTarget(self, action: #selector(handleClick(_:)), for:.touchUpInside)
        return agreementBtn
    }()
    
    
    lazy var accountTextFiled: PhoneNumberTextField = {
        let accountTextFiled = PhoneNumberTextField(frame: .zero)
        accountTextFiled.font = UIFont.systemFont(ofSize: 15)
        accountTextFiled.textColor = Default_Black0_Color!
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor:UIColorFromHex("0xA29B91")!,
            // 可选：添加字体设置
            .font: UIFont.systemFont(ofSize: 14)
        ]
        
        let placeholder = NSAttributedString(string: "Cellphone number", attributes: attributes)
        accountTextFiled.attributedPlaceholder = placeholder
        accountTextFiled.addTarget(self, action:#selector(textFieldChangeMethod) , for: .editingChanged)
        let numLabel = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "+63  ", textColor: Default_Black0_Color!, fontSize: 14, textAlignment: .left)
        numLabel.font = UIFont.boldSystemFont(ofSize: 14)
        accountTextFiled.leftView = numLabel
        accountTextFiled.leftViewMode = .always
        return accountTextFiled
    }()
    
    lazy var codeTextFiled: UITextField = {
        let codeTextFiled = UITextField(frame: .zero)
        codeTextFiled.font = UIFont.systemFont(ofSize: 15)
        codeTextFiled.textColor = Default_Black0_Color!
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor:UIColorFromHex("0xA29B91")!,
            // 可选：添加字体设置
            .font: UIFont.systemFont(ofSize: 14)
        ]
        
        let placeholder = NSAttributedString(string: "SMS Code", attributes: attributes)
        
        codeTextFiled.keyboardType = .numberPad
        codeTextFiled.attributedPlaceholder = placeholder
        codeTextFiled.addTarget(self, action:#selector(textFieldChangeMethod) , for: .editingChanged)
        return codeTextFiled
    }()
    
    lazy var codeButton: UIButton = {
        let codeButton = UIButton(type: .custom)
        codeButton.setBackgroundImage(UIImage(named: "CodeBg"), for: .normal)
        codeButton.setTitle("Code", for: .normal)
        codeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        codeButton.setTitleColor(UIColorFromHex("0x183C59"), for: .normal)
        codeButton.addTarget(self, action: #selector(getSMSCode), for:.touchUpInside)
        return codeButton
    }()
    
    func initUI(){
        
        self.addSubview(bgView)
        bgView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(145)
            make.height.equalTo(123)
            make.top.equalTo(94)
            make.centerX.equalToSuperview()
        }
        
        bgView.addSubview(phoneNumBgImageView)
        phoneNumBgImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.centerX.equalTo(logoImageView.snp.centerX)
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
        }
        
        bgView.addSubview(SMSBgImageView)
        SMSBgImageView.snp.makeConstraints { make in
            make.left.equalTo(phoneNumBgImageView.snp.left)
            make.right.equalTo(phoneNumBgImageView.snp.right)
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneNumBgImageView.snp.bottom).offset(22)
        }
        
        bgView.addSubview(loginBgButton)
        loginBgButton.snp.makeConstraints { make in
            make.left.equalTo(SMSBgImageView.snp.left)
            make.right.equalTo(SMSBgImageView.snp.right)
            make.height.equalTo(46)
            make.top.equalTo(SMSBgImageView.snp.bottom).offset(40)
        }
        
        loginBgButton.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(47)
            make.height.equalTo(21)
            make.centerX.equalTo(loginBgButton.snp.centerX)
            make.centerY.equalTo(loginBgButton.snp.centerY)
        }
        
        bgView.addSubview(agreementView)
        agreementView.snp.makeConstraints { make in
            make.left.equalTo(loginBgButton.snp.left)
            make.right.equalTo(loginBgButton.snp.right)
            make.height.equalTo(46)
            make.top.equalTo(loginBgButton.snp.bottom).offset(26)
        }
        
        agreementView.addSubview(agreementBtn)
        agreementBtn.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.left.equalTo(10)
            make.centerY.equalTo(agreementView.snp.centerY)
        }
        
        phoneNumBgImageView.addSubview(accountTextFiled)
        accountTextFiled.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.bottom.equalTo(-5)
        }
        
        SMSBgImageView.addSubview(codeTextFiled)
        codeTextFiled.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.bottom.equalTo(-5)
        }
        
        SMSBgImageView.addSubview(codeButton)
        codeButton.snp.makeConstraints { make in
            make.right.equalTo(-15);
            make.width.equalTo(50);
            make.height.equalTo(28);
            make.centerY.equalTo(codeTextFiled.snp.centerY);
        }
    }
    
    
    @objc func handleClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isGXXY = !self.isGXXY
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



extension LoginHeadView{
    
    @objc func getSMSCode(){
        if accountTextFiled.text?.isEmpty ?? true {
            ShowTip.showMessage("Cellphone number cannot be empty")
            return
        }
        
        let accountNum = accountTextFiled.text!.replacingOccurrences(of: " ", with: "")
        LoginViewModel().getSMSCode(phoneNum:accountNum)
    }
    
    @objc func textFieldChangeMethod(_ textField: UITextField) {
        
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        if ((codeTextFiled.text?.isEmpty) == nil) {
            ShowTip.showMessage("SMS Code cannot be empty")
            return
        }
        let accountNum = accountTextFiled.text!.replacingOccurrences(of: " ", with: "")
        LoginViewModel().goLogin(phoneNum:accountNum , codeNum: codeTextFiled.text!)
    }
}


