//
//  AddNewCategory.swift
//  KBoard
//
//  Created by Yu ahyeon on 2022/07/21.
//

import UIKit

class AddNewCategory: UIViewController {
    
    // MARK: - Properties
    lazy var categoryTextField: UITextField = {
        let categoryTextField = UITextField()
        categoryTextField.placeholder = "Enter up to 10 characters"
        categoryTextField.delegate = self
        categoryTextField.clearButtonMode = .whileEditing
        categoryTextField.borderStyle = .none
        return categoryTextField
    }()
    
    lazy var validationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    var categoryNameDelegate: CategoryNameProtocol?
    
    // 더미데이터 입니다. 데이터가 들어오면 삭제해주세요
    let word1 = KWord(name: "비티짱1", isFavorite: true, isOriginal: true, description: "바티바티", relatedWords: ["바티짱2", "바티짱3"])
    let word2 = KWord(name: "비티짱2", isFavorite: false, isOriginal: true, description: "짱", relatedWords: ["바티짱1", "바티짱3"])
    let word3 = KWord(name: "비티짱3", isFavorite: true, isOriginal: true, description: "ㅋㅋㅋㅋ", usages: [Usage(korean: "지난 주 뮤직쇼 봤어?", english: "music show you see?"), Usage(korean: "지난 치티치티치티?", english: "티clclslsl?")], relatedWords: ["바티장1", "바티짱2"])
    let word4 = KWord(name: "아오나1", isFavorite: true, isOriginal: false)
    let word5 = KWord(name: "zz", isFavorite: false, isOriginal: true, description: "zzzz")
    let word6 = KWord(name: "gg1", isFavorite: false, isOriginal: false, description: "zz")
    lazy var categories: [Category] = [Category(categoryName: "💜BTS💜", count: "8 Words", kwords: [word1, word2, word3]),
                                       Category(categoryName: "아이돌", count: "8 Words", kwords: [word4, word5]),
                                       Category(categoryName: "소녀시대", count: "8 Words", kwords: [word6])]
    
    // MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        underLine()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        render()
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkTextValidation(_:)), name: UITextField.textDidChangeNotification, object: categoryTextField)
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "Category Name"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem =
        UIBarButtonItem.init(title: "Save", style: .done, target: self, action: #selector(addNewCategory(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action: #selector(dismissModal(_:)))
    }
    
    private func render() {
        view.addSubview(categoryTextField)
        categoryTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(validationLabel)
        validationLabel.anchor(top: categoryTextField.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16)
    }
    
    func underLine() {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: categoryTextField.frame.size.height+10, width: categoryTextField.frame.width, height: 1)
        border.borderWidth = 1
        border.backgroundColor = UIColor.gray.cgColor
        categoryTextField.layer.addSublayer(border)
    }
    
    @objc private func checkTextValidation(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                
                let nameSet = Set(categories.map {$0.categoryName})
                
                if nameSet.contains(text) == true {
                    validationLabel.text = "Category name already exists 🥲"
                    validationLabel.textColor = .red
                    navigationItem.rightBarButtonItem?.isEnabled = false
                    
                } else if text.isEmpty {
                    validationLabel.text = ""
                    
                } else {
                    validationLabel.text = "Good name 😎"
                    validationLabel.textColor = .blue
                }
            }
            
        }
    }
    
    @objc private func addNewCategory(_ sender: Any) {
        if let text = categoryTextField.text {
            categoryNameDelegate?.categoryNameSend(name: text)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func dismissModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddNewCategory: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        if let text = categoryTextField.text {
            if text.count < 10 {
                return true
            }
        }
        return false
    }
}

protocol CategoryNameProtocol {
    func categoryNameSend(name: String)
}
