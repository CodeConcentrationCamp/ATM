//
//  CustomBaseTableViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/27.
//

import UIKit


//extension CustomBaseTableViewController:UITableViewDelegate,UITableViewDataSource{
//    
//    //cell 行数
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    //cell
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = BaseTableViewCell().bb_baseTableViewCell(tableView: tableView, cellID: "cellID", IndexPath: indexPath)
//        return cell
//    }
//    //设置cell高度
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 0
//       }
//}


class CustomBaseTableViewController: BaseViewController {

    lazy var mainTableView: UITableView = {
        let mainTableView = UITableView.init(frame: .zero, style: UITableView.Style.plain)
        mainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        mainTableView.separatorInset = .zero
        mainTableView.estimatedRowHeight = 0
        mainTableView.estimatedSectionFooterHeight = 0
        mainTableView.estimatedSectionHeaderHeight = 0
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.backgroundColor = Default_BackGround_Color!
        if #available(iOS 15.0,*){
            mainTableView.sectionHeaderTopPadding = 0;
        }
        
        

        // 适配安全区域（iOS 11+）
               if #available(iOS 11.0, *) {
                   mainTableView.contentInsetAdjustmentBehavior = .never
                   mainTableView.scrollIndicatorInsets = view.safeAreaInsets
               } else {
                   automaticallyAdjustsScrollViewInsets = false
               }
        return mainTableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
