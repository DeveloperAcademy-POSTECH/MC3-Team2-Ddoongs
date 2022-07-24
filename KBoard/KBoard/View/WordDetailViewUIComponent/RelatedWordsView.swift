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
    
    private let relatedWordButton: UIButton = {
        let relatedWordButton = UIButton()
        relatedWordButton.setTitle("Inki-Gayoasdfasdfsdfasdfasdfasdfasdfasd", for: .normal)
        relatedWordButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        relatedWordButton.tintColor = .white
        relatedWordButton.backgroundColor = .systemBlue
        relatedWordButton.layer.cornerRadius = 10
        relatedWordButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
        return relatedWordButton
    }()

    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        self.addSubview(relatedWordsLabel)
        relatedWordsLabel.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        self.addSubview(relatedWordButton)
        relatedWordButton.anchor(top: relatedWordsLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        
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
