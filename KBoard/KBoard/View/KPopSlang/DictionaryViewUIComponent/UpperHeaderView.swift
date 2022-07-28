//
//  UpperHeaderView.swift
//  KBoard
//
//  Created by ParkJunHyuk on 2022/07/27.
//

import UIKit

class UpperHeaderView: UIView {
    
    lazy var largeTitle: UILabel = {
        let label = UILabel()
        label.text = "K-POP Slang"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        return label
    }()
    
    override init(frame: CGRect) {
             super.init(frame: frame)
             render()
             configureUI()
    }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    private func render() {
        
        self.addSubview(largeTitle)
        largeTitle.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: Constants.cellHorizontalInterval, paddingBottom: 0, paddingRight: Constants.cellHorizontalInterval, height: 50)
    }
    
    private func configureUI() {
         self.backgroundColor = .systemBackground
    }
}
