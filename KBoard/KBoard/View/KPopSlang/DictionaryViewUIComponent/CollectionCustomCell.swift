//
//  CollectionCustomCell.swift
//  KBoard
//
//  Created by ParkJunHyuk on 2022/07/27.
//

import UIKit

class CollectionCustomCell: UICollectionViewCell {
    
    static let collectaionCellId = "CollectaionCellId"
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        addSubview(categoryLabel)
        
        categoryLabel.centerX(inView: self)
        categoryLabel.centerY(inView: self)
    }
    
    func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
    }
}
