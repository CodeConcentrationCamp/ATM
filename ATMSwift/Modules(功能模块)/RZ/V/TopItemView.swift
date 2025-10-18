//
//  TopItemView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/14.
//

import UIKit

class TopItemView: UIView {

    init(frame: CGRect,height: CGFloat,topBg: String,titleStr: String) {
         super.init(frame: frame)
        
        let cellBgView = UIView().bb_ViewWithFrame(frame: self.bounds, backgroundColor: Default_BackGround_Color)
        cellBgView.cornerRadius = 8
        cellBgView.layer.borderColor = UIColorFromHex("0X1C1F1F")!.cgColor
        cellBgView.layer.borderWidth = 1
        cellBgView.layer.masksToBounds = false
        cellBgView.layer.shadowColor = UIColorFromHex("0xA89C87")!.cgColor
        cellBgView.layer.shadowOpacity = 0.5
        cellBgView.layer.shadowOffset = CGSizeMake(3, 3)
        cellBgView.layer.shadowRadius = 4
        self.addSubview(cellBgView)
        
        let topImageView = UIImageView(frame: CGRectMake(0, 0, cellBgView.width, 36) )
        topImageView.image = UIImage(named: topBg)
        cellBgView.addSubview(topImageView)
        
        let lImageView = UIImageView(frame:.zero)
        lImageView.image = UIImage(named: "id6")
        topImageView.addSubview(lImageView)
        lImageView.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(6)
            make.left.equalTo(15)
            make.centerY.equalTo(topImageView.snp.centerY)
        }
        
        let rImageView = UIImageView(frame:.zero)
        rImageView.image = UIImage(named: "id6")
        topImageView.addSubview(rImageView)
        rImageView.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(6)
            make.right.equalTo(-15)
            make.centerY.equalTo(topImageView.snp.centerY)
        }
        
        
        let tip = UILabel().bb_LabelWithFrame(frame: .zero, text: titleStr, textColor: Default_Black0_Color, fontSize: 14, textAlignment: .center)
        tip.font = UIFont.boldSystemFont(ofSize: 14)
        topImageView.addSubview(tip)
        tip.snp.makeConstraints { make in
            make.centerX.equalTo(topImageView.snp.centerX)
            make.centerY.equalTo(topImageView.snp.centerY)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
