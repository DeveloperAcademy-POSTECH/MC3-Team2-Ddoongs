//
//  CategoryCollectionViewCell.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/27.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    var wordLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        render()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        render()
    }
    
    func render() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 6
        
        self.contentView.addSubview(containerView)
        containerView.addSubview(wordLabel)
        
        containerView.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        wordLabel.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, left: containerView.safeAreaLayoutGuide.leftAnchor, bottom: containerView.safeAreaLayoutGuide.bottomAnchor, right: containerView.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: Constants.cellHorizontalInterval, paddingBottom: 0, paddingRight: Constants.cellHorizontalInterval)
        }
}

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
