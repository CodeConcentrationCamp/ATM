//
//  ProductDetailViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/28.
//

import UIKit

class ProductDetailViewController: CustomBaseTableViewController {

    public var proID:String?
    
    lazy var viewModel: ProductModelView = {
        let viewModel = ProductModelView()
        return viewModel
    }()
    
    lazy var headView: ProductDetailHeadView = {
        let headView = ProductDetailHeadView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 158))
        return headView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Product Details";
        self.view.backgroundColor = UIColorFromHex("#F4B858")!
        if #available(iOS 15.0, *) {
         let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor =  UIColorFromHex("#F4B858")!
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = [.font:UIFont.systemFont(ofSize: 18, weight: .bold),.foregroundColor:UIColor.black]
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        initUI()
    }

    func initUI(){
        self.mainTableView.frame = CGRectMake(0, navigationFullHeight, KScreenWidth, KScreenHeight  - navigationFullHeight - tabBarFullHeight);
        self.mainTableView.backgroundColor = UIColorFromHex("#F4B858")!
        self.mainTableView.dataSource = self
        self.mainTableView.delegate = self
        self.view.addSubview(self.mainTableView)
        self.mainTableView.tableHeaderView = self.headView
        
       let gogo = UIButton(type: .custom)
        gogo.frame = CGRect(x: 15, y: CGRectGetMaxY(self.mainTableView.frame), width: KScreenWidth - 30, height: 50)
        gogo.setImage(UIImage(named: "pro5"), for: .normal)
        gogo.setBackgroundImage(UIImage(named: "pro4"), for: .normal)
        gogo.addTarget(self, action: #selector(gogoClick), for: .touchUpInside)
        self.view.addSubview(gogo)
        
        viewModel.getProductDetail(proID: self.proID)
        viewModel.upDataBlock = {  [self] state,mm in
            if state == "success"{
                viewModel.productModel = mm
                self.headView.model = mm?.plums
                self.mainTableView.reloadData()
            }
        }
    }
    
    @objc func gogoClick(){
        PageRouter.jumpPage(proID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func backClick() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension ProductDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let detailView  = ProductHeaderSectionView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: CGFloat((viewModel.productModel?.pumpkins!.count ?? 0)*62 + 61)), productModel: viewModel.productModel)
        detailView.blcok = {
            [self]  tag in
            let cellModel = viewModel.productModel?.pumpkins?[tag]
            if cellModel?.vines == "1" {
                PageRouter.handlePeaches(cellModel?.peaches,"1",proID)
            } else {
                PageRouter.jumpPage(proID)
            }
        }
        return detailView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat((viewModel.productModel?.pumpkins!.count ?? 0)*62 + 61)
    }
    
    
    
}
