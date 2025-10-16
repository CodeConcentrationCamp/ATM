//
//  VerifyIDFinishViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/30.
//

import UIKit

class VerifyIDFinishViewController: CustomBaseTableViewController {

    var productID:String?
    
    lazy var dayLabel: UILabel = {
        let dayLabel = UILabel().bb_LabelWithFrame(frame: .zero, text: "", textColor: Default_Black0_Color!, fontSize: 14, textAlignment: .center)
        return dayLabel
    }()
    
    lazy var nameTextFild: UITextField = {
        nameTextFild = UITextField(frame: .zero)
        nameTextFild.font = UIFont.systemFont(ofSize: 14)
        nameTextFild.textColor = Default_Black3_Color!
        nameTextFild.textAlignment = .center
        return nameTextFild
    }()
    
    lazy var idTextFild: UITextField = {
        idTextFild = UITextField(frame: .zero)
        idTextFild.font = UIFont.systemFont(ofSize: 14)
        idTextFild.textColor = Default_Black3_Color!
        idTextFild.textAlignment = .center
        return idTextFild
    }()
    
    
    lazy var boomImg: UIImageView = {
        let boomImg = UIImageView(frame: .zero)
        boomImg.image = UIImage(named: "rz73")
        return  boomImg
    }()
    
    lazy var nextStepButton: NextStepButton = {
        
        let nextStepButton = NextStepButton(frame: CGRect(x: 15, y: CGRectGetMaxY(self.mainTableView.frame) - 80, width: KScreenWidth - 30, height: 50))
        nextStepButton.setClickHandler {
            print("Next Step Button Clicked!")
            PageRouter.jumpPage(self.productID)
        }
        return nextStepButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.view.backgroundColor =  UIColorFromHex("0X23BEC7")!
        if #available(iOS 15.0, *) {
         let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor =  UIColorFromHex("0X23BEC7")!
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = [.font:UIFont.systemFont(ofSize: 18, weight: .bold),.foregroundColor:UIColor.black]
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        initUI()
        initData()
    }
    
    func initUI(){
        self.mainTableView.frame = CGRectMake(0, navigationFullHeight, KScreenWidth, KScreenHeight - navigationFullHeight)
        self.mainTableView.backgroundColor = UIColorFromHex("0X23BEC7")!
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.view.addSubview(self.mainTableView)
        
        
        let headView = UIView().bb_ViewWithFrame(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 688), backgroundColor: UIColorFromHex("0X23BEC7")!)
        self.mainTableView.tableHeaderView = headView
        
        let bgView = UIView().bb_ViewWithFrame(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 340), backgroundColor: UIColorFromHex("0X23BEC7")!)
        headView.addSubview(bgView)
        
        let bgImg = UIImageView(frame: .zero)
        bgImg.image = UIImage(named: "rz70")
        bgView.addSubview(bgImg)
        bgImg.snp.makeConstraints { make in
            make.width.equalTo(251)
            make.height.equalTo(200)
            make.centerX.equalTo(bgView.snp.centerX)
            make.top.equalTo(10)
        }
        
        let ztImg = UIImageView(frame: .zero)
        bgView.addSubview(ztImg)
        ztImg.image = UIImage(named: "rz71")
        ztImg.snp.makeConstraints { make in
            make.width.equalTo(278)
            make.height.equalTo(64)
            make.centerX.equalTo(bgView.snp.centerX)
            make.top.equalTo(bgImg.snp.bottom).offset(10)
        }
        
        boomImg.frame = CGRectMake(0, CGRectGetHeight(bgView.frame), KScreenWidth, 22)
        headView.addSubview(boomImg)
        
    
        let card1 = UIImageView(frame: .zero)
        card1.image = UIImage(named: "rz72")
        headView.addSubview(card1)
        card1.isUserInteractionEnabled = false
        card1.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(86)
            make.top.equalTo(boomImg.snp.bottom).offset(20)
            make.centerX.equalTo(headView.snp.centerX)
        }
        
        let cardL = UILabel().bb_LabelWithFrame(frame: .zero, text: "Full Name", textColor: Default_Black3_Color!, fontSize: 14, textAlignment: .center)
        cardL.font = UIFont.boldSystemFont(ofSize: 14)
        card1.addSubview(cardL)
        cardL.snp.makeConstraints { make in
            make.centerX.equalTo(card1.snp.centerX)
            make.top.equalTo(card1.snp.top).offset(12)
        }
        
        card1.addSubview(nameTextFild)
        nameTextFild.snp.makeConstraints { make in
            make.centerX.equalTo(card1.snp.centerX)
            make.bottom.equalTo(-3)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(44)
        }
        
        let card2 = UIImageView(frame: .zero)
        card2.image = UIImage(named: "rz72")
        headView.addSubview(card2)
        card2.isUserInteractionEnabled = false
        card2.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(86)
            make.top.equalTo(card1.snp.bottom).offset(15)
            make.centerX.equalTo(headView.snp.centerX)
        }
        
        card2.addSubview(idTextFild)
        idTextFild.snp.makeConstraints { make in
            make.centerX.equalTo(card2.snp.centerX)
            make.bottom.equalTo(-3)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(44)
        }
        
        let card2L = UILabel().bb_LabelWithFrame(frame: .zero, text: "ID NO.", textColor: Default_Black3_Color!, fontSize: 14, textAlignment: .center)
        card2L.font = UIFont.boldSystemFont(ofSize: 14)
        card2.addSubview(card2L)
        card2L.snp.makeConstraints { make in
            make.centerX.equalTo(card2.snp.centerX)
            make.top.equalTo(card2.snp.top).offset(12)
        }
        
        let card3 = UIImageView(frame: .zero)
        card3.image = UIImage(named: "rz72")
        headView.addSubview(card3)
        card3.isUserInteractionEnabled = false
        card3.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(86)
            make.top.equalTo(card2.snp.bottom).offset(15)
            make.centerX.equalTo(headView.snp.centerX)
        }
        
        let card3L = UILabel().bb_LabelWithFrame(frame: .zero, text: "Date of Birth", textColor: Default_Black3_Color!, fontSize: 14, textAlignment: .center)
        card3L.font = UIFont.boldSystemFont(ofSize: 14)
        card3.addSubview(card3L)
        card3L.snp.makeConstraints { make in
            make.centerX.equalTo(card3.snp.centerX)
            make.top.equalTo(card3.snp.top).offset(12)
        }
        self.view.addSubview(nextStepButton)
        
        card3.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.centerX.equalTo(card3.snp.centerX)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(-3)
            make.height.equalTo(44)
        }
    }
    
    func initData(){
        let rzViewModel = RZViewModel()
        rzViewModel.getUserInfo(proID: self.productID)
        rzViewModel.upDataBlock = { [self] state, mm in
            if state == "success"{
                if mm != nil{
                    self.nameTextFild.text = mm?.steeple?.taller?.subsided ?? ""
                    self.dayLabel.text = mm?.steeple?.taller?.slice ?? ""
                    self.idTextFild.text = mm?.steeple?.taller?.excitement ?? ""
                }
            }
        }

    }
    
    override func backClick() {
        PageRouter.jumpWanLiuBox(proID: self.productID!)
    }
}

extension VerifyIDFinishViewController:UITableViewDelegate,UITableViewDataSource{
    
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
