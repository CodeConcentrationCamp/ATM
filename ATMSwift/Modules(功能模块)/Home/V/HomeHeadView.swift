//
//  HomeHeadView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/22.
//

import UIKit

class HomeHeadView: UIView, ReplyViewDelegate {
    // 按钮点击回调（供外部调用）
    var buttonAction: (() -> Void)?
    
    // MARK: - 视图组件（统一用懒加载+SnapKit，避免硬编码frame）
    private lazy var topBgImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home1") // 默认图兜底
        iv.contentMode = .scaleToFill // 确保图片铺满
        iv.isUserInteractionEnabled = true
        // 添加点击手势（跳转逻辑）
        let tap = UITapGestureRecognizer(target: self, action: #selector(homeJump))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    private lazy var cardImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home2")
        iv.contentMode = .scaleToFill
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        UILabel.quickCreate(
            text: "Loan amount(₱)",
            textColor: .white,
            fontSize: 14,
            textAlignment: .center
        )
    }()
    
    private lazy var investMoneyLabel: UILabel = { // 改名：明确语义
        let label = UILabel.quickCreate(
            text: "",
            textColor: .white,
            fontSize: 45,
            textAlignment: .center
        )
        label.font = UIFont.boldSystemFont(ofSize: 45)
        return label
    }()
    
