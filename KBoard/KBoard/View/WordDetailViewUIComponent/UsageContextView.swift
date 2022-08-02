//
//  UsageContext.swift
//  KBoard
//
//  Created by 박성수 on 2022/07/23.
//

import UIKit

// MARK: UsageContext는 Korean, English Usage가 들어온다 가정하고 만든 class
class UsageContextView: UIView {
    
    var usage: Usage? {
        willSet {
            guard let usage = newValue else { return }
            render(usage: usage)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    // MARK: - property
    private let usageKorean: UILabel = {
       let usageKorean = UILabel()
        usageKorean.font = usageKorean.font.withSize(16)
        usageKorean.numberOfLines = 0
        return usageKorean
    }()
    
    private let usageEnglish: UILabel = {
       let usageEnglish = UILabel()
        usageEnglish.font = usageEnglish.font.withSize(16)
        usageEnglish.numberOfLines = 0
        return usageEnglish
    }()
    
    // MARK: - init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render(usage: Usage) {
        usageKorean.text = usage.korean
        usageEnglish.text = usage.english
        let vstack = UIStackView(arrangedSubviews: [usageKorean, usageEnglish])
        vstack.axis = .vertical
        vstack.spacing = 5
        self.addSubview(vstack)
        vstack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
}
