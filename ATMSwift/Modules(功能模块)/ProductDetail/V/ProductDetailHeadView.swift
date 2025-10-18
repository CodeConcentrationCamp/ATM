//
//  ProductDetailHeadView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/28.
//

import UIKit

class ProductDetailHeadView: UIView {
    
    
    var model : PlumsModel?{
        didSet{
            self.money.text = model?.seems!
            if ((model?.potatoes?.isEmpty) == false){
                self.moneyLabel.text = model?.potatoes!
            }
            
            if ((model?.corn?.isEmpty) == false){
                self.rate.text = model?.corn!
            }
            
            if ((model?.field?.isEmpty) == false){
                self.dayTip.text = model?.field!
            }
            
            self.day.text = model?.stranger ?? ""
            self.rate.text = model?.cracky ?? ""
        }
    }
    
    lazy var bgView: UIImageView = {
        let bgView = UIImageView(frame: CGRect(x: 15, y: 10, width: KScreenWidth - 30, height: 138))
        bgView.image = UIImage(named: "pro1")
        return bgView
    }()
    
    lazy var money: UILabel = {
        let money = UILabel().bb_LabelWithFrame(frame: .zero, text: "999999", textColor: Default_Black0_Color, fontSize: 28, textAlignment: .left)
        money.font = UIFont.boldSystemFont(ofSize: 28)
        return money
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel().bb_LabelWithFrame(frame: .zero, text: "Loan amount", textColor: Default_Black0_Color, fontSize: 14, textAlignment: .left)
        return moneyLabel
    }()
    
    lazy var rateImgView: UIImageView = {
        let rateImgView = UIImageView(frame: .zero)
        rateImgView.image = UIImage(named: "pro12")
        return rateImgView
    }()
    
    lazy var rate: UILabel = {
        let rate = UILabel().bb_LabelWithFrame(frame: .zero, text: "", textColor: Default_Black0_Color, fontSize: 14, textAlignment: .center)
        return rate
    }()
    
    lazy var rateTip: UILabel = {
        let rateTip = UILabel().bb_LabelWithFrame(frame: .zero, text: "Interest rate", textColor: UIColorFromHex("0xA29B91")!, fontSize: 12, textAlignment: .center)
        return rateTip
    }()
    
    lazy var dayImgView: UIImageView = {
        let dayImgView = UIImageView(frame: .zero)
        dayImgView.image = UIImage(named: "pro13")
        return dayImgView
    }()
    
    lazy var day: UILabel = {
        let day = UILabel().bb_LabelWithFrame(frame: .zero, text: "", textColor: Default_Black0_Color, fontSize: 14, textAlignment: .center)
        return day
    }()
    
    lazy var dayTip: UILabel = {
        let dayTip = UILabel().bb_LabelWithFrame(frame: .zero, text: "The term", textColor: UIColorFromHex("0xA29B91")!, fontSize: 12, textAlignment: .center)
        return dayTip
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    func initUI(){
        self.addSubview(bgView)
        
        bgView.addSubview(money)
        money.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.bottom.equalTo(-20)
        }
        bgView.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { make in
            make.left.equalTo(money.snp.left)
            make.bottom.equalTo(money.snp.top).offset(-12)
        }
        
        bgView.addSubview(rateImgView)
        rateImgView.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.width.equalTo(126)
            make.height.equalTo(33)
            make.top.equalTo(15)
        }
        
        rateImgView.addSubview(rate)
        rate.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(rateImgView.snp.centerY).offset(3)
        }
        
        bgView.addSubview(rateTip)
        rateTip.snp.makeConstraints { make in
            make.top.equalTo(rateImgView.snp.bottom).offset(4)
            make.centerX.equalTo(rateImgView.snp.centerX)
        }
        
        bgView.addSubview(dayImgView)
        dayImgView.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.width.equalTo(126)
            make.height.equalTo(33)
            make.bottom.equalTo(-34)
        }
        
        bgView.addSubview(day)
        day.snp.makeConstraints { make in
            make.centerX.equalTo(dayImgView.snp.centerX)
            make.centerY.equalTo(dayImgView.snp.centerY).offset(3)
        }
        
        bgView.addSubview(dayTip)
        dayTip.snp.makeConstraints { make in
            make.top.equalTo(dayImgView.snp.bottom).offset(4)
            make.centerX.equalTo(dayImgView.snp.centerX)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
