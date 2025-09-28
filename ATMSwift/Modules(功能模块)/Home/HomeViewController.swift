//
//  HomeViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/21.
//

import UIKit

class HomeViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    
    lazy var viewModel: HomeViewModel = {
        let viewModel = HomeViewModel()
        return viewModel
    }()
    
    lazy var headView: HomeHeadView = {
        let headView = HomeHeadView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 450))
        return headView
    }()
    
    lazy var footView: HomeFootView = {
        let footView = HomeFootView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 680))
        return footView
    }()
    
    lazy var tableView: UITableView = {
        let mainTableView = UITableView(frame: .zero,style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = Default_BackGround_Color!
        mainTableView.separatorColor = UIColor.clear
        mainTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.sectionHeaderTopPadding = 0;
        mainTableView.estimatedSectionFooterHeight = 0;
        mainTableView.estimatedSectionHeaderHeight = 0;
        return mainTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        self.tableView.tableHeaderView = self.headView
        self.view .addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(-(safeDistanceTop))
        }
        
        viewModel.homeDetail()
        viewModel.upDataBlock = { [self] state,mm in
            if state == "success"{
                headView.homeModel = mm
                headView.height = (mm?.lighting?.lamps! == "groundd" && mm?.glow?.lamps! == "groundc") ? 450 : 410;
                if mm?.xx! == "1" && mm?.glow!.lamps! == "groundb"{
                    self.tableView.tableFooterView = self.footView;
                }else{
                    self.tableView.tableFooterView = UIView().bb_ViewWithFrame(frame: CGRectMake(0, 0, KScreenWidth, 20), backgroundColor: Default_BackGround_Color!);
                }
                self.tableView.reloadData()
            }
        }
    }
}
extension HomeViewController {
       //cell 行数
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if viewModel.homeModel?.candle?.lamps == "grounde" && viewModel.homeModel?.glow?.lamps == "groundc"{
               return viewModel.homeModel?.candle?.filaments?.count ?? 0
           }else{
               return 0
           }
       }
       
       //cell
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
           cell.selectionStyle =  .none
           cell.proModel = viewModel.homeModel?.candle?.filaments?[indexPath.row]
           return cell
       }
       
       //设置cell高度
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 130
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}

}
