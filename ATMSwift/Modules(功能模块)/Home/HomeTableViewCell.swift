//
//  HomeTableViewCell.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/22.
//

import UIKit
import Kingfisher
class HomeTableViewCell: BaseTableViewCell {
    
    var proModel: ProductDeatilModel?{
        didSet{
            self.payMoney.text = proModel?.torch!
            self.dayLabel.text = proModel?.repairs!
            self.rateLabel.text = proModel?.cracky!
            self.tipLabel.text = proModel?.hum!
            if let imageUrlString = proModel?.generate, let imageUrl = URL(string: imageUrlString) {
                self.picImageView.kf.setImage(with: imageUrl)
            }
        }
    }
    
    lazy var cellBgView :UIView = {
        let cellBgView = UIView().bb_ViewWithFrame(frame: CGRectMake(15, 20, KScreenWidth - 30, 110), backgroundColor: Default_BackGround_Color!)
        cellBgView.layer.borderWidth = 1
        cellBgView.layer.borderColor = Default_Black0_Color!.cgColor
        cellBgView.cornerRadius = 8
        cellBgView.layer.masksToBounds = false;
        cellBgView.layer.shadowColor = Default_BackGround_Color!.cgColor;
        cellBgView.layer.shadowOpacity = 0.5;
        cellBgView.layer.shadowOffset = CGSizeMake(3, 3);
        cellBgView.layer.shadowRadius = 4;
        return cellBgView
    }()
    
    lazy var picImageView: UIImageView = {
        let picImageView = UIImageView(frame: CGRectMake(15, 15, 44, 44))
        picImageView.image = UIImage(named: "home_logo")
        return picImageView
    }()
    
    lazy var payMoney: UILabel = {
        let payMoney = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "", textColor: Default_Black0_Color!, fontSize: 20, textAlignment: .left)
        payMoney.font = UIFont.boldSystemFont(ofSize: 20)
        return payMoney
    }()
    
    lazy var payMoneyLabel: UILabel = {
        let payMoneyLabel = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "Loan amount(₱)", textColor: Default_Black0_Color!, fontSize: 12, textAlignment: .left)
        return payMoneyLabel
    }()
    
    lazy var borrowButton: UIButton = {
        let borrowButton = UIButton(type: .custom)
        borrowButton.setTitle("Borrow", for: .normal)
        borrowButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        borrowButton.setTitleColor(UIColor.white, for: .normal)
        borrowButton.backgroundColor = UIColorFromHex("0x23BEC7")
        borrowButton.cornerRadius = 8
        borrowButton.layer.borderColor = Default_Black3_Color?.cgColor
        borrowButton.layer.borderWidth = 1
        borrowButton.isUserInteractionEnabled = false
        return borrowButton
    }()
    
    lazy var tipLabel: UILabel = {
        let tipLabel = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "Loan Gabay", textColor: Default_Black0_Color!, fontSize: 13, textAlignment: .center)
        tipLabel.cornerRadius = 13
        tipLabel.layer.borderWidth = 1
        tipLabel.layer.borderColor = Default_Black3_Color!.cgColor
        return tipLabel
    }()
    
    lazy var dayLabel: UILabel = {
        let dayLabel = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "120days", textColor: UIColorFromHex("0x23BEC7")!, fontSize: 14, textAlignment: .center)
        return dayLabel
    }()
    
    lazy var rateLabel: UILabel = {
        let rateLabel = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "0.06/day", textColor: UIColorFromHex("0xF7B431")!, fontSize: 14, textAlignment: .center)
        return rateLabel
    }()
    
    override func prepareUI() {
        self.backgroundColor = Default_BackGround_Color!
        self.contentView.addSubview(cellBgView)
        cellBgView.addSubview(picImageView)
        
        cellBgView.addSubview(payMoney)
        payMoney.snp.makeConstraints { make in
            make.top.equalTo(picImageView.snp.top).offset(2)
            make.left.equalTo(picImageView.snp.right).offset(12)
        }
        
        cellBgView.addSubview(payMoneyLabel)
        payMoneyLabel.snp.makeConstraints { make in
            make.bottom.equalTo(picImageView.snp.bottom).offset(-2)
            make.left.equalTo(payMoney.snp.left)
        }
        
        cellBgView.addSubview(borrowButton)
        borrowButton.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.height.equalTo(35)
            make.right.equalTo(-15)
            make.centerY.equalTo(picImageView.snp.centerY)
        }
        
        cellBgView.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(26)
            make.left.equalTo(picImageView.snp.left)
            make.top.equalTo(picImageView.snp.bottom).offset(12)
        }
        
        let rDay = UIImageView(frame: CGRectZero)
        rDay.image = UIImage(named: "home21")
        cellBgView.addSubview(rDay)
        rDay.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(6)
            make.right.equalTo(borrowButton.snp.right)
            make.centerY.equalTo(tipLabel.snp.centerY)
        }
        
        cellBgView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.right.equalTo((rDay.snp.left)).offset(-4)
            make.centerY.equalTo(rDay.snp.centerY)
        }
        
        let lDay = UIImageView(frame: CGRectZero)
        lDay.image = UIImage(named: "home21")
        cellBgView.addSubview(lDay)
        lDay.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(6)
            make.right.equalTo(dayLabel.snp.left).offset(-4)
            make.centerY.equalTo(tipLabel.snp.centerY)
        }
        
        cellBgView.addSubview(rateLabel)
        rateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(cellBgView.snp.centerX)
            make.centerY.equalTo(tipLabel.snp.centerY)
        }
        
        let lRate = UIImageView(frame: CGRectZero)
        lRate.image = UIImage(named: "home20")
        cellBgView.addSubview(lRate)
        lRate.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(6)
            make.right.equalTo(rateLabel.snp.left).offset(-4)
            make.centerY.equalTo(tipLabel.snp.centerY)
        }
        
        
        let rRate = UIImageView(frame: CGRectZero)
        rRate.image = UIImage(named: "home20")
        cellBgView.addSubview(rRate)
        rRate.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(6)
            make.left.equalTo(rateLabel.snp.right).offset(4)
            make.centerY.equalTo(tipLabel.snp.centerY)
        }
    }
}
