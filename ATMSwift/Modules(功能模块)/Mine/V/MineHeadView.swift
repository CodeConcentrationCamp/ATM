//
//  MineHeadView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/27.
//

import UIKit

protocol MineHeadViewDelegate : NSObjectProtocol {
    func onUserActionTap (tag:Int)
}



class MineHeadView: UIView {
    
    var delegate:MineHeadViewDelegate?
    
    let picArray = ["grzx_cs_ic","grzx_pa_ic","grzx_su_ic"]
    let titleArray = ["Customer service","Privacy agreement","Set Up"]
    
    let imageArr = ["grzx_all_ic","grzx_repayment_ic","grzx_applying_ic","grzx_finish_ic"]
    let titleArr = ["All","Repayment","Applying","Finish"]
    
    lazy var tipImageView: UIImageView = {
        let tipImageView = UIImageView(frame: CGRectZero)
        tipImageView.image = UIImage(named: "grzx_ic")
        return tipImageView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView(frame: CGRectZero)
        bgImageView.isUserInteractionEnabled = true;
        bgImageView.image = UIImage(named: "mineBg")
    
        let itemW = (KScreenWidth - 30 - 5*15)/4
        for i in 0..<imageArr.count {
            let itemButton = UIButton(frame: CGRect(x: 15+(15+itemW)*CGFloat((i)), y: 77, width: itemW, height: 66))
            itemButton.setTitle(titleArr[i], for: .normal)
            itemButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            itemButton.setImage(UIImage(named: imageArr[i]), for: .normal)
            itemButton.setBackgroundImage(UIImage(named: "grzx_bg_01"), for: .normal)
            itemButton.setBackgroundImage(UIImage(named: "grzx_bg_01"), for: .highlighted)
            itemButton.tag = i
            itemButton.contentHorizontalAlignment = .center;
            itemButton.setImagePosition(.top, spacing: 5)
            

            bgImageView.addSubview(itemButton)
        }

        return bgImageView
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView(frame: CGRectZero)
        headImageView.isUserInteractionEnabled = true;
        headImageView.image = UIImage(named: "grzx_tx")
        return headImageView
    }()

    lazy var numLabel: UILabel = {
        let numValue = ToolManager.shared.getData(forKey: "PhoneNum") as! String
        let numLabel = UILabel().bb_LabelWithFrame(frame: .zero, text:ToolManager.shared.maskMiddleFourDigits(numValue), textColor: Default_Black0_Color!, fontSize: 20, textAlignment: .left)
        numLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return numLabel
    }()
    
    lazy var boomImageView: UIImageView = {
        let boomImageView = UIImageView(frame: CGRectZero)
        boomImageView.isUserInteractionEnabled = true;
        boomImageView.image = UIImage(named: "grzx_bg_03")
        
        let topIamgeView = UIImageView(frame: .zero)
        topIamgeView.image = UIImage(named: "grzx_bg_02")
        boomImageView.addSubview(topIamgeView)
        topIamgeView.snp.makeConstraints { make in
            make.left.top.equalTo(0)
            make.right.equalTo(-2)
            make.height.equalTo(36)
        }
        
        let centerIamgeView = UIImageView(frame: .zero)
        centerIamgeView.image = UIImage(named: "Commonly_used_functi")
        topIamgeView.addSubview(centerIamgeView)
        centerIamgeView.snp.makeConstraints { make in
            make.width.equalTo(196)
            make.height.equalTo(16)
            make.center.equalToSuperview()
        }
        return boomImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    func initUI(){
        self.addSubview(tipImageView)
        tipImageView.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.equalTo(safeDistanceTop)
            make.width.equalTo(130)
            make.height.equalTo(107)
        }
        
        self.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalTo(68+safeDistanceTop)
            make.left.equalTo(15)
            make.height.equalTo(165)
            make.right.equalTo(tipImageView.snp.right);
        }
        
        bgImageView.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.top.equalTo(-42)
            make.left.equalTo(bgImageView.snp.left).offset(23)
            make.width.height.equalTo(84)
        }
        
        bgImageView.addSubview(numLabel)
        numLabel.snp.makeConstraints { make in
            make.bottom.equalTo(headImageView.snp.bottom)
            make.left.equalTo(headImageView.snp.right).offset(13)
        }
        
        self.addSubview(boomImageView)
        boomImageView.snp.makeConstraints { make in
            make.right.equalTo(tipImageView.snp.right)
            make.left.equalTo(15)
            make.height.equalTo(271)
            make.top.equalTo(bgImageView.snp.bottom).offset(13)
        }
        
        for i in 0..<picArray.count{
            let itemView = MineItemView(frame:  CGRect(x: 15, y: 51 + (70)*i, width: Int((KScreenWidth)) - 60, height: 55), imagePic: picArray[i], title: titleArray[i])
            itemView.tag = i+100
            boomImageView.addSubview(itemView)
            itemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
            
        }
    }
    
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        if(self.delegate != nil) {
            self.delegate?.onUserActionTap(tag: gesture.view!.tag)
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MineItemView:UIView{
    
    init(frame: CGRect, imagePic: String?, title: String?) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        let bgImageView = UIImageView(frame: CGRectZero)
        bgImageView.isUserInteractionEnabled = true;
        bgImageView.image = UIImage(named: "grzx_bg_04")
        bgImageView.isUserInteractionEnabled = true
        self.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(0)
        }
        
        let itemImageView = UIImageView(frame: CGRectZero)
        itemImageView.isUserInteractionEnabled = true;
        itemImageView.image = UIImage(named: imagePic!)
        itemImageView.isUserInteractionEnabled = true
        bgImageView.addSubview(itemImageView)
        itemImageView.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.width.height.equalTo(40)
            make.centerY.equalTo(bgImageView.snp.centerY)
        }
        
        let titleLabel = UILabel().bb_LabelWithFrame(frame: .zero, text: title!, textColor: UIColorFromHex("0x183C59")!, fontSize: 14, textAlignment: .left)
        titleLabel.isUserInteractionEnabled = true
        bgImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(itemImageView.snp.right).offset(12)
            make.centerY.equalTo(itemImageView.snp.centerY)
        }
        
        let rightImageView = UIImageView(frame: CGRectZero)
        rightImageView.isUserInteractionEnabled = true;
        rightImageView.image = UIImage(named: "right")
        rightImageView.isUserInteractionEnabled = true
        bgImageView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints { make in
            make.right.equalTo(-12)
            make.width.height.equalTo(22)
            make.centerY.equalTo(itemImageView.snp.centerY)
        }
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
