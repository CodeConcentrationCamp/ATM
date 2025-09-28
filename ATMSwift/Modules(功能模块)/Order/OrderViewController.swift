//
//  OrderViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/21.
//

import UIKit


class OrderViewController: BaseViewController{
    
    
    lazy var viewModel: OrderViewModel = {
        let viewModel = OrderViewModel()
        return viewModel
    }()
    
    
    // 定义索引和位置的映射关系
    let indexPositionMap: [String: Int] = [
        "4": 0,
        "6": 1,
        "7": 2,
        "5": 3
    ]
    let indexValueMap: [Int: String] = [
        0: "4",
        1: "6",
        2: "7",
        3: "5"
    ]
    
    let imageArr = ["grzx_all_ic","grzx_repayment_ic","grzx_applying_ic","grzx_finish_ic"];
    let titleArr = ["All","Repayment","Applying","Finish"];
    
    var selectButton = UIButton()
    
    var selectButtonArray = Array<UIButton>()
    
    lazy var headBgView: UIView = {
        let headBgView = UIView().bb_ViewWithFrame(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 268), backgroundColor: UIColorFromHex("0xF4B858")!)
        
        let topImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 167))
        topImageView.image = UIImage(named: "order1")
        headBgView.addSubview(topImageView)
        
        
        for i in 0..<imageArr.count {
            let itemButton = UIButton(frame: itemFrame(for: i))
            itemButton.setTitle(titleArr[i], for: .normal)
            itemButton.setImage(UIImage(named: imageArr[i]), for: .normal)
            itemButton.setTitleColor(UIColorFromHex("0x666666"), for: .normal)
            itemButton.setTitleColor(UIColorFromHex("0x1C1F1F"), for: .selected)
            itemButton.setBackgroundImage(UIImage(named: "rz83"), for: .normal)
            itemButton.setBackgroundImage(UIImage(named: "grzx_bg_01"), for: .selected)
            itemButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            itemButton.tag = i
            itemButton.setImagePosition(.top, spacing: 5)
            itemButton.addTarget(self, action: #selector(itemButtonClick), for: .touchUpInside)
            selectButtonArray.append(itemButton)

            // 简化后的判断逻辑
            if let index = ToolManager.shared.getData(forKey: "ATM_OrderIndex") as? String,
               let targetIndex = indexPositionMap[index],
               i == targetIndex {
                itemButton.isSelected = true
                selectButton = itemButton
            } else if (ToolManager.shared.getData(forKey: "ATM_OrderIndex") as? String) == nil, i == 0 {
                // 当没有索引数据时，默认选中第0个
                itemButton.isSelected = true
                selectButton = itemButton
            }
            headBgView.addSubview(itemButton)
        }
        return headBgView
    }()
    
    @objc func itemButtonClick(button:UIButton){
        if button == self.selectButton{
            return
        }
        self.selectButton = button
        button.isSelected = true
        for i in 0..<self.selectButtonArray.count {
            let bb = self.selectButtonArray[i]
            if button.tag == i{
                // 通过索引获取对应值并存储，简洁明了
                if let value = indexValueMap[i] {
                    ToolManager.shared.saveData(value, forKey: "ATM_OrderIndex")
                }
                bb.isSelected = true
            }else{
                bb.isSelected = false
            }
        }
        loadNewData()
    }
    
    lazy var mainTableView: UITableView = {
        let mainTableView = UITableView.init(frame: .zero, style: UITableView.Style.plain)
        mainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        mainTableView.separatorInset = .zero
        mainTableView.estimatedRowHeight = 0
        mainTableView.estimatedSectionFooterHeight = 0
        mainTableView.estimatedSectionHeaderHeight = 0
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(OrderTableViewCell.self, forCellReuseIdentifier: "OrderTableViewCell")
        mainTableView.backgroundColor = Default_BackGround_Color!
        if #available(iOS 15.0,*){
            mainTableView.sectionHeaderTopPadding = 0;
            mainTableView.contentInsetAdjustmentBehavior = .never
            mainTableView.scrollIndicatorInsets = mainTableView.contentInset
        }
        
        return mainTableView
    }()
    
    func loadNewData(){
        // 先获取本地存储的状态，若为nil则使用默认值"4"
        let state = ToolManager.shared.getData(forKey: "ATM_OrderIndex") as? String ?? "4"
        // 直接调用接口
        viewModel.getProductDetailState(state: state)
        viewModel.upDataBlock = { [self] state,mm in
            if state == "success"{
                viewModel.orderModel = mm
                self.mainTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNewData()
    }
    
    func initUI(){
        self.view.addSubview(self.headBgView)
        self.view.backgroundColor = UIColorFromHex("0xF4B858")
        self.mainTableView.frame = CGRect(x: 10, y: 268, width: KScreenWidth - 20, height: KScreenHeight - 268 - 15 - tabBarFullHeight)
        let bgTableView = UIImageView(frame: self.mainTableView.bounds)
        bgTableView.image = UIImage(named: "order2")
        self.mainTableView.backgroundColor = UIColor.clear
        self.mainTableView.backgroundView = bgTableView
        self.view.addSubview(self.mainTableView)
    }
    
    func itemFrame(for index: Int) -> CGRect {
        // 提取常量参数
        let margin: CGFloat = 10                // 间距
        let totalMargin: CGFloat = 5 * margin   // 总间距（5个间隔）
        let itemCount: CGFloat = 4              // 一行的item数量
        
        // 计算单个item的宽度（只计算一次）
        let itemWidth = (KScreenWidth - totalMargin) / itemCount
        
        // 计算x坐标（基础偏移 + 索引对应的偏移）
        let itemX = margin + (itemWidth + margin) * CGFloat(index)
        
        // 固定的y坐标和高度
        let itemY: CGFloat = 177
        let itemHeight: CGFloat = 75
        
        return CGRect(x: itemX, y: itemY, width: itemWidth, height: itemHeight)
    }
}


extension OrderViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orderModel?.standing?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
        cell.selectionStyle =  .none
        if viewModel.orderModel?.standing?.count ?? 0 > 0 {
            cell.orderModel = viewModel.orderModel?.standing![indexPath.row]
        }
        return cell
    }
    
}
