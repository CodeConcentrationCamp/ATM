//
//  KYCViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/30.
//

import UIKit

class KYCViewController: CustomBaseTableViewController {

    var productID:String?
    var selectTitle:String?
    var firstArr: [StringItem] = []
    // 等价写法
    var lastArr = [StringItem]()
    
    // 定义模型结构体（替代字典，类型更安全）
    struct StringItem {
        let originalString: String
        var isSelected: String
    }
    
    lazy var rzViewModel: RZViewModel = {
        let rzViewModel = RZViewModel()
        return rzViewModel
    }()
    
    lazy var nextStepButton: NextStepButton = {
        
        let nextStepButton = NextStepButton(frame: CGRect(x: 15, y: CGRectGetMaxY(self.mainTableView.frame) - 80 , width: KScreenWidth - 30, height: 50))
        nextStepButton.setClickHandler { [self] in
            
            if self.selectTitle?.isEmpty ?? true {
                ShowTip.showMessage("Select CardType")
                return
            }
            let vc = VerIDViewController()
            vc.productID = self.productID ?? ""
            vc.selectTitle = self.selectTitle!
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        return nextStepButton
    }()
    
    func initUI(){
        self.title = "E_KYC"
        self.mainTableView.frame = CGRectMake(0, navigationFullHeight, KScreenWidth, KScreenHeight - navigationFullHeight)
        self.mainTableView.register(BaseTableViewCell.self, forCellReuseIdentifier: "cellID")
        self.mainTableView.dataSource = self
        self.mainTableView.delegate = self
        self.mainTableView.tableHeaderView = UIView().bb_ViewWithFrame(frame: CGRectMake(0, 0, KScreenWidth, 20), backgroundColor: UIColor.clear)
        self.view.addSubview(self.mainTableView)
        self.view.addSubview(self.nextStepButton)
    }
    
    func initData(){
        let rzViewModel = RZViewModel()
        rzViewModel.getUserInfo(proID: self.productID)
        rzViewModel.upDataBlock = { [self] state, mm in
            if state == "success"{
                if mm != nil{
                    if let firstA = mm?.sport?.first{
                        self.firstArr = changArr(firstA)
                    }
                    if let lastA = mm?.sport?.last{
                        self.lastArr = changArr(lastA)
                    }
                        self.mainTableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
    
    
    override func backClick() {
        PageRouter.jumpWanLiuBox(proID: self.productID!)
    }
}

extension KYCViewController:UITableViewDelegate,UITableViewDataSource{
    
    //cell 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
    
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BaseTableViewCell().bb_baseTableViewCell(tableView: tableView, cellID: "cellID", IndexPath: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    //设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
       }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var value = 0
        if self.firstArr.count != 0{
            value = self.firstArr.count
        }else{
            return UIView(frame: CGRectMake(0, 0, KScreenWidth, 0.001))
        }
        
        let headView = KYCCellView(frame: CGRectMake(0, 0, KScreenWidth, CGFloat(value*52 + 51)), type: 1, arr: self.firstArr)
        headView.isUserInteractionEnabled = true
        
        headView.kycBlock =  { [self] tag, arr in
            self.changeArr(oneArr: &self.firstArr, twoArr: &self.lastArr, tag: tag)
            self.mainTableView.reloadData()
        }
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.firstArr.count == 0{
            return 0.001
        }
        return CGFloat(self.firstArr.count*52 + 51)
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        var value = 0
        if self.lastArr.count != 0{
            value = self.lastArr.count
        }else{
            return UIView(frame: CGRectMake(0, 0, KScreenWidth, 0.001))
        }
        
        let footView = KYCCellView(frame: CGRectMake(0, 0, KScreenWidth, CGFloat(value*52 + 51)), type: 0, arr: self.lastArr)
        footView.isUserInteractionEnabled = true
        
        footView.kycBlock =  { [self] tag, arr in
            self.changeArr(oneArr: &self.lastArr, twoArr: &self.firstArr, tag: tag)
            self.mainTableView.reloadData()
        }
        return footView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.lastArr.count == 0{
            return 0.001
        }
        return CGFloat(self.lastArr.count*52 + 51)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


extension KYCViewController{
    
    // 转换方法（返回 [StringItem] 而非 NSMutableArray）
     func changArr(_ arr: [String]) -> [StringItem] {
        return arr.map { str in
            StringItem(originalString: str, isSelected: "0")
        }
    }

    func changeArr(oneArr: inout [StringItem], twoArr: inout [StringItem], tag: Int) {
        // 处理 oneArr：根据 tag 选中对应项，其他项取消选中
        for i in 0..<oneArr.count {
            var item = oneArr[i] // 复制一份临时变量（struct 是值类型）
            if tag == i {
                self.selectTitle = item.originalString // 假设 selectTitle 是当前类的属性
                item.isSelected = "1"
            } else {
                item.isSelected = "0"
            }
            oneArr[i] = item // 将修改后的临时变量赋值回数组
        }
        
        // 处理 twoArr：所有项取消选中
        for j in 0..<twoArr.count {
            var itemL = twoArr[j]
            itemL.isSelected = "0"
            twoArr[j] = itemL // 赋值回数组
        }
    }
}
