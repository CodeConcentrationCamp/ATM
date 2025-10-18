//
//  AdressCictSelectView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/17.
//

import UIKit

/// 地址选择弹框视图
class AddressCictSelectView: UIView {
    
    
    // MARK: - 属性
    private lazy var containerView: UIImageView = {
        let containerView = UIImageView(frame: .zero)
        containerView.image = UIImage(named: "rz50")
        containerView.contentMode = .scaleToFill
        return containerView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel().bb_LabelWithFrame(frame: .zero, text: "Select Address", textColor: UIColorFromHex("0x23BEC7")!, fontSize: 16, textAlignment: .center)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        return titleLabel
    }()
    
    
    private lazy var sfButton: UIButton = {
        let sfButton = UIButton(type: .custom)
        sfButton.setTitle("Choose", for: .normal)
        sfButton.setTitleColor(UIColorFromHex("0x23BEC7"), for: .normal)
        sfButton.contentHorizontalAlignment = .center
        sfButton.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        sfButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return sfButton
    }()
    
    
    @objc private func btnTapped(_ sender: UIButton) {
        
        if sender == self.sfButton{
            self.state = 0
            sender.setTitle("Choose", for: .normal)
            sender.setTitleColor(UIColorFromHex("0x23BEC7"), for: .normal)
            
            self.cityButton.setTitle("Choose", for: .normal)
            self.cityButton.setTitleColor(UIColorFromHex("0x23BEC7"), for: .normal)
            
            self.qyButton.setTitle("Choose", for: .normal)
            self.qyButton.setTitleColor(UIColorFromHex("0x23BEC7"), for: .normal)
            self.sfSeectedRegion = ""
            self.citySectedRegion = ""
            self.qySelectedRegion = ""
            self.tableView.reloadData()
        }
        
        if sender == self.cityButton{
            self.state = 1
            sender.setTitle("Choose", for: .normal)
            sender.setTitleColor(UIColorFromHex("0x23BEC7"), for: .normal)
            
            self.qyButton.setTitle("Choose", for: .normal)
            self.qyButton.setTitleColor(UIColorFromHex("0x23BEC7"), for: .normal)
            self.citySectedRegion = ""
            self.qySelectedRegion = ""
            self.tableView.reloadData()
        }
        
        if sender == self.qyButton{
        }
    }
    
    private lazy var cityButton: UIButton = {
        let cityButton = UIButton(type: .custom)
        cityButton.setTitle("Choose", for: .normal)
        cityButton.setTitleColor(UIColorFromHex("0x23BEC7"), for: .normal)
        cityButton.contentHorizontalAlignment = .center
        cityButton.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        cityButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return cityButton
    }()
    
    private lazy var qyButton: UIButton = {
        let qyButton = UIButton(type: .custom)
        qyButton.setTitle("Choose", for: .normal)
        qyButton.setTitleColor(UIColorFromHex("0x23BEC7"), for: .normal)
        qyButton.contentHorizontalAlignment = .center
        qyButton.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        qyButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return qyButton
    }()
    
    private lazy var nextStepButton: NextStepButton = {
        let nextStepButton = NextStepButton(frame: .zero ,"id1")
        nextStepButton.setClickHandler { [self] in
            confirmButtonTapped()
        }
        return nextStepButton
    }()
    
    private  lazy var closeButton: UIButton = {
          let closeButton = UIButton(type: .custom)
          closeButton.setImage(UIImage(named: "common1"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.isUserInteractionEnabled = true
        return closeButton
      }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = Default_BackGround_Color
        
        return tableView
    }()
    
    
    
    // 区域数据
    private var state: Int = 0
    private var currIndexSFRow: Int = 0
    private var currIndexCityRow: Int = 0
    
    // 选中的区域
    private var sfSeectedRegion: String?
    private var citySectedRegion: String?
    private var qySelectedRegion: String?
    // 确认回调
    var confirmHandler: ((String) -> Void)?
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - UI 设置
    private func setupUI() {
        // 背景半透明遮罩
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        // 容器视图
        self.isUserInteractionEnabled = true
        containerView.isUserInteractionEnabled = true
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.width.equalTo(380)
            make.height.equalTo(400)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        // 标题标签
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(20)
            make.top.equalTo(27)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        containerView.addSubview(sfButton)
        sfButton.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.width.equalTo((380 - 30)/3)
        }
        
        containerView.addSubview(cityButton)
        cityButton.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(sfButton.snp.centerY)
            make.height.equalTo(20)
            make.width.equalTo((380 - 30)/3)
        }
        
