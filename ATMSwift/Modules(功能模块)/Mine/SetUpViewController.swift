//
//  SetUpViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/27.
//

import UIKit

class SetUpViewController: BaseViewController {

    lazy var topImageView: UIImageView = {
        let topImageView = UIImageView(frame: .zero)
        topImageView.image = UIImage(named: "sz_banner")
        return topImageView
    }()
    
    
    lazy var centerImageView: UIImageView = {
        let centerImageView = UIImageView(frame: .zero)
        centerImageView.image = UIImage(named: "sz_bg")
        centerImageView.isUserInteractionEnabled = true
        return centerImageView
    }()
    
    
    lazy var versionImageView: UIImageView = {
        let versionImageView = UIImageView(frame: .zero)
        versionImageView.image = UIImage(named: "sz_bg_01")
        versionImageView.isUserInteractionEnabled = true
        
        let picImageView = UIImageView(frame: .zero)
        picImageView.image = UIImage(named: "sz_v_ic")
        versionImageView.addSubview(picImageView)
        picImageView.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.centerY.equalTo(versionImageView.snp.centerY)
            make.width.height.equalTo(36)
        }
        
        let titleLabel = UILabel().bb_LabelWithFrame(frame: .zero, text: "Version", textColor: UIColorFromHex("0x183C59")!, fontSize: 14, textAlignment: .left)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        versionImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(picImageView.snp.right).offset(12)
            make.centerY.equalTo(picImageView.snp.centerY)
        }
        
        let versionLabel = UILabel().bb_LabelWithFrame(frame: .zero, text: "1.0.0", textColor: UIColorFromHex("0xA29B91")!, fontSize: 14, textAlignment: .right)
        versionImageView.addSubview(versionLabel)
        versionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        versionLabel.snp.makeConstraints { make in
            make.right.equalTo(versionImageView.snp.right).offset(-12)
            make.centerY.equalTo(picImageView.snp.centerY)
        }
        return versionImageView
    }()
    
    lazy var logoutImageView: UIImageView = {
        let logoutImageView = UIImageView(frame: .zero)
        logoutImageView.image = UIImage(named: "sz_bg_01")
        logoutImageView.isUserInteractionEnabled = true
        
        let picImageView = UIImageView(frame: .zero)
        picImageView.image = UIImage(named: "sz_l_ic")
        logoutImageView.addSubview(picImageView)
        picImageView.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.width.height.equalTo(36)
            make.centerY.equalTo(logoutImageView.snp.centerY)
        }
        
        let titleLabel = UILabel().bb_LabelWithFrame(frame: .zero, text: "Logout", textColor: UIColorFromHex("0x183C59")!, fontSize: 14, textAlignment: .left)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        logoutImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(picImageView.snp.right).offset(12)
            make.centerY.equalTo(picImageView.snp.centerY)
        }
        
        let rightImageView = UIImageView(frame: .zero)
        rightImageView.image = UIImage(named: "right")
        rightImageView.isUserInteractionEnabled = true
        logoutImageView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints { make in
            make.right.equalTo(-12)
            make.width.height.equalTo(22)
            make.centerY.equalTo(logoutImageView.snp.centerY)
        }
        
        return logoutImageView
    }()
    
    lazy var cancelAccount: UIButton = {
        let cancelAccount = UIButton(frame: .zero)
        cancelAccount.setTitle("Cancel Account", for: .normal)
        cancelAccount.setTitleColor(UIColorFromHex("0xA29B91"), for: .normal)
        cancelAccount.cornerRadius = 12
        cancelAccount.layer.borderColor = UIColorFromHex("0xA29B91")!.cgColor
        cancelAccount.layer.borderWidth = 1
        return cancelAccount
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Set Up"
        self.view.backgroundColor = Default_BackGround_Color!
        prepareUI()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func prepareUI(){
        self.view.addSubview(topImageView)
        topImageView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(83)
            make.top.equalTo(10 + navigationFullHeight)
        }
        
        self.view.addSubview(centerImageView)
        centerImageView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(155)
            make.top.equalTo(topImageView.snp.bottom).offset(15)
        }
        
        self.centerImageView.addSubview(versionImageView)
        versionImageView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(15)
            make.height.equalTo(52)
        }
        
        centerImageView.addSubview(logoutImageView)
        logoutImageView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(versionImageView.snp.bottom).offset(15)
            make.height.equalTo(52)
        }
        
        
    }
    

}
