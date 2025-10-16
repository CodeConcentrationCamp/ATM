//
//  FaceViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/30.
//

import UIKit

class FaceViewController: CustomBaseTableViewController {
    
    var productID:String?
    var titleString:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Verify Identity"
        // Do any additional setup after loading the view.
    }

    override func backClick() {
        PageRouter.jumpWanLiuBox(proID: self.productID!)
    }
}
