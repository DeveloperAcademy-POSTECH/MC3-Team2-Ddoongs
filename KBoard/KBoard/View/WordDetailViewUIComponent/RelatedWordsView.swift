//
//  RelatedWordsView.swift
//  KBoard
//
//  Created by 박성수 on 2022/07/23.
//

import UIKit

class RelatedWordsView: UIView {
    
    // MARK: - property
    private let relatedWordsLabel: UILabel = {
        let relatedWordsLabel = UILabel()
        relatedWordsLabel.text = "Related Words"
        relatedWordsLabel.font = .boldSystemFont(ofSize: 16)
        return relatedWordsLabel
    }()
    private lazy var relatedLabel: UILabel = {
        let relatedLabel = UILabel()
        relatedLabel.text = "Umak Bang song"
        relatedLabel.frame.size.width = relatedLabel.intrinsicContentSize.width + tagPadding
        relatedLabel.frame.size.height = tagHeight
        return relatedLabel
    }()
    private lazy var relatedLabel2: UILabel = {
        let relatedLabel2 = UILabel()
        relatedLabel2.text = "sa geon nok hwa"
        relatedLabel2.frame.size.width = relatedLabel2.intrinsicContentSize.width + tagPadding
        relatedLabel2.frame.size.height = tagHeight
        return relatedLabel2
    }()
    private lazy var relatedLabel3: UILabel = {
        let relatedLabel3 = UILabel()
        relatedLabel3.text = "ASAP"
        relatedLabel3.frame.size.width = relatedLabel3.intrinsicContentSize.width + tagPadding
        relatedLabel3.frame.size.height = tagHeight
        return relatedLabel3
    }()
    private lazy var relatedLabel4: UILabel = {
        let relatedLabel4 = UILabel()
        relatedLabel4.text = "Chut bangsong"
        relatedLabel4.frame.size.width = relatedLabel4.intrinsicContentSize.width + tagPadding
        relatedLabel4.frame.size.height = tagHeight
        return relatedLabel4
    }()
    private lazy var relatedLabel5: UILabel = {
        let relatedLabel5 = UILabel()
        relatedLabel5.text = "sadfassdfasfsasfdasdasfasdfdfa"
        relatedLabel5.frame.size.width = relatedLabel5.intrinsicContentSize.width + tagPadding
        relatedLabel5.frame.size.height = tagHeight
        return relatedLabel5
    }()
    private lazy var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    private lazy var relatedWordArray: [UILabel] = [relatedLabel, relatedLabel2, relatedLabel3, relatedLabel4, relatedLabel5]
    private let tagHeight: CGFloat = 30
    private let tagPadding: CGFloat = 16
    private let tagSpacingX: CGFloat = 8
    private let tagSpacingY: CGFloat = 8
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configureUI()
        displayTagLabels()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        self.addSubview(relatedWordsLabel)
        relatedWordsLabel.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        self.addSubview(containerView)
        containerView.anchor(left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        relatedWordArray.forEach { word in
            containerView.addSubview(word)
        }
        containerView.anchor(top: relatedWordsLabel.bottomAnchor, paddingTop: 15, width: self.bounds.width, height: self.bounds.height)
        if let last = relatedWordArray.last {
            last.anchor(bottom: self.bottomAnchor, paddingBottom: 20)
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
    
    // REF: https://stackoverflow.com/a/60588546/19350352
    func displayTagLabels() {
        var currentOriginX: CGFloat = 0
        var currentOriginY: CGFloat = 0
        relatedWordArray.forEach { label in
            if currentOriginX + label.bounds.width > UIScreen.main.bounds.width - 32 {
                currentOriginX = 0
                currentOriginY += tagHeight + tagSpacingY
            }
            label.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, paddingTop: currentOriginY, paddingLeft: currentOriginX)
            currentOriginX += label.bounds.width + tagSpacingX
        }
    }
    
}
