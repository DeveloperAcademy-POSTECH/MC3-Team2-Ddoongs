//
//  AddNewCategory.swift
//  KBoard
//
//  Created by Yu ahyeon on 2022/07/21.
//

import UIKit

class AddNewCategory: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    lazy var titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.text = "Category Name"
        titleLable.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return titleLable
    }()
    
    lazy var categoryTextField: UITextField = {
        let categoryTextField = UITextField()
        categoryTextField.placeholder = "enter New Category Name!"
        categoryTextField.delegate = self
        categoryTextField.clearButtonMode = .whileEditing
        return categoryTextField
    }()
    
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
        self.navigationItem.title = "Add Category "
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem =
        UIBarButtonItem.init(title: "Save", style: .done, target: self, action: #selector(addNewCategory(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action: #selector(addNewCategory(_:)))
    }
    
    private func setCategoryNameInput() {
        let vstack = UIStackView(arrangedSubviews: [titleLable, categoryTextField])
        vstack.axis = .vertical
        vstack.spacing = 20
        view.addSubview(vstack)
        vstack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16)
    }
    
    @objc private func addNewCategory(_ sender: Any) {
        print("굿")
    }
    
    // MARK: - UITextFieldDelegate
    
}
