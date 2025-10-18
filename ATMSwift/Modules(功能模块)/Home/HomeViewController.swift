//
//  HomeViewController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/21.
//

import UIKit
import SwiftUICore
import Combine

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - 属性
    var viewModel = HomeViewModel()
    // 统一管理 Combine 订阅，防止内存泄漏
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - 视图组件（初始高度设为0，后续通过数据动态调整）
    private lazy var headView: HomeHeadView = {
        let headView = HomeHeadView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 0))
        headView.buttonAction = { [weak self] in
            guard let self = self else { return }
            self.viewModel.goBorrowTapped(self)
        }
        return headView
    }()
    
    private lazy var footView: HomeFootView = {
        let footView = HomeFootView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 680))
        return footView
    }()
    
    private lazy var tableView: UITableView = {
        let mainTableView = UITableView(frame: .zero, style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        // 安全设置背景色：用默认值避免强制解包
        mainTableView.backgroundColor = Default_BackGround_Color
        mainTableView.separatorColor = UIColor.clear
        mainTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.sectionHeaderTopPadding = 0
        mainTableView.estimatedSectionFooterHeight = 0
        mainTableView.estimatedSectionHeaderHeight = 0
        return mainTableView
    }()
    
    // MARK: - 生命周期
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 跟随系统动画状态，避免切换页面卡顿
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getCity()
        bindViewModel() // 优先绑定，避免数据回来后未监听
        viewModel.homeDetail()
    }
    
    deinit {
        // 可选：Set<AnyCancellable> 销毁时会自动清空，保留更严谨
        cancellables.removeAll()
    }
    
    // MARK: - UI 布局
    private func setupUI() {
        tableView.tableHeaderView = headView
        view.addSubview(tableView)
        // 约束适配：顶部顶到安全区上方，覆盖导航栏区域
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view.snp.top).offset(-safeDistanceTop)
        }
    }
    
    // MARK: - 城市数据获取
    private func getCity() {
        guard CityModel.getAdressSettingModel() == nil else { return }
        // 后续若需处理城市数据，可在回调内补充逻辑（如刷新UI）
        CityModel.getAddSuccess { _ in }
    }
    
    // MARK: - ViewModel 绑定（统一管理订阅，避免重复触发）
    private func bindViewModel() {
        // 1. 监听数据加载状态（首次加载完成触发）
        viewModel.$isDataLoaded
            .receive(on: DispatchQueue.main) // 确保UI操作在主线程
            .sink { [weak self] _ in
                self?.updateUI()
            }
            .store(in: &cancellables)
        
        // 2. 监听 homeModel 变化（数据更新时触发）
        viewModel.$homeModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateUI()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - UI 刷新（仅负责UI更新，无业务逻辑）
    private func updateUI() {

        // 1. 更新头部视图数据和高度
        headView.bindViewModel(viewModel)
        let targetHeadHeight = viewModel.adaptHeadHeight  // 默认高度兜底
        headView.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: targetHeadHeight)
        tableView.tableHeaderView = headView // 重新赋值以刷新Header高度
        
        // 2. 配置底部视图（安全判断是否显示）
        let footerView: UIView
        if self.viewModel.isShowFoot {
            footerView = self.footView
        } else {
            // 空白底部视图：高度20，背景色与列表一致
            footerView = UIView.quickCreate(
                frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 20),
                bgColor: Default_BackGround_Color ?? .white
            )
        }
        tableView.tableFooterView = footerView
        
        // 3. 刷新列表数据
        tableView.reloadData()
    }
}

// MARK: - UITableView 代理方法
extension HomeViewController {
    // 列表行数（安全获取，避免数组越界）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numRowHeight()
    }
    
    // 列表单元格（安全赋值，避免复用旧数据）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.selectionStyle = .none
        // 安全判断数组索引，防止越界
        if let cellModels = viewModel.getCellModel(), indexPath.row < cellModels.count {
            cell.proModel = cellModels[indexPath.row]
        } else {
            cell.proModel = nil // 清空复用的旧数据
        }
        return cell
    }
    
    // 单元格高度（固定130，若需动态高度可从ViewModel获取）
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
    // 单元格点击（后续可补充点击逻辑）
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
