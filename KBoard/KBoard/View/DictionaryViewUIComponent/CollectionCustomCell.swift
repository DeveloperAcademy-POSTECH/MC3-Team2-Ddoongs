//
//  CollectionCustomCell.swift
//  KBoard
//
//  Created by ParkJunHyuk on 2022/07/27.
//

import UIKit

class CollectionCustomCell : UICollectionViewCell {
    
    static let collectaionCellId = "CollectaionCellId"
    
    lazy var categoryLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        
        addSubview(categoryLabel)
        categoryLabel.centerX(inView: self)
        categoryLabel.centerY(inView: self)
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError ("init(coder:) has not been implemented")
    }
}

