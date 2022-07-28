//
//  CategoryCollectionViewCell.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/27.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    var wordLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
        self.cardShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        self.addSubview(wordLabel)
        wordLabel.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: Constants.cellHorizontalInterval, paddingBottom: 0, paddingRight: Constants.cellHorizontalInterval)
        }
}
