//
//  DictionaryViewController.swift
//  KBoard
//
//  Created by ParkJunHyuk on 2022/07/24.
//

import UIKit

class DictionaryViewController : UIViewController {
    
    private let wordListView = WordListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configureUI()
        
    }
    
    private func render() {
        view.addSubview(wordListView)
        wordListView.frame = view.bounds
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
    }
}
