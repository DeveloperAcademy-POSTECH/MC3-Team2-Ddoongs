//
//  CategoryCollectionHeaderView.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/27.
//

import UIKit

class CategoryTableHeaderView: UITableViewHeaderFooterView {
    var tapHandler: (() -> Void)?
    
    fileprivate let  addMyOwnWordLabel: UILabel = {
        let label = UILabel()
        label.text = "Add My Own Word"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .lightGray
        return label
    }()
    
    fileprivate let  plusButtonImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "plus.circle")!
        imageView.image = image
        imageView.setWidth(width: 30)
        imageView.setHeight(height: 30)
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    @objc fileprivate func addword() {
        tapHandler?()
    }
    
    func render() {
        let headerButton = UIButton()
        headerButton.addTarget(self, action: #selector(addword), for: .touchUpInside)
        headerButton.backgroundColor = .clear
        headerButton.addDashedBorder(x: self.frame.size.width - 2, y: 50)
        
        let hstack = UIStackView(arrangedSubviews: [plusButtonImageView, addMyOwnWordLabel])
        hstack.axis = .horizontal
        hstack.spacing = 10
        
        self.addSubview(hstack)
        self.addSubview(headerButton)
        hstack.centerX(inView: headerButton)
        hstack.centerY(inView: headerButton)
        
        headerButton.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 6, paddingLeft: 1, paddingBottom: 24, paddingRight: 1)
    }
}

// class CategoryCollectionHeaderView: UICollectionReusableView {
//    
//    var tapHandler: (() -> Void)?
//    
//    fileprivate let  addMyOwnWordLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Add My Own Word"
//        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
//        label.textColor = .lightGray
//        return label
//    }()
//    
//    fileprivate let  plusButtonImageView: UIImageView = {
//        let imageView = UIImageView()
//        let image = UIImage(systemName: "plus.circle")!
//        imageView.image = image
//        imageView.setWidth(width: 30)
//        imageView.setHeight(height: 30)
//        imageView.tintColor = .lightGray
//        return imageView
//    }()
//    
//    @objc fileprivate func addword() {
//        tapHandler?()
//    }
//    
//    func render() {
//        let headerButton = UIButton()
//        headerButton.addTarget(self, action: #selector(addword), for: .touchUpInside)
//        headerButton.backgroundColor = .clear
//        headerButton.addDashedBorder(x: self.frame.size.width - 2, y: 50)
//        
//        let hstack = UIStackView(arrangedSubviews: [plusButtonImageView, addMyOwnWordLabel])
//        hstack.axis = .horizontal
//        hstack.spacing = 10
//        
//        self.addSubview(hstack)
//        self.addSubview(headerButton)
//        hstack.centerX(inView: headerButton)
//        hstack.centerY(inView: headerButton)
//        
//        headerButton.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 6, paddingLeft: 1, paddingBottom: 24, paddingRight: 1)
//    }
// }
