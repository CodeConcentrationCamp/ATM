//
//  LoginViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/26.
//

import UIKit

class LoginViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseTableViewCell", for: indexPath) as! BaseTableViewCell
            cell.selectionStyle =  .none
          return cell
     }
    
    lazy var headView: LoginHeadView = {
        let headView = LoginHeadView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight - navigationFullHeight))
        return headView
    }()
    
    lazy var tableView: UITableView = {
        let mainTableView = UITableView(frame: .zero,style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = Default_BackGround_Color!
        mainTableView.separatorColor = UIColor.clear
      
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.showsHorizontalScrollIndicator = false
        return mainTableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(0)
        }
        self.tableView.tableHeaderView = self.headView
    
    }
    
  
    

}

