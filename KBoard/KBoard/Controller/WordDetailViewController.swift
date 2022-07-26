//
//  WordDetailViewController.swift
//  KBoard
//
//  Created by 박성수 on 2022/07/20.
//

import UIKit

class WordDetailViewController: UIViewController {
    
    private let wordDescriptionView = WordDescriptionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render() // layout 배치
        configureUI() // background 색상등 추가 설정
        
    }
    
    private func render() {
        view.addSubview(wordDescriptionView)
        wordDescriptionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingRight: 16)
        wordDescriptionView.centerX(inView: view)
        
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
    }

}