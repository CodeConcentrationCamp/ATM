//
//  ProductHeaderSectionView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/28.
//

import UIKit

class ProductHeaderSectionView: UIView {
    
    var blcok: ((_ tag:Int) -> Void)?
    
    
    lazy var cellBgView: UIView = {
        
        let cellBgView = UIView().bb_ViewWithFrame(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 0), backgroundColor: Default_BackGround_Color)
        cellBgView.cornerRadius = 8;
        cellBgView.layer.borderColor = UIColorFromHex("0X1C1F1F")!.cgColor
        cellBgView.layer.borderWidth = 1
        cellBgView.layer.masksToBounds = false
        cellBgView.layer.shadowColor = UIColorFromHex("0xA89C87")!.cgColor
        cellBgView.layer.shadowOpacity =  0.5
        cellBgView.layer.shadowOffset = CGSizeMake(3, 3)
        cellBgView.layer.shadowRadius = 4
        return cellBgView
    }()
    
     init(frame: CGRect,productModel: ProductModel?) {
        super.init(frame: frame)
        initUI(productModel:productModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(productModel:ProductModel?){
        

        cellBgView.frame = CGRect(x: 15, y: 0, width: Int(KScreenWidth) - 30, height: (productModel?.pumpkins!.count ?? 0)*62 + 61)
        self.addSubview(cellBgView)
        
        let topImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cellBgView.width, height: 36))
        topImageView.image = UIImage(named: "pro2")
        cellBgView.addSubview(topImageView)
        
        for i in 0..<(productModel?.pumpkins?.count ?? 0) {
            let cell = ProductCell(frame: CGRect(x: 0, y: 51+62*i, width: Int(KScreenWidth) - 30, height: 62))
            cell.isUserInteractionEnabled = true
            cell.backgroundColor = UIColor.clear
            cell.tag = i
            cell.model = productModel?.pumpkins?[i]
            cell.addTapGesture { [weak self] tap in
                self?.blcok!(tap.view!.tag)
            }
            cellBgView.addSubview(cell)
        }
        
    }
  
    
  
  
    
}
