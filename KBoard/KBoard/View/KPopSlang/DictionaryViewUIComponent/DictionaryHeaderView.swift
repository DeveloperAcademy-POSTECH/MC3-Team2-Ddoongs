//
//  DictionaryHeaderView.swift
//  KBoard
//
//  Created by ParkJunHyuk on 2022/07/27.
//

import UIKit

class DictionaryHeaderView: UIView {
    let wordCategoryListView = WordCategoryListView(kPopSlangViewModel: KPopSlangViewModel())
    
    let upperHeaderView  = UpperHeaderView()
    
    let searchBar = UISearchBar()
    
    override init(frame: CGRect) {
             super.init(frame: frame)
             render()
             configureUI()
    }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    private func render() {
        
        self.addSubview(upperHeaderView)
        upperHeaderView.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0)
        
        self.addSubview(searchBar)
        searchBar.anchor(top: upperHeaderView.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0)
        
        searchBar.isTranslucent = false
        searchBar.placeholder = "Search the phrase"
        
        self.addSubview(wordCategoryListView)
        wordCategoryListView.anchor(top: searchBar.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 20, paddingRight: 0)
        
    }
    
    private func configureUI() {
         self.backgroundColor = .systemBackground
    }
    
}
