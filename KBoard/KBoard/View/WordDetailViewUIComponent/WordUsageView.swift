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
    private var usageArray: [UsageContext] = []
    private var tempUsage: UsageContext?
    
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
        let usageExample = UsageContext()
        let usageExample2 = UsageContext()
        self.usageArray = [usageExample, usageExample2]
    }
    
    private func render() {
        self.addSubview(usageLabel)
        if usageArray.isEmpty { // Usage 개수가 0 인 case
            usageLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        } else {
            usageLabel.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 20, paddingLeft: 20)
            for usage in usageArray {
                self.addSubview(usage)
                if usage == usageArray.first && usage != usageArray.last { // Usage 개수가 1개가 아닌 경우 Start Point
                    usage.anchor(top: usageLabel.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingRight: 20)
                    tempUsage = usage
                } else if usage == usageArray.first && usage == usageArray.last { // Usage 개수가 1개인 경우 Start Point
                    usage.anchor(top: usageLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
                } else if usage == usageArray.last { // Usage 배열의 마지막 case
                    guard let tempUsage = tempUsage else { return }
                    usage.anchor(top: tempUsage.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
                } else { // Usage 배열의 첫번째와 마지막이 아닌 case
                    guard let tempUsage = tempUsage else { return }
                    usage.anchor(top: tempUsage.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 20)
                    self.tempUsage = usage
                }
            }
        }
    }
    
    private func configureUI() {
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.2
    }
    
}