        containerView.addSubview(qyButton)
        qyButton.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalTo(cityButton.snp.centerY)
            make.height.equalTo(20)
            make.width.equalTo((380 - 30)/3)
        }
        
        containerView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(sfButton.snp.bottom).offset(10)
            make.height.equalTo(220)
        }
        
        containerView.addSubview(nextStepButton)
        nextStepButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(43)
            make.centerX.equalTo(containerView.snp.centerX)
            make.bottom.equalTo(containerView.snp.bottom).offset(-24)
        }
        
        addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.centerX.equalTo(containerView.snp.centerX)
            make.top.equalTo(containerView.snp.bottom).offset(15)
        }
    }
    
    // MARK: - 按钮点击事件
    private func confirmButtonTapped() {
        
        // 检查任一地址项为空字符串或 nil，提前提示
        guard let sf = sfSeectedRegion, !sf.isEmpty,
              let city = citySectedRegion, !city.isEmpty,
              let qy = qySelectedRegion, !qy.isEmpty else {
            ShowTip.showMessage("Please select an address")
            return
        }

        // 直接拼接非空且有值的地址，无强制解包风险
        let region = "\(sf)-\(city)-\(qy)"
        confirmHandler?(region)
        removeFromSuperview()
    }
    
    @objc private func closeButtonTapped() {
        removeFromSuperview()
    }
    
    // MARK: - 显示弹框
    func show() {
        guard let window = Router.shared.getCurrentKeyWindow() else { return }
        window.addSubview(self)
        frame = window.bounds
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension AddressCictSelectView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case 0: return CityModel.getSFArray().count
        case 1: return CityModel.getCityPass(row: currIndexSFRow).count
        case 2: return CityModel.getSf(dfRow: currIndexSFRow, cityRow: currIndexCityRow).count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = Default_BackGround_Color
        
        // 根据状态获取对应数据和文字
        let text: String?
        switch state {
        case 0:
            let sfArray = CityModel.getSFArray()
            text = sfArray.indices.contains(indexPath.row) ? sfArray[indexPath.row].subsided : nil
        case 1:
            let cityArr = CityModel.getCityPass(row: currIndexSFRow)
            text = cityArr.indices.contains(indexPath.row) ? cityArr[indexPath.row].subsided : nil
        case 2:
            let quArr = CityModel.getSf(dfRow: currIndexSFRow, cityRow: currIndexCityRow)
            text = quArr.indices.contains(indexPath.row) ? quArr[indexPath.row].subsided : nil
        default:
            text = nil
        }
        
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch state {
        case 0:
            let sfArray = CityModel.getSFArray()
            guard sfArray.indices.contains(indexPath.row) else { return }
            let sfModel = sfArray[indexPath.row]
            sfButton.setTitle(sfModel.subsided, for: .normal)
            sfButton.setTitleColor(.black, for: .normal)
            currIndexSFRow = indexPath.row
            state = 1
            self.sfSeectedRegion = sfModel.subsided
        case 1:
            let cityArr = CityModel.getCityPass(row: currIndexSFRow)
            guard cityArr.indices.contains(indexPath.row) else { return }
            let cityModel = cityArr[indexPath.row]
            cityButton.setTitle(cityModel.subsided, for: .normal)
            cityButton.setTitleColor(.black, for: .normal)
            currIndexCityRow = indexPath.row
            self.citySectedRegion = cityModel.subsided
            state = 2
            
        case 2:
            let quArr = CityModel.getSf(dfRow: currIndexSFRow, cityRow: currIndexCityRow)
            guard quArr.indices.contains(indexPath.row) else { return }
            let quModel = quArr[indexPath.row]
            qyButton.setTitle(quModel.subsided, for: .normal)
            qyButton.setTitleColor(.black, for: .normal)
            self.qySelectedRegion = quModel.subsided
        default: break
        }
        
        tableView.reloadData()
    }
}
