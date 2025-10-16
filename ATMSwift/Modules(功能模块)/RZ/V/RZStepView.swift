//
//  RZStepView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/14.
//

import UIKit

class RZStepView: UIView {

     init(frame: CGRect, step:Int) {
        super.init(frame: frame)
         let W = (KScreenWidth - 48 - 38*5)/4 + 38
         for i  in 1..<6 {
             let state = step>=i ? true:false
             let step = CurrentStepView(frame:CGRectMake(0 + (W)*CGFloat((i-1)),0, W,68 ), currentStepState: state, currentStep: i)
         
             self.addSubview(step)
         }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CurrentStepView: UIView{
    
    init(frame: CGRect,currentStepState: Bool,currentStep: Int) {
        super.init(frame: frame)
        
        let lineW =  (KScreenWidth-48-38*5)/4
        let stepImagePicString = String(format: "rz%ld", currentStep)
        let stepBgState = currentStepState ? "rz10" : "rz100"
        let stepImg = UIButton(type: .custom)
        stepImg.frame = CGRectMake(0, 0, 38 , 38)
        stepImg.setBackgroundImage(UIImage(named: stepBgState), for: .normal)
        stepImg.setImage(UIImage(named: stepImagePicString), for: .normal)
        self.addSubview(stepImg)
        
        let lineBgState = currentStepState ? "rz11" : "rz12"
        let lineImg = UIImageView(frame: CGRectMake(CGRectGetMaxX(stepImg.frame), 17.5, lineW , 3) )
        lineImg.image = UIImage(named: lineBgState)
        if currentStep == 5{
            lineImg.isHidden = true
        }else{
            lineImg.isHidden = false
        }
        self.addSubview(lineImg)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
