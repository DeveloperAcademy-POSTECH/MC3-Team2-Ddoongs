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
    private let usageStack: UIStackView = {
        let usageStack = UIStackView()
        usageStack.axis = .vertical
        usageStack.distribution = .fillEqually
        usageStack.alignment = .leading
        usageStack.spacing = 10
        return usageStack
    }()
    private var usageArray: [UsageContextView] = []
    private var tempUsage: UsageContextView?
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        dataSetting()
        render()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func dataSetting() {
        // MARK: 아래 두 데이터는 뷰를 보기위해 가상의 데이터를 만들어주었다. 추후 데이터 세팅과 불러오는데 쓰일 예정
        let usageExample = UsageContextView()
        let usageExample2 = UsageContextView()
        usageArray = [usageExample, usageExample2]
        usageStack.addArrangedSubview(usageLabel)
        for usage in usageArray {
            usageStack.addArrangedSubview(usage)
        }
    }
    
    private func render() {
        self.addSubview(usageStack)
        usageStack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
    }
    
    private func configureUI() {
        self.cardShadow()
    }
    
}
