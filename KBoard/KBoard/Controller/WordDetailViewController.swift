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
    private let relatedWordsView = RelatedWordsView()
    
    private lazy var starButton: UIButton = {
        let starButton = UIButton()
        starButton.setImage(UIImage(systemName: "star"), for: .normal)
        starButton.tintColor = .systemYellow
        starButton.addTarget(self, action: #selector(starTapped), for: .touchUpInside)
        return starButton
    }()
    
    @objc func starTapped() {
        if starButton.currentImage != UIImage(systemName: "star.fill") {
            let addCategoryModalViewController = AddCategoryModalViewController()
            addCategoryModalViewController.modalPresentationStyle = .pageSheet
            addCategoryModalViewController.sheetPresentationController?.detents = [.medium()]
            present(addCategoryModalViewController, animated: true)
        }
        starButton.setImage(UIImage(systemName: (starButton.currentImage == UIImage(systemName: "star")) ?  "star.fill" :  "star"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render() // layout 배치
        configureUI() // background 색상등 추가 설정
        
    }
    
    private func render() {
        view.addSubview(wordDescriptionView)
        wordDescriptionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        view.addSubview(starButton)
        starButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop: 60, paddingRight: 60)
        
        view.addSubview(wordUsageView)
        wordUsageView.anchor(top: wordDescriptionView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        view.addSubview(relatedWordsView)
        relatedWordsView.anchor(top: wordUsageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)

    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }

}
