//
//  PerInfoViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/30.
//

import UIKit

class PerInfoViewController: CustomBaseTableViewController {

    var state:String?
    var productID:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Personal Information"
        // Do any additional setup after loading the view.
    }
    
    
    override func backClick() {
        PageRouter.jumpWanLiuBox(proID: self.productID!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
