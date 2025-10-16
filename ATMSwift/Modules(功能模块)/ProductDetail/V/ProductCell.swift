//
//  ProductCell.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/28.
//

import UIKit

class ProductCell: UIView {

    var model: PumpkinsModel?{
        didSet{
            self.nameLabel.text = model?.amid ?? ""
            self.rightImageView.image = model?.vines == "1" ? UIImage(named: "pro11"):UIImage(named: "pro10")
            self.bgImageView.image = ( model?.vines == "1") ? UIImage(named: "pro4"):UIImage(named: "pro14")
            if let imageUrlString = model?.suggestion, let imageUrl = URL(string: imageUrlString) {
                self.picImageView.kf.setImage(with: imageUrl,placeholder: UIImage(named: "home_logo") )
            }

        }
    }
    
    lazy var picImageView: UIImageView = {
        let picImageView = UIImageView(frame: CGRect(x: 4, y: 4, width: 40, height: 40))
        picImageView.image = UIImage(named: "home_logo")
        return picImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel().bb_LabelWithFrame(frame: .zero, text: "", textColor: Default_Black0_Color!, fontSize: 16, textAlignment: .left)
        return nameLabel
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView(frame: .zero)
        rightImageView.image = UIImage(named: "pro10")
        return rightImageView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView(frame: CGRect(x:15, y: 0, width: KScreenWidth - 60, height: 48))
        bgImageView.image = UIImage(named: "pro6")
        return bgImageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    func initUI(){
        self.backgroundColor = UIColorFromHex("0xEFDFBF")
        self.addSubview(bgImageView)
        bgImageView.addSubview(picImageView)
        
        bgImageView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(bgImageView.snp.centerY)
            make.left.equalTo(54)
        }
        
        bgImageView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.right.equalTo(-15)
            make.centerY.equalTo(bgImageView.snp.centerY)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
