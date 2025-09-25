//
//  HomeViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/21.
//

import UIKit

class HomeViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    
    lazy var headView: HomeHeadView = {
        let headView = HomeHeadView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 450))
        return headView
    }()
    
    lazy var tableView: UITableView = {
        let mainTableView = UITableView(frame: .zero,style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = Default_BackGround_Color!
        mainTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        return mainTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        self.tableView.tableHeaderView = self.headView
        self.view .addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(0)
        }
    }
    
}
extension HomeViewController {
       //cell 行数
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 10
       }
       
       //cell
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
           cell.selectionStyle =  .none
         return cell
       }
       
       //设置cell高度
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}

}
