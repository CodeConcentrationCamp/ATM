//
//  HomeHeadView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/22.
//

import UIKit



class HomeHeadView: UIView, ReplyViewDelegate {
    
    var urlArray = Array<String>()
    
    var homeModel: HomeModel?{
        didSet{
            self.investMoney.text = homeModel?.glow?.filaments?.first?.wiped!
            self.centerLeftLabel.text = homeModel?.glow?.filaments?.first?.gives!
            self.centerRightLabel.text = homeModel?.glow?.filaments?.first?.repairs!
            
            var titleArray: [String] = []
            if (homeModel?.lighting?.filaments?.count)! > 0{
                if let filaments = homeModel?.lighting?.filaments {
                    for proModel in filaments {
                        titleArray.append(proModel.chums!)
                        self.urlArray.append(proModel.patent!)
                    }
                }
            }
            
            if homeModel?.lighting?.lamps == "groundd" && homeModel?.glow?.lamps == "groundc"{
                self.yqBgImageView.isHidden = false
                self.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: 450)
                self.topBgImageView.height = 450
                self.topBgImageView.image = UIImage(named: "home1")
                self.replyView.titlesGroup = titleArray
            }else{
                self.yqBgImageView.isHidden = true
                self.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: 410)
                self.topBgImageView.height = 410
                self.topBgImageView.image = UIImage(named: "home11")
            }
        }
    }
    
    
    lazy var topBgImageView: UIImageView = {
        let topBgImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: KScreenWidth, height: 450))
        topBgImageView.image = UIImage(named: "home1")
        topBgImageView.isUserInteractionEnabled = true
        return topBgImageView
    }()
    
    lazy var cardImageView: UIImageView = {
        let cardImageView = UIImageView(frame:CGRect(x: 0, y: 66, width: KScreenWidth, height: 307))
        cardImageView.image = UIImage(named: "home2")
        cardImageView.isUserInteractionEnabled = true
        return cardImageView
    }()
    
    
    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "Loan amount(₱)", textColor: UIColor.white, fontSize: 14, textAlignment: .center)
        return titleLabel
    }()
    
    lazy var investMoney : UILabel = {
        let investMoney = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "", textColor: UIColor.white, fontSize: 45, textAlignment: .center)
        investMoney.font =  UIFont.boldSystemFont(ofSize: 45)
        return investMoney
    }()
    
    lazy var centerLeftImageV: UIImageView = {
        let centerLeftImageV = UIImageView(frame:CGRectZero)
        centerLeftImageV.image = UIImage(named: "home3")
        centerLeftImageV.isUserInteractionEnabled = true
        return centerLeftImageV
    }()
    
    lazy var centerLeftLabel : UILabel = {
        let centerLeftLabel = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "", textColor: UIColor.black, fontSize: 14, textAlignment: .center)
        return centerLeftLabel
    }()
    
    lazy var centerRightImageV: UIImageView = {
        let centerRightImageV = UIImageView(frame:CGRectZero)
        centerRightImageV.image = UIImage(named: "home4")
        centerRightImageV.isUserInteractionEnabled = true
        return centerRightImageV
    }()
    
    lazy var centerRightLabel : UILabel = {
        let centerRightLabel = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "", textColor: UIColor.black, fontSize: 14, textAlignment: .center)
        return centerRightLabel
    }()
    
    lazy var rateLabel : UILabel = {
        let rateLabel = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "Interest rate", textColor: UIColor.white, fontSize: 12, textAlignment: .center)
        return rateLabel
    }()
    
    lazy var termLabel : UILabel = {
        let termLabel = UILabel().bb_LabelWithFrame(frame: CGRectZero, text: "Loan Term", textColor: UIColor.white, fontSize: 12, textAlignment: .center)
        return termLabel
    }()
    
    
    lazy var goBgImageView: UIImageView = {
        let goBgImageView = UIImageView(frame:CGRectZero)
        goBgImageView.image = UIImage(named: "home5")
        goBgImageView.isUserInteractionEnabled = true
        return goBgImageView
    }()
    
    lazy var goImageView: UIImageView = {
        let goImageView = UIImageView(frame:CGRectZero)
        goImageView.image = UIImage(named: "home6")
        goImageView.isUserInteractionEnabled = true
        return goImageView
    }()
    
    lazy var handImageView: UIImageView = {
        let handImageView = UIImageView(frame:CGRectZero)
        handImageView.image = UIImage(named: "home7")
        handImageView.isUserInteractionEnabled = true
        return handImageView
    }()
    
    lazy var yqBgImageView: UIImageView = {
        let yqBgImageView = UIImageView(frame:CGRectMake(15,380, KScreenWidth - 30, 38))
        yqBgImageView.image = UIImage(named: "home15")
        yqBgImageView.isHidden = true
        yqBgImageView.isUserInteractionEnabled = true
        return yqBgImageView
    }()
    
    lazy var replyView: ReplyView = {
        let replyView = ReplyView(frame: CGRectMake(60, 0, KScreenWidth - 120 - 30, 38))
        replyView.isUserInteractionEnabled = true
        replyView.delegate = self
        replyView.backgroundColor = .clear
        replyView.isHidden = true
        return replyView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    func initUI(){
        self.addSubview(topBgImageView)
        topBgImageView.addSubview(cardImageView)
        
        cardImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(cardImageView.snp.centerX)
            make.top.equalTo(40)
        }
        
        cardImageView.addSubview(investMoney)
        investMoney.snp.makeConstraints { make in
            make.centerX.equalTo(cardImageView.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(0)
        }
        
        cardImageView.addSubview(centerLeftImageV)
        centerLeftImageV.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(33)
            make.centerX.equalTo(cardImageView.snp.centerX).offset(-65)
            make.top.equalTo(investMoney.snp.bottom).offset(0)
        }
        
        centerLeftImageV.addSubview(centerLeftLabel)
        centerLeftLabel.snp.makeConstraints { make in
            make.centerX.equalTo(centerLeftImageV.snp.centerX)
            make.centerY.equalTo(centerLeftImageV.snp.centerY).offset(2)
        }
        
        cardImageView.addSubview(centerRightImageV)
        centerRightImageV.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(33)
            make.centerX.equalTo(cardImageView.snp.centerX).offset(65)
            make.centerY.equalTo(centerLeftImageV.snp.centerY)
        }
        
        centerRightImageV.addSubview(centerRightLabel)
        centerRightLabel.snp.makeConstraints { make in
            make.centerX.equalTo(centerRightImageV.snp.centerX)
            make.centerY.equalTo(centerRightImageV.snp.centerY).offset(2)
        }
        
        cardImageView.addSubview(rateLabel)
        rateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(centerLeftImageV.snp.centerX)
            make.top.equalTo(centerLeftImageV.snp.bottom).offset(3)
        }
        
        cardImageView.addSubview(termLabel)
        termLabel.snp.makeConstraints { make in
            make.centerX.equalTo(centerRightImageV.snp.centerX)
            make.centerY.equalTo(rateLabel.snp.centerY)
            
        }
        
        cardImageView.addSubview(goBgImageView)
        goBgImageView.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(48)
            make.bottom.equalTo(-18)
            make.centerX.equalTo(cardImageView.snp.centerX)
        }
        
        goBgImageView.addSubview(goImageView)
        goImageView.snp.makeConstraints { make in
            make.width.equalTo(102)
            make.height.equalTo(17)
            make.centerY.equalTo(goBgImageView.snp.centerY)
            make.centerX.equalTo(goBgImageView.snp.centerX)
        }
        
        goBgImageView.addSubview(handImageView)
        handImageView.snp.makeConstraints { make in
            make.width.equalTo(35)
            make.height.equalTo(39)
            make.top.equalTo(15)
            make.right.equalTo(10)
        }
        
        topBgImageView.addSubview(yqBgImageView)
        
        yqBgImageView.addSubview(replyView)
    }
    
    func topLineView(_ topLine: ReplyView!, didScrollTo index: Int) {
        
    }
    
    func topLineView(_ topLine: ReplyView!, didSelectItemAt index: Int) {
        BBAllLog("\(index)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
