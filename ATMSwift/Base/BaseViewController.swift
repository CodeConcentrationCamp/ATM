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
            let backButton = UIBarButtonItem(image: UIImage(named: "icon_nav_blackBack"), style: .plain, target: self, action: #selector(backClick))
            backButton.tintColor = .black
            self.navigationItem.leftBarButtonItem = backButton
        }
    }
    
    @objc func backClick(){
        self.navigationController?.popViewController(animated: true)
    }
}
