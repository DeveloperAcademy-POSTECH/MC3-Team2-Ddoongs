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
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()

    var relatedWords: [String] = [] {
        didSet {
            var labels: [UILabel] = []
            self.relatedWords.forEach { wordName in
                let label = UILabel()
                label.text = wordName
                label.frame.size.width = label.intrinsicContentSize.width + tagPadding
                label.frame.size.height = tagHeight
                labels.append(label)
            }
            relatedWordArray = labels
            render()
            configureUI()
            displayTagLabels()
        }
    }
    
    var relatedWordArray: [UILabel] = []
    private let tagHeight: CGFloat = 30
    private let tagPadding: CGFloat = 16
    private let tagSpacingX: CGFloat = 8
    private let tagSpacingY: CGFloat = 8
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        self.cardShadow()
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
