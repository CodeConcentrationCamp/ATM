//
//  OrderTableViewCell.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/27.
//

import UIKit

class OrderTableViewCell: BaseTableViewCell {

    
    var orderModel: StandingModel?{
        didSet{
            self.money.text = orderModel?.whites?.accomplish!
            if let imageUrlString = orderModel?.whites?.generate, let imageUrl = URL(string: imageUrlString) {
                self.picImageView.kf.setImage(with: imageUrl)
            }
            let a = orderModel?.whites?.does as? String ?? ""
            let b = orderModel?.whites?.gradual as? String ?? ""
            self.time.text = a+b
            
            if orderModel?.whites?.likewise == "Under review"{
                self.tipLable.text = ""
            }else{
                self.tipLable.text = orderModel?.whites?.likewise
            }
            
            if orderModel?.whites?.adjudged?.isEmpty == false{
                self.borrowBtn.isHidden = false
            }else{
                self.borrowBtn.isHidden = true
            }
            
            if orderModel?.whites?.paris == "1"{
                self.bgImageView.image = UIImage(named: "order3")
                self.topBgImageView.image = UIImage(named: "order10")
                self.borrowBtn.setBackgroundImage(UIImage(named: "order31"), for: .normal)
                self.topBgImageView.snp.updateConstraints { make in
                    make.width.equalTo(65)
                }
            }
            
            if orderModel?.whites?.paris == "2"{
                self.bgImageView.image = UIImage(named: "order4")
                self.topBgImageView.image = UIImage(named: "order11")
                self.borrowBtn.setBackgroundImage(UIImage(named: "order32"), for: .normal)
                self.topBgImageView.snp.updateConstraints { make in
                    make.width.equalTo(86)
                }
            }
            
            if orderModel?.whites?.paris == "3"{
                self.bgImageView.image = UIImage(named: "order5")
                self.topBgImageView.image = UIImage(named: "order12")
                self.borrowBtn.setBackgroundImage(UIImage(named: "order33"), for: .normal)
                self.topBgImageView.snp.updateConstraints { make in
                    make.width.equalTo(47)
                }
            }

            if orderModel?.whites?.paris == "4"{
                self.bgImageView.image = UIImage(named: "order6")
                self.topBgImageView.image = UIImage(named: "order13")
                self.topBgImageView.snp.updateConstraints { make in
                    make.width.equalTo(106)
                }
            }
            
            if orderModel?.whites?.paris == "5"{
                self.bgImageView.image = UIImage(named: "order6")
                self.topBgImageView.image = UIImage(named: "order14")
                self.topBgImageView.snp.updateConstraints { make in
                    make.width.equalTo(82)
                }
            }
            
            
            
        }
    }
    
    
    lazy var tipLable: UILabel = {
        let tipLable = UILabel().bb_LabelWithFrame(frame: CGRect(x: 0, y: 168, width: KScreenWidth, height: 12), text: "", textColor: UIColorFromHex("0xFD3A4B")!, fontSize: 12, textAlignment: .center)
        return tipLable
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView(frame: CGRect(x: 15, y: 15, width: KScreenWidth - 50, height: 148))
        bgImageView.image = UIImage(named: "order3")
        return bgImageView
    }()
    
    lazy var topBgImageView: UIImageView = {
        let topBgImageView = UIImageView(frame: .zero)
        topBgImageView.image = UIImage(named: "order10")
        return topBgImageView
    }()
    
    lazy var picImageView: UIImageView = {
        let picImageView = UIImageView(frame: CGRect(x: 15, y: 51, width: 44, height: 44))
        picImageView.image = UIImage(named: "home_logo")
        return picImageView
    }()
    
    lazy var money: UILabel = {
        let money = UILabel().bb_LabelWithFrame(frame: .zero, text: "93000", textColor: Default_Black0_Color!, fontSize: 20, textAlignment: .left)
        money.font = UIFont.boldSystemFont(ofSize: 20)
        return money
    }()
    
    lazy var borrowBtn: UIButton = {
        let borrowBtn = UIButton(frame: .zero)
        borrowBtn.setTitle("Borrow", for: .normal)
        borrowBtn.setTitleColor(UIColor.white, for: .normal)
        borrowBtn.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 16)
        borrowBtn.setBackgroundImage(UIImage(named: "home19"), for: .normal)
        borrowBtn.setBackgroundImage(UIImage(named: "home19"), for: .highlighted)
        return borrowBtn
    }()
    
    lazy var tipBtn: UIButton = {
        let tipBtn = UIButton(frame: .zero)
        tipBtn.setTitle("Loan Gabay", for: .normal)
        tipBtn.setTitleColor(Default_Black0_Color!, for: .normal)
        tipBtn.cornerRadius = 13
        tipBtn.layer.borderColor = Default_Black3_Color!.cgColor
        tipBtn.layer.borderWidth = 1
        tipBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        return tipBtn
    }()
    
    lazy var time: UILabel = {
        let time = UILabel().bb_LabelWithFrame(frame: .zero, text: "", textColor: UIColorFromHex("0xA29B91")!, fontSize: 12, textAlignment: .right)
        return time
    }()
    
    override func prepareUI() {
        self.backgroundColor = UIColor.clear
        self.addSubview(bgImageView)
        bgImageView.addSubview(topBgImageView)
        topBgImageView.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(14)
            make.top.equalTo(10)
            make.centerX.equalToSuperview()
        }
        
        bgImageView.addSubview(picImageView)
        bgImageView.addSubview(money)
        money.snp.makeConstraints { make in
            make.top.equalTo(picImageView.snp.top).offset(2)
            make.left.equalTo(picImageView.snp.right).offset(12)
        }
        
        let moneyLabel = UILabel().bb_LabelWithFrame(frame: .zero, text: "Loan amount(₱)", textColor: Default_Black0_Color!, fontSize: 12, textAlignment: .left)
        bgImageView.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { make in
            make.left.equalTo(picImageView.snp.right).offset(12)
            make.bottom.equalTo(picImageView.snp.bottom).offset(-2)
        }
        
        bgImageView.addSubview(borrowBtn)
        borrowBtn.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.height.equalTo(35)
            make.right.equalTo(-15)
            make.centerY.equalTo(picImageView.snp.centerY)
        }
        
        bgImageView.addSubview(tipBtn)
        tipBtn.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(26)
            make.left.equalTo(picImageView.snp.left)
            make.top.equalTo(picImageView.snp.bottom).offset(12)
        }
        
        
        bgImageView.addSubview(time)
        time.snp.makeConstraints { make in
            make.right.equalTo(borrowBtn.snp.right)
            make.centerY.equalTo(tipBtn.snp.centerY)
        }
        
        self.addSubview(tipLable)
        
    }
}
