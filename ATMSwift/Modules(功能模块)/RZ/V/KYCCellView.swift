//
//  KYCCellView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/13.
//

import UIKit



class KYCCellView: UIView {
    
    /////Block
    var kycBlock : ((Int, [KYCViewController.StringItem]) -> Void)?

    lazy var cellBgView: UIView = {
        let cellBgView = UIView(frame: .zero)
        cellBgView.cornerRadius = 8
        cellBgView.layer.borderColor = UIColorFromHex("0X1C1F1F")!.cgColor
        cellBgView.layer.borderWidth = 1
        cellBgView.layer.masksToBounds = false
        cellBgView.layer.shadowColor = UIColorFromHex("0xA89C87")!.cgColor
        cellBgView.layer.shadowOpacity = 0.5
        cellBgView.layer.shadowOffset = CGSizeMake(3, 3)
        cellBgView.layer.shadowRadius = 4
        return cellBgView
    }()
    
    lazy var topImageView: UIImageView = {
        let topImageView = UIImageView(frame: CGRectMake(0, 0,  KScreenWidth - 30, 36))
        topImageView.image = UIImage(named: "id5")
        return topImageView
    }()
    
    lazy var lImageView: UIImageView = {
        let lImageView = UIImageView(frame:CGRectMake(15, 0, 70, 6))
        lImageView.image = UIImage(named: "id6")
        return lImageView
    }()

    init(frame: CGRect,type:NSInteger,arr:[KYCViewController.StringItem]) {
         super.init(frame: frame)
        
        var itemAllH = 0
        if arr.count != 0 {
            itemAllH = arr.count * 52 + 51
        }else{
            itemAllH = 2 * 52 + 51
        }
        
        cellBgView.frame = CGRectMake(15, 0, KScreenWidth - 30, CGFloat(itemAllH))
        self.addSubview(cellBgView)
        
        cellBgView.addSubview(topImageView)
        
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
        
        let tip = UILabel().bb_LabelWithFrame(frame: .zero, text: type == 1 ? "Recommended ID Type": "Other Options", textColor: Default_Black0_Color, fontSize: 14, textAlignment: .center)
        tip.font = UIFont.boldSystemFont(ofSize: 14)
        topImageView.addSubview(tip)
        tip.snp.makeConstraints { make in
            make.centerX.equalTo(topImageView.snp.centerX)
            make.centerY.equalTo(topImageView.snp.centerY)
        }
        
        for i in 0..<arr.count{
            let cell = KYCView(frame: CGRectMake(0, CGFloat(51+52*i), KScreenWidth - 30, 52))
            cell.isUserInteractionEnabled = true
            cell.tag  = i
            cell.titleLabel.text = arr[i].originalString
            cell.rightPic.image = UIImage(named: arr[i].isSelected == "1" ?"id4":"id3")
            cellBgView.addSubview(cell)
            cell.addTapGesture { tapView in
                self.kycBlock!(tapView.view!.tag,arr)
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
