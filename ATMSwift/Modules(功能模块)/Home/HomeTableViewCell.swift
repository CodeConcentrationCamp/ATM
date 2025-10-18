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
    
    // MARK: - 视图组件（懒加载+统一约束，消除硬编码frame）
    private lazy var cellBgView: UIView = {
       let cellBgView = UIView.quickCreate(frame: .zero, bgColor: Default_BackGround_Color)
       cellBgView.layer.borderWidth = 1
       cellBgView.layer.borderColor = Default_Black0_Color.cgColor
       cellBgView.cornerRadius = 8
       cellBgView.layer.masksToBounds = false;
       cellBgView.layer.shadowColor = Default_BackGround_Color.cgColor;
       cellBgView.layer.shadowOpacity = 0.5;
       cellBgView.layer.shadowOffset = CGSizeMake(3, 3);
       cellBgView.layer.shadowRadius = 4;
       return cellBgView
    }()
    private lazy var picImageView: UIImageView = {
        let picImageView = UIImageView.quickCreate(frame: .zero, bgImageName: "home_logo")
        return picImageView
    }()
    private lazy var payMoney: UILabel = {
        let payMoney = UILabel.quickCreate(frame: .zero, text: "", textColor: Default_Black0_Color, fontSize: 20, textAlignment: .left)
        payMoney.font = UIFont.boldSystemFont(ofSize: 20)
        return payMoney
    }()
    private lazy var payMoneyLabel: UILabel = {
        let payMoneyLabel = UILabel.quickCreate(text: "Loan amount(₱)", textColor: Default_Black0_Color, fontSize: 12, textAlignment: .left)
        return payMoneyLabel
    }()
    private lazy var borrowButton: UIButton = {
        let borrowButton = UIButton(type: .custom)
        borrowButton.setTitle("Borrow", for: .normal)
        borrowButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        borrowButton.setTitleColor(UIColor.white, for: .normal)
        borrowButton.backgroundColor = UIColorFromHex("0x23BEC7")
        borrowButton.cornerRadius = 8
        borrowButton.layer.borderColor = Default_Black3_Color.cgColor
        borrowButton.layer.borderWidth = 1
        borrowButton.isUserInteractionEnabled = false
        return borrowButton
    }()
    private lazy var tipLabel: UILabel = {
        let tipLabel = UILabel.quickCreate(text: "Loan Gabay", textColor: Default_Black0_Color, fontSize: 13, textAlignment: .center)
        tipLabel.cornerRadius = 13
        tipLabel.layer.borderWidth = 1
        tipLabel.layer.borderColor = Default_Black3_Color.cgColor
        return tipLabel
    }()
    private lazy var dayLabel: UILabel = {
        let dayLabel = UILabel.quickCreate(text: "120days", textColor: UIColorFromHex("0x23BEC7") ?? .white, fontSize: 14, textAlignment: .center)
        return dayLabel
    }()
    private lazy var rateLabel: UILabel = {
        let rateLabel = UILabel.quickCreate(text: "", textColor: UIColorFromHex("0xF7B431") ?? .white, fontSize: 14, textAlignment: .center)
        return rateLabel
    }()
    
    override func prepareUI() {
        super.prepareUI()
        self.backgroundColor = Default_BackGround_Color
        
        self.contentView.addSubview(cellBgView)
        cellBgView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.width.equalTo(110)
            make.top.equalTo(20)
        }
        cellBgView.addSubview(picImageView)
        picImageView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(15)
            make.width.height.equalTo(44)
        }
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
