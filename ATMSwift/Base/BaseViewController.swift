//
//  BaseViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Default_BackGround_Color!;
        initBackButton()
    }
    
    func initBackButton(){
        if let navigationController = self.navigationController,
           navigationController.viewControllers.count > 1 {
            
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: 10, y: 0, width: 100, height: 40)
            btn.contentHorizontalAlignment = .left
            btn.isUserInteractionEnabled = true
            btn .setImage(UIImage(named: "return_ic"), for: .normal)
            btn .setImage(UIImage(named: "return_ic"), for: .highlighted)
            btn.addTarget(self, action:  #selector(backClick), for: .touchUpInside)
            let barItem = UIBarButtonItem(customView: btn)
            self.navigationItem.leftBarButtonItem = barItem
        }
    }
    
    @objc func backClick(){
        self.navigationController?.popViewController(animated: true)
    }
}
