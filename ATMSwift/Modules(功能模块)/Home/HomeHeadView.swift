//
//  HomeHeadView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/22.
//

import UIKit

class HomeHeadView: UIView {
    
    lazy var topBgImageView: UIImageView = {
        let topBgImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: KScreenWidth, height: 450))
        topBgImageView.isUserInteractionEnabled = true
        return topBgImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    func initUI(){
        self.addSubview(topBgImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
