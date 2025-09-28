//
//  HomeFootView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/27.
//

import UIKit
import FSPagerView

class HomeFootView: UIView {
    
    lazy var pagerView : FSPagerView = {
        let pagerView = FSPagerView(frame: CGRect(x: 15, y: 48, width: self.width - 60, height: 200))
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval =  3
        pagerView.isInfinite = true
        pagerView.interitemSpacing = 0
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FLBannerCell")
        return pagerView
    }()
    
    let dataArr =  ["home12","home13","home14"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    func initUI(){
        let footTopImageView = UIImageView(frame:CGRect(x: 15, y: 10, width: KScreenWidth - 30, height: 147))
        footTopImageView.image = UIImage(named: "home8")
        self.addSubview(footTopImageView)
        
        let footCenterImageView = UIImageView(frame:CGRect(x:15, y:167,width: KScreenWidth - 30, height:264))
        footCenterImageView.image = UIImage(named: "home9")
        self.addSubview(footCenterImageView)
        footCenterImageView.addSubview(self.pagerView)
        
        let footBoomImageView = UIImageView(frame:CGRect(x: 15, y: 441, width: KScreenWidth - 30, height: 225))
        footBoomImageView.image = UIImage(named: "home10")
        self.addSubview(footBoomImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension HomeFootView: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return dataArr.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "FLBannerCell", at: index)
        cell.imageView?.image = UIImage(named: dataArr[index])
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
    }
}
