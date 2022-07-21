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
        view.backgroundColor = .white
        view.addSubview(wordDescriptionView)
        wordDescriptionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20, width: UIScreen.main.bounds.width - 48)
        wordDescriptionView.centerX(inView: view)
        
        wordDescriptionView.layer.masksToBounds = false
        wordDescriptionView.layer.shadowRadius = 5
        wordDescriptionView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        wordDescriptionView.layer.shadowOpacity = 0.2
    }
        
}
