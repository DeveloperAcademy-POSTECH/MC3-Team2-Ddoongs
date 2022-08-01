//
//  WordDescriptionView.swift
//  KBoard
//
//  Created by 박성수 on 2022/07/20.
//

import UIKit

class WordDescriptionView: UIView {

    // MARK: - property
    let wordKorean: UILabel = {
        let wordKorean = UILabel()
//        wordKorean.text = "뮤직쇼"
        wordKorean.font = UIFont.boldSystemFont(ofSize: 28)
        return wordKorean
    }()
    
    let wordEnglish: UILabel = {
        let wordEnglish = UILabel()
//        wordEnglish.text = "Music Show"
        wordEnglish.font = wordEnglish.font.withSize(18)
        return wordEnglish
    }()
    
    let wordDescription: UILabel = {
        let wordDescription = UILabel()
//        wordDescription.text = "Music Show means f let artworkf = album.asdfasdfs asfasdfpoiupopwlekjsadfdMusic Show means f let artworkf = album.asdfasdfs asfasdfp"
        wordDescription.numberOfLines = 0
        return wordDescription
    }()
    
    private let seperator: UIView = {
        let seperator = UIView()
        seperator.frame = CGRect(origin: .zero, size: .init())
        seperator.backgroundColor = .black
        return seperator
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
        self.addSubview(wordKorean)
        wordKorean.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 30, paddingLeft: 20)
 
        self.addSubview(wordEnglish)
        wordEnglish.anchor(top: wordKorean.bottomAnchor, left: self.leftAnchor, paddingTop: 3, paddingLeft: 20)
        
        self.addSubview(seperator)
        seperator.anchor(top: wordEnglish.bottomAnchor, left: self.leftAnchor, paddingTop: 20, paddingLeft: 20, height: 1)
        seperator.centerX(inView: self)
        
        self.addSubview(wordDescription)
        wordDescription.anchor(top: seperator.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        
    }
    
    private func configureUI() {
        self.cardShadow()
    }

}
