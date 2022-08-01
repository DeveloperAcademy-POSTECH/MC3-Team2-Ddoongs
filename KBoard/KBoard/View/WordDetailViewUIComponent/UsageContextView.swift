//
//  UsageContext.swift
//  KBoard
//
//  Created by 박성수 on 2022/07/23.
//

import UIKit

// MARK: UsageContext는 Korean, English Usage가 들어온다 가정하고 만든 class
class UsageContextView: UIView {
    
    let usage: Usage
    init(usage: Usage) {
        self.usage = usage
        super.init()
    }
    // MARK: - property
    private let usageKorean: UILabel = {
       let usageKorean = UILabel()
//        usageKorean.text = "저번 주 뮤직쇼 봤어?"
        usageKorean.font = usageKorean.font.withSize(16)
        usageKorean.numberOfLines = 0
        return usageKorean
    }()
    
    private let usageEnglish: UILabel = {
       let usageEnglish = UILabel()
//        usageEnglish.text = "Did you see Music show last week?"
        usageEnglish.font = usageEnglish.font.withSize(16)
        usageEnglish.numberOfLines = 0
        return usageEnglish
    }()
    
    // MARK: - init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        self.addSubview(usageKorean)
        usageKorean.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0)
        
        self.addSubview(usageEnglish)
        usageEnglish.anchor(top: usageKorean.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 3, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
}
