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
        configureUI()
        
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(wordDescriptionView)
        wordDescriptionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        wordDescriptionView.centerX(inView: view)
        
        wordDescriptionView.layer.masksToBounds = false
        wordDescriptionView.layer.shadowRadius = 5
        wordDescriptionView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        wordDescriptionView.layer.shadowOpacity = 0.2
        
    }

}