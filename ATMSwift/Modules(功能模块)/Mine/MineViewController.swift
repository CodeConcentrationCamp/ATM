//
//  MineViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/21.
//

import UIKit

class MineViewController: CustomBaseTableViewController {
    
    lazy var headView: MineHeadView = {
        let headView = MineHeadView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight - tabBarFullHeight))
        headView.delegate = self
        return headView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight - tabBarFullHeight)
        self.view .addSubview(self.mainTableView)
        self.mainTableView.tableHeaderView = self.headView
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension MineViewController:MineHeadViewDelegate{
    func onUserActionTap(tag: Int) {
        print(tag)
        if tag == 102{
            let vc = SetUpViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