    private lazy var centerLeftImageV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "home3"))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var centerLeftLabel: UILabel = {
        UILabel.quickCreate(
            text: "",
            textColor: .black,
            fontSize: 14,
            textAlignment: .center
        )
    }()
    
    private lazy var centerRightImageV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "home4"))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var centerRightLabel: UILabel = {
        UILabel.quickCreate(
            text: "",
            textColor: .black,
            fontSize: 14,
            textAlignment: .center
        )
    }()
    
    private lazy var rateLabel: UILabel = {
        UILabel.quickCreate(
            text: "Interest rate",
            textColor: .white,
            fontSize: 12,
            textAlignment: .center
        )
    }()
    
    private lazy var termLabel: UILabel = {
        UILabel.quickCreate(
            text: "Loan Term",
            textColor: .white,
            fontSize: 12,
            textAlignment: .center
        )
    }()
    
    private lazy var goBgImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "home5"))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var goImageView: UIImageView = {
        UIImageView(image: UIImage(named: "home6"))
    }()
    
    private lazy var handImageView: UIImageView = {
        UIImageView(image: UIImage(named: "home7"))
    }()
    
    private lazy var yqBgImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "home15"))
        iv.isHidden = true // 默认隐藏
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var replyView: ReplyView = {
        let view = ReplyView()
        view.isUserInteractionEnabled = true
        view.delegate = self
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 布局（全 SnapKit，无硬编码frame，适配所有屏幕）
    private func initUI() {
        // 1. 顶层背景图（铺满整个HeadView）
        addSubview(topBgImageView)
        topBgImageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        // 2. 卡片图片（固定top=66，高度307）
        topBgImageView.addSubview(cardImageView)
        cardImageView.snp.makeConstraints { make in
            make.top.equalTo(66)
            make.left.right.equalTo(topBgImageView)
            make.height.equalTo(307)
        }
        
        // 3. 标题（Loan amount）
        cardImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(cardImageView)
            make.top.equalTo(40)
        }
        
        // 4. 金额（investMoney）
        cardImageView.addSubview(investMoneyLabel)
        investMoneyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(cardImageView)
            make.top.equalTo(titleLabel.snp.bottom) // 紧跟标题下方
        }
        
        // 5. 左侧图标+文字（利率相关）
        cardImageView.addSubview(centerLeftImageV)
        centerLeftImageV.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 120, height: 33))
            make.centerX.equalTo(cardImageView).offset(-65)
            make.top.equalTo(investMoneyLabel.snp.bottom) // 紧跟金额下方
        }
        centerLeftImageV.addSubview(centerLeftLabel)
        centerLeftLabel.snp.makeConstraints { make in
            make.centerX.equalTo(centerLeftImageV.snp.centerX)
            make.centerY.equalTo(centerLeftImageV.snp.centerY).offset(2)
        }
        
        // 6. 右侧图标+文字（期限相关）
        cardImageView.addSubview(centerRightImageV)
        centerRightImageV.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 120, height: 33))
            make.centerX.equalTo(cardImageView).offset(65)
            make.centerY.equalTo(centerLeftImageV) // 与左侧图标对齐Y轴
        }
        centerRightImageV.addSubview(centerRightLabel)
        centerRightLabel.snp.makeConstraints { make in
            make.centerX.equalTo(centerRightImageV.snp.centerX)
            make.centerY.equalTo(centerRightImageV.snp.centerY).offset(2) // 同左侧微调
        }
        
        // 7. 利率说明文字（Interest rate）
        cardImageView.addSubview(rateLabel)
        rateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(centerLeftImageV)
            make.top.equalTo(centerLeftImageV.snp.bottom).offset(3) // 图标下方3pt
        }
        
        // 8. 期限说明文字（Loan Term）
        cardImageView.addSubview(termLabel)
        termLabel.snp.makeConstraints { make in
            make.centerX.equalTo(centerRightImageV)
            make.centerY.equalTo(rateLabel) // 与利率文字对齐Y轴
        }
        
        // 9. 底部按钮背景（Go Borrow）
        cardImageView.addSubview(goBgImageView)
        goBgImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 250, height: 48))
            make.bottom.equalTo(cardImageView).offset(-18) // 距离卡片底部18pt
            make.centerX.equalTo(cardImageView)
        }
        
        // 10. 按钮内部图标（Go文字+手图标）
        goBgImageView.addSubview(goImageView)
        goImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 102, height: 17))
            make.centerY.equalTo(goBgImageView)
            make.centerX.equalTo(goBgImageView)
        }
        goBgImageView.addSubview(handImageView)
        handImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 35, height: 39))
            make.top.equalTo(15)
            make.right.equalTo(10)
        }
        
        // 11. 底部提示背景（yqBg）
        topBgImageView.addSubview(yqBgImageView)
        yqBgImageView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15) // 左右各留15pt间距
            make.height.equalTo(38)
            make.top.equalTo(cardImageView.snp.bottom).offset(17) // 卡片下方17pt（原380=66+307+7，优化为动态计算）
        }
        
        // 12. 提示背景内的ReplyView
        yqBgImageView.addSubview(replyView)
        replyView.snp.makeConstraints { make in
            make.left.equalTo(60)
            make.right.equalTo(-30) // 原frame计算：宽=屏幕宽-120-30，改为动态约束
            make.top.bottom.equalTo(yqBgImageView)
        }
    }
    
    // MARK: - 数据绑定（安全解包，无强制!）
    func bindViewModel(_ viewModel: HomeViewModel?) {
        guard let viewModel = viewModel else { return }
        
        // 1. 基础数据赋值
        investMoneyLabel.text = viewModel.investMoney
        centerLeftLabel.text = viewModel.rate
        centerRightLabel.text = viewModel.day
        replyView.titlesGroup = viewModel.titleArray
        
        // 2. 视图状态控制（安全判断，避免强制解包）
        yqBgImageView.isHidden = viewModel.isYqBgHidden
        replyView.isHidden = viewModel.isYqBgHidden // ReplyView 与 yqBg 同隐藏状态
        
        // 3. 背景图与高度更新
        let targetHeight = viewModel.viewHeight
        topBgImageView.image = UIImage(named: viewModel.topBgImageName) ?? UIImage(named: "home11") // 默认图兜底
        // 更新自身高度（供外部TableView Header刷新）
        self.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: targetHeight)
    }
    
    // MARK: - 事件处理
    @objc private func homeJump() {
        buttonAction?()
    }
    
    // MARK: - ReplyViewDelegate（空实现，保留协议方法）
    func topLineView(_ topLine: ReplyView!, didScrollTo index: Int) {}
    func topLineView(_ topLine: ReplyView!, didSelectItemAt index: Int) {}
}

