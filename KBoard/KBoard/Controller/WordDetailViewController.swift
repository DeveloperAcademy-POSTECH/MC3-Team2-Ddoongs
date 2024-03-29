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
    
    let wordViewModel: WordViewModel
    
    init(wordViewModel: WordViewModel) {

        self.wordViewModel = wordViewModel
        
        super.init(nibName: nil, bundle: nil)
        
        wordViewModel.word2.bind { [weak self] _ in
            self?.view.reloadInputViews()
        }
        wordViewModel.changesInUserCategories.bind { [weak self] _ in
            self?.view.reloadInputViews()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var starButton: UIButton = {
        let starButton = UIButton()
        starButton.setImage(wordViewModel.userCategory != "" ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        starButton.tintColor = .systemYellow
        starButton.addTarget(self, action: #selector(starTapped), for: .touchUpInside)
        return starButton
    }()
    
    @objc func starTapped() {
        
        if starButton.currentImage == UIImage(systemName: "star.fill") {
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
            wordViewModel.switchUserCategory(category: "")
        } else {
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            let addCategoryModalViewController = AddCategoryModalViewController(wordViewModel: wordViewModel)
            addCategoryModalViewController.modalPresentationStyle = .pageSheet
            addCategoryModalViewController.sheetPresentationController?.detents = [.medium()]
            present(addCategoryModalViewController, animated: true)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render() // layout 배치
        configureUI() // background 색상등 추가 설정
    }
    
    private func render() {
        wordDescriptionView.wordKorean.text = wordViewModel.wordName
        wordDescriptionView.wordEnglish.text = wordViewModel.pronunciation
        wordDescriptionView.wordDescription.text = wordViewModel.description
        
        view.addSubview(wordDescriptionView)
        wordDescriptionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)

        view.addSubview(starButton)
        starButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop: 60, paddingRight: 60)
        if let usages = wordViewModel.usages {
            wordUsageView.usageArray = usages
        } else {
            wordUsageView.usageArray = []
        }

        view.addSubview(wordUsageView)
        wordUsageView.anchor(top: wordDescriptionView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        relatedWordsView.relatedWords = wordViewModel.relatedWords ?? []
        view.addSubview(relatedWordsView)
        relatedWordsView.anchor(top: wordUsageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)

    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }

}
