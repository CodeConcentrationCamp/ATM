//
//  BaseTableViewCell.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/26.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareUI()
     
    }
    
    public func bb_baseTableViewCell(tableView:UITableView,cellID:String,IndexPath:IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID,for: IndexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func prepareUI() {}
    

}
