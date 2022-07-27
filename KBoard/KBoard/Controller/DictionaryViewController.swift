//
//  DictionaryViewController.swift
//  KBoard
//
//  Created by ParkJunHyuk on 2022/07/24.
//

import UIKit

class DictionaryViewController: UIViewController {
    
    private let wordListView = WordListView()
    private let wordCategoryListView = WordCategoryListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configureUI()
        
    }
    
    private func render() {
        view.addSubview(wordListView)
        view.addSubview(wordCategoryListView)
        
        wordListView.anchor(top: wordCategoryListView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        wordCategoryListView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: wordListView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, height: 40)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
    }
}
