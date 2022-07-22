//
//  CustomTableCell.swift
//  KBoard
//
//  Created by Yu ahyeon on 2022/07/21.
//

import UIKit

// MARK: - MoreButton Action
protocol CategoryEditDelegate: AnyObject {
    func tapMoreButton()
}

// MARK: - UITableViewCell
class CustomTableCell: UITableViewCell {
    
    var cellDelegate: CategoryEditDelegate?
    
    var categoryInfo: [String]? {
        didSet {configure()}
    }
    
    lazy var categoryName: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return lable
    }()
    
    lazy var categoryWordsCount: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16)
        return lable
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(tapMoreButton), for: .touchUpInside)
        return button
    }()
    
    // 코드로 cell을 만들면 Init을 해줘야함
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCellConstraint()
        self.moreButton.addTarget(self, action: #selector(tapMoreButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 메소드 부분
    private func setCellConstraint() {
        let hstack = UIStackView(arrangedSubviews: [categoryName, moreButton])
        hstack.axis = .horizontal
        
        let vstack = UIStackView(arrangedSubviews: [hstack, categoryWordsCount])
        vstack.axis = .vertical
        vstack.spacing = 40
        self.contentView.addSubview(vstack)
        vstack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom: 15, paddingRight: 20)
    }
    
    func configure() {
        guard let categoryInfo = categoryInfo else {return}
        categoryName.text = categoryInfo[0]
        categoryWordsCount.text = categoryInfo[1]
    }
    
    @objc func tapMoreButton() {
        cellDelegate?.tapMoreButton()
    }
}
