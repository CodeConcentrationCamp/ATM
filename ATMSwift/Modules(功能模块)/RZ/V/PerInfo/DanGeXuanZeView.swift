//
//  DanGeXuanZeView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/16.
//

import UIKit

class DanGeXuanZeView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var closeHandler: ((_ customView:DanGeXuanZeView) -> Void)?
    
    var commitHandler: ((_ customView:DanGeXuanZeView,_ value:String?) -> Void)?
    var normalDate: String?
    
    
    var savaValue:String?
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let bgView = UIView().bb_ViewWithFrame(frame: CGRectMake(0, 0, KScreenWidth, 40), backgroundColor: .clear)
        
        let label = UILabel().bb_LabelWithFrame(frame: .zero, text: "", textColor: Default_Black0_Color, fontSize: 15, textAlignment: .center)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        bgView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(bgView.snp.centerY)
            make.centerX.equalTo(bgView.snp.centerX)
        }
        
        let model = self.mm.eighth![row] 
        label.text = model.subsided
        
        return bgView
        
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let model = self.mm.eighth?[row]
        self.savaValue = model?.subsided
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.mm.eighth!.count
    }
    


    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: .zero)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .clear
        return pickerView
    }()
    
    private  lazy var closeButton: UIButton = {
          let closeButton = UIButton(type: .custom)
          closeButton.setImage(UIImage(named: "common1"), for: .normal)
        closeButton.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
          return closeButton
      }()
    
    lazy var mm: CounseledModel = {
        let mm = CounseledModel()
        return mm
    }()
    
    
    lazy var topLabel: UILabel = {
        let topLabel = UILabel().bb_LabelWithFrame(frame: .zero, text: "", textColor: UIColorFromHex("0x23BEC7")!, fontSize: 16, textAlignment: .center)
        topLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return topLabel
    }()
    @objc func cancelBtnClick(){
        self.closeHandler?(self)
    }
    
    @objc func gogoClick(){
        self.commitHandler?(self,self.savaValue)
    }
    
    init(frame: CGRect,mm:CounseledModel,title:String?,normalDate:String?, closeHandler: ((_ customView:DanGeXuanZeView) -> Void)?,commitHandler: ((_ customView:DanGeXuanZeView,_ value:String?) -> Void)?) {
        super.init(frame: frame)
        self.mm = mm
        self.closeHandler = closeHandler
        self.commitHandler = commitHandler
        self.normalDate = normalDate ?? ""
        let bgView =  UIImageView(frame: .zero )
        bgView.image = UIImage(named: "rz50")
        bgView.isUserInteractionEnabled = true
        self.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(325)
            make.height.equalTo(350)
        }
        
        topLabel.text = title ?? ""
        bgView.addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(20)
            make.top.equalTo(27)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        bgView.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(210)
            make.centerX.equalTo(bgView.snp.centerX)
            make.top.equalTo(50)
        }
        
        let  gogo = UIButton(type: .custom)
        gogo.setImage(UIImage(named: "id1"), for: .normal)
        gogo.setBackgroundImage(UIImage(named: "pro4"), for: .normal)
        bgView.addSubview(gogo)
        gogo.addTarget(self, action: #selector(gogoClick), for: .touchUpInside)
        gogo.snp.makeConstraints { make in
            make.width.equalTo(246)
            make.height.equalTo(43)
            make.centerX.equalTo(bgView.snp.centerX)
            make.bottom.equalTo(bgView.snp.bottom).offset(-18)
        }
        
        self.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(15)
            make.centerX.equalTo(bgView.snp.centerX)
            make.width.height.equalTo(34)
        }
        var indexValue = 0
        if normalDate == mm.bigger && normalDate?.isEmpty == false{
    
        }else{
            
            for i in 0 ..< self.mm.eighth!.count {
                let model = self.mm.eighth?[i]
                if model?.subsided == normalDate {
                    indexValue = (model?.lamps!.codingKey.intValue!)! - 1
                        }
                    }
        }
        
        
        self.pickerView.selectRow(indexValue, inComponent: 0, animated: false)
        self.pickerView(pickerView, didSelectRow: indexValue, inComponent: 0)
        self.pickerView .reloadComponent(0)
        self.topLabel.text = self.mm.amid!
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
