//
//  WordDetailViewController.swift
//  KBoard
//
//  Created by 박성수 on 2022/07/20.
//

import UIKit

class WordDetailViewController: UIViewController {
    
    private let wordDescriptionView = WordDescriptionView()
    private let wordUsageView = WordUsageView()
    private let wordDetailStack: UIStackView = {
        let wordDetailStack = UIStackView()
        wordDetailStack.distribution = .equalSpacing
        wordDetailStack.spacing = 20
        wordDetailStack.axis = .vertical
        return wordDetailStack
    }()
    private lazy var starButton: UIButton = {
        let starButton = UIButton()
        starButton.setImage(UIImage(systemName: "star"), for: .normal)
        starButton.tintColor = .systemYellow
        starButton.addTarget(self, action: #selector(starTapped), for: .touchUpInside)
        return starButton
    }()
    private let relatedWordsLabel: UILabel = {
        let relatedWordsLabel = UILabel()
        relatedWordsLabel.text = "Related Words"
        relatedWordsLabel.font = .boldSystemFont(ofSize: 16)
        return relatedWordsLabel
    }()
    private lazy var relatedWoordButton: UIButton = {
        let button = UIButton()
        button.setTitle("asdfasd", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapRelatedWord), for: .touchUpInside)
        return button
    }()
    private lazy var relatedWoordButton2: UIButton = {
        let button = UIButton()
        button.setTitle("asdasdfasfasdfasd", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapRelatedWord), for: .touchUpInside)
        return button
    }()
    private lazy var relatedWoordButton3: UIButton = {
        let button = UIButton()
        button.setTitle("asdfasd", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapRelatedWord), for: .touchUpInside)
        return button
    }()
    private let relatedWordView = UIView()
    private lazy var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    private lazy var relatedWordArray: [UIButton] = [relatedWoordButton, relatedWoordButton2, relatedWoordButton3]
    private let tagHeight: CGFloat = 30
    private let tagPadding: CGFloat = 16
    private let tagSpacingX: CGFloat = 8
    private let tagSpacingY: CGFloat = 8
    
    @objc func starTapped() {
        if starButton.currentImage != UIImage(systemName: "star.fill") {
            let addCategoryModalViewController = AddCategoryModalViewController()
            addCategoryModalViewController.modalPresentationStyle = .pageSheet
            addCategoryModalViewController.sheetPresentationController?.detents = [.medium()]
            present(addCategoryModalViewController, animated: true)
        }
        starButton.setImage(UIImage(systemName: (starButton.currentImage == UIImage(systemName: "star")) ?  "star.fill" :  "star"), for: .normal)
    }
    
    @objc func tapRelatedWord() {
        present(WordDetailViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render() // layout 배치
        configureUI() // background 색상등 추가 설정
        
    }
    
    private func render() {
        view.addSubview(wordDetailStack)
        wordDetailStack.addArrangedSubview(wordDescriptionView)
        wordDetailStack.addArrangedSubview(wordUsageView)
        wordDetailStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        view.addSubview(relatedWordView)
        relatedWordView.anchor(top: wordDetailStack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        relatedWordRender()
        displayTagLabels()
        
        view.addSubview(starButton)
        starButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: 60, paddingRight: 60)
        
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        relatedWordView.cardShadow()
    }
    
    private func relatedWordRender() {
        relatedWordView.addSubview(relatedWordsLabel)
        relatedWordsLabel.anchor(top: relatedWordView.topAnchor, left: relatedWordView.leftAnchor, right: relatedWordView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        relatedWordView.addSubview(containerView)
        containerView.anchor(left: relatedWordView.leftAnchor, right: relatedWordView.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        relatedWordArray.forEach { word in
            containerView.addSubview(word)
            if word.intrinsicContentSize.width >= UIScreen.main.bounds.width {
                word.anchor(right: relatedWordView.rightAnchor, paddingRight: 20)
            }
        }
        containerView.anchor(top: relatedWordsLabel.bottomAnchor, paddingTop: 15, width: view.bounds.width, height: view.bounds.height)
        if let last = relatedWordArray.last {
            last.anchor(bottom: relatedWordView.bottomAnchor, paddingBottom: 20)
        }
    }
    
    // REF: https://stackoverflow.com/a/60588546/19350352
    func displayTagLabels() {
        var currentOriginX: CGFloat = 0
        var currentOriginY: CGFloat = 0
        relatedWordArray.forEach { label in
            if currentOriginX + label.intrinsicContentSize.width > UIScreen.main.bounds.width - 32 {
                currentOriginX = 0
                currentOriginY += tagHeight + tagSpacingY
            }
            label.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, paddingTop: currentOriginY, paddingLeft: currentOriginX)
            currentOriginX += label.intrinsicContentSize.width + tagSpacingX
        }
    }
    
}
