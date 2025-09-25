//
//  CustomTabBar.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/21.
//

import UIKit

class CustomTabBar: UITabBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width , height: 83))
        bgImageView.image = UIImage(named: "sy_tab")
        bgImageView.contentMode = .scaleAspectFill
        self.addSubview(bgImageView)
        self.shadowImage = UIImage()
        self.backgroundImage = UIImage()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        for subview in self.subviews {
            if let tabBarButton = subview as? UIControl {
                tabBarButton.frame.origin.y += 10 // 每个按钮下移5pt
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
