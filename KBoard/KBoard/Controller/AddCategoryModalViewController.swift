//
//  AddCategoryModalViewController.swift
//  KBoard
//
//  Created by 박성수 on 2022/07/26.
//

import UIKit

class AddCategoryModalViewController: UIViewController {
    
    // MARK: - property
    private let categoryPickLabel: UILabel = {
        let categoryPickLabel = UILabel()
        categoryPickLabel.text = "Chose Category : "
        return categoryPickLabel
    }()
    
    private let categoryPickerTextField: UITextField = {
        let categoryPickerTextField = UITextField()
        categoryPickerTextField.text = "진💕진💕"
        categoryPickerTextField.tintColor = .clear
        return categoryPickerTextField
    }()
    
    private lazy var categoryPickerStackView: UIStackView = {
        let categoryPickerStackView = UIStackView()
        categoryPickerStackView.axis = .horizontal
        categoryPickerStackView.spacing = 50
        categoryPickerStackView.addArrangedSubview(categoryPickLabel)
        categoryPickerStackView.addArrangedSubview(categoryPickerTextField)
        return categoryPickerStackView
    }()
    
    private lazy var closeModalButton: UIButton = {
        let closeModalButton = UIButton()
        closeModalButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeModalButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return closeModalButton
    }()
    
    private lazy var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return saveButton
    }()
    
    private let caterogyPicker =  UIPickerView()
    private var categorylist = ["진💕진💕", "💕진💕", "💕"]
    
    private let pickerToolbar: UIToolbar = {
        let pickerToolbar = UIToolbar()
        pickerToolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        let cancelItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(endCategoryPickEditing))
        let toolbarItem = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(endCategoryPickEditing))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        pickerToolbar.setItems([cancelItem, flexibleSpace, toolbarItem], animated: true)
        return pickerToolbar
    }()
    
    // MARK: - button function
    @objc func endCategoryPickEditing() {
        self.view.endEditing(true)
    }
    
    @objc func saveTapped() {
        self.dismiss(animated: true)
    }

    // MARK: - viewLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configureUI()
        categoryPickerSetting()
        categoryTextFieldSetting()
        
    }
    
    private func render() {
        view.addSubview(closeModalButton)
        closeModalButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: 30, paddingRight: 24)
        
        view.addSubview(categoryPickerStackView)
        categoryPickerStackView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 150, paddingLeft: 24, paddingRight: 24)
        
        view.addSubview(saveButton)
        saveButton.anchor(top: categoryPickerStackView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 80, paddingLeft: 24, paddingRight: 24)
        saveButton.centerX(inView: view)
        
        categoryPickerTextField.inputView = caterogyPicker
        categoryPickerTextField.inputAccessoryView = pickerToolbar
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func categoryPickerSetting() {
        caterogyPicker.delegate = self
        caterogyPicker.dataSource = self
    }
    
    private func categoryTextFieldSetting() {
        categoryPickerTextField.delegate = self
    }

}

extension AddCategoryModalViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension AddCategoryModalViewController: UIPickerViewDelegate {
    // UIPicker를 위한 구현사항
}

extension AddCategoryModalViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorylist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorylist[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(categorylist[row])
        categoryPickerTextField.text = categorylist[row]
    }

}
