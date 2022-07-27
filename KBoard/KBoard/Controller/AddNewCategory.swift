//
//  AddNewCategory.swift
//  KBoard
//
//  Created by Yu ahyeon on 2022/07/21.
//

import UIKit

class AddNewCategory: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    lazy var categoryTextField: UITextField = {
        let categoryTextField = UITextField()
        categoryTextField.placeholder = "enter New Category Name!"
        categoryTextField.delegate = self
        categoryTextField.clearButtonMode = .whileEditing
        categoryTextField.borderStyle = .none
        return categoryTextField
    }()
    
    var categoryNameDelegate: CategoryNameProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setCategoryNameInput()
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "Category Name"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem =
        UIBarButtonItem.init(title: "Save", style: .done, target: self, action: #selector(addNewCategory(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action: #selector(dismissModal(_:)))
    }
    
    private func setCategoryNameInput() {
        view.addSubview(categoryTextField)
        categoryTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16)
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

protocol CategoryNameProtocol {
    func categoryNameSend(name: String)
}
