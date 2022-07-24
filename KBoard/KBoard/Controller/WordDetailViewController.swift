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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render() // layout 배치
        configureUI() // background 색상등 추가 설정
        
    }
    
    private func render() {
        view.addSubview(wordDescriptionView)
        wordDescriptionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        wordDescriptionView.centerX(inView: view)
        
        view.addSubview(wordUsageView)
        wordUsageView.anchor(top: wordDescriptionView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        view.addSubview(relatedWordsView)
        relatedWordsView.anchor(top: wordUsageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
    }

}
