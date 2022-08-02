//
//  WordUsageView.swift
//  KBoard
//
//  Created by 박성수 on 2022/07/22.
//

import UIKit

class WordUsageView: UIView {
    
    // MARK: - property
    private let usageLabel: UILabel = {
        let usageLabel = UILabel()
        usageLabel.text = "Usage"
        usageLabel.font = .systemFont(ofSize: 16, weight: .bold)
        return usageLabel
    }()

    var usageArray: [Usage] = [] {
        willSet {
            render(usages: newValue)
        }
    }

    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render(usages: [Usage]) {
        
        let usageContextViews: [UsageContextView] = usages.map {
            let view = UsageContextView()
            view.usage = $0
           return view
       }

        let usageStack = UIStackView(arrangedSubviews: [usageLabel] + usageContextViews)
        usageStack.axis = .vertical
        usageStack.distribution = .fillEqually
        usageStack.alignment = .leading
        usageStack.spacing = 10
        
        self.addSubview(usageStack)
        
        usageStack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 15, paddingRight: 20)
    }
    
    private func configureUI() {
        self.cardShadow()
    }
    
}
