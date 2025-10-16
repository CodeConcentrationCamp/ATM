//
//  KYCView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/14.
//

import UIKit

class KYCView: UIView{
    public  lazy var rightPic: UIImageView = {
        let rightPic = UIImageView(frame: .zero)
        rightPic.image = UIImage(named: "id3")
        return rightPic
    }()
    
    public lazy var titleLabel: UILabel = {
        let titleLabel = UILabel().bb_LabelWithFrame(frame: .zero, text: "", textColor: UIColorFromHex("0x183C59")!, fontSize: 14, textAlignment: .left)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bgView = UIImageView(frame: CGRectMake(15, 0, KScreenWidth - 60, 40 ))
        bgView.image = UIImage(named: "id2")
        self.addSubview(bgView)

        bgView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.centerY.equalTo(bgView.snp.centerY)
        }
        
        bgView.addSubview(rightPic)
        rightPic.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.right.equalTo(-15)
            make.centerY.equalTo(bgView.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

