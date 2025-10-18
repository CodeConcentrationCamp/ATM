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
    var dict: [String: String] = [:]
    
    lazy var headView: UIView = {
        let headView = UIView().bb_ViewWithFrame(frame: CGRectMake(0, 0, KScreenWidth, 150), backgroundColor: .clear)
        
        let headTopView = UIImageView(frame: CGRectMake(15, 15, KScreenWidth - 30, 70))
        headTopView.image = UIImage(named: "info1")
        headView.addSubview(headTopView)
        
        let stepView = RZStepView(frame: CGRectMake(24, CGRectGetHeight(headTopView.frame)+30,KScreenWidth - 48 , 68), step: 2)
        stepView.clipsToBounds = true
        headView.addSubview(stepView)
        
        return headView
    }()
    
    lazy var nextStepButton: NextStepButton = {
        let nextStepButton = NextStepButton(frame: CGRect(x: 15, y:  KScreenHeight - 80 , width: KScreenWidth - 30, height: 50))
        nextStepButton.setClickHandler { [self] in
            print(self.dict)
        }
        return nextStepButton
    }()
    
    lazy var perInfoViewModel: PerInfoViewModel = {
        let perInfoViewModel = PerInfoViewModel()
        return perInfoViewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Personal Information"
        initUI()
    }
    
    func initUI(){
        self.mainTableView.frame = CGRectMake(0, navigationFullHeight, KScreenWidth, KScreenHeight - navigationFullHeight)
        self.mainTableView.backgroundColor = Default_BackGround_Color
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.view.addSubview(self.mainTableView)
        self.mainTableView.tableHeaderView = self.headView
        
        self.view.addSubview(self.nextStepButton)
        
        
        perInfoViewModel.getUserInfo2(proID: self.productID!) { state, mm in
            if state {
                if self.state == "1"{
                    
                }else{
                    if mm.counseled!.count >= 0{
                        let footView = PerInfoFooterView(frame:CGRectMake(0, 0, KScreenWidth, CGFloat(100*mm.counseled!.count+30))  , model: mm, state: self.state)
                        footView.myBlock = { value,key in
                            self.dict[key] = value
                        }
                        self.mainTableView.tableFooterView = footView
                        
                    }else{
                        self.mainTableView.tableFooterView = UIView().bb_ViewWithFrame(frame: .zero, backgroundColor: .clear)
                    }
                }
            }
        }
    }
    
    override func backClick() {
        PageRouter.jumpWanLiuBox(proID: self.productID!)
    }
    
    
}

extension PerInfoViewController:UITableViewDelegate,UITableViewDataSource{
    
    //cell 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BaseTableViewCell().bb_baseTableViewCell(tableView: tableView, cellID: "cellID", IndexPath: indexPath)
        return cell
    }
    //设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
}

