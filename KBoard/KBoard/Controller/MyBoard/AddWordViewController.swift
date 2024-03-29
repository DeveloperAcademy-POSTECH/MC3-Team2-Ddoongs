//
//  AddWordViewController.swift
//  KBoard
//
//  Created by 박성수 on 2022/07/19.
//

import UIKit

class AddWordViewController: UIViewController {
    
    // MARK: - property
    
    var categoryViewModel: CategoryViewModel
    
    init(categoryViewModel: CategoryViewModel) {
        self.categoryViewModel = categoryViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let wordStack: UIStackView = {
        let wordStack = UIStackView()
        return wordStack
    }()
    
    private let newWord: UILabel = {
        let newWord = UILabel()
        newWord.text = "New Word : "
        return newWord
    }()
    private let newWordCategory: UILabel = {
        let newWordCategory = UILabel()
        newWordCategory.text = "Category : "
        return newWordCategory
    }()
    private let newWordDescription: UILabel = {
        let newWordDescription = UILabel()
        newWordDescription.text = "Description : "
        return newWordDescription
    }()
    private let newWordTextField: UITextField = {
        let newWordTextField = UITextField()
        newWordTextField.placeholder = "write your own word!"
        newWordTextField.clearButtonMode = .whileEditing
        return newWordTextField
    }()
    private let newWordCategoryPicker = UIPickerView()
    private let newWordCategoryTextField: UITextField = {
        let newWordCategoryTextField = UITextField()
        newWordCategoryTextField.tintColor = .clear
        return newWordCategoryTextField
    }()
    private let newWordDescriptionTextField: UITextField = {
        let newWordDescriptionTextField = UITextField()
        newWordDescriptionTextField.placeholder = "write some description"
        newWordDescriptionTextField.clearButtonMode = .whileEditing
        return newWordDescriptionTextField
    }()
    // Toolbar REF: https://stackoverflow.com/a/37065109/19350352
    private let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        let toolbarItem = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(doneTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, toolbarItem], animated: true)
        return toolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render() // addSubview 해주는 곳 UI 위치 배치
        configureUI() // backgroundColor 등 UI 색상 설정
        navigationSetting() // navigation bar에 대한 setting
        newWordTextField.delegate = self
        newWordCategoryPicker.delegate = self
        newWordCategoryPicker.dataSource = self
        newWordCategoryTextField.delegate = self
        newWordDescriptionTextField.delegate = self
        guard let index = categoryViewModel.getCategoryIndex() else {
            return
        }
        newWordCategoryPicker.selectRow(index, inComponent: 0, animated: true)
    }
    
    private func render() {
        view.addSubview(newWord)
        newWord.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: 100, paddingLeft: 24)
        
        view.addSubview(newWordCategory)
        newWordCategory.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: 200, paddingLeft: 24)
        
        view.addSubview(newWordTextField)
        newWordTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 100, paddingLeft: 170, paddingRight: 24)
        
        view.addSubview(newWordCategoryTextField)
        newWordCategoryTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: 200, paddingLeft: 170)
        newWordCategoryTextField.inputView = newWordCategoryPicker
        newWordCategoryTextField.inputAccessoryView = toolbar
        
        view.addSubview(newWordDescription)
        newWordDescription.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: 300, paddingLeft: 24)
        
        view.addSubview(newWordDescriptionTextField)
        newWordDescriptionTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 300, paddingLeft: 170, paddingRight: 24)
        
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        newWordCategoryTextField.text = categoryViewModel.getCategoryName()
    }
    
    private func navigationSetting() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(dismissPage))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(addWord))
        navigationItem.title = "Add word"
    }
    
    @objc func addWord() {
        guard let wordName = newWordTextField.text, !wordName.isEmpty,
              let categoryName = newWordCategoryTextField.text
        else {
            dismiss(animated: true)
            return
        }
        categoryViewModel.addWord(categoryName: categoryName, wordName: wordName, wordDescription: newWordDescription.text ?? "")
        dismiss(animated: true)
    }
    
    @objc private func dismissPage() {
            dismiss(animated: true, completion: nil)
    }
    
    @objc private func doneTapped() {
        self.view.endEditing(true)
    }
    
}

extension AddWordViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if newWordTextField.isEditing {
            print("new Word --> \(textField.text ?? "")")
            // 모델의 저장값 안에 newWordTextField.text 를 넣어줄 예정
        } else {
            print("new Word Description --> \(textField.text ?? "")")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if newWordTextField.isEditing || newWordDescriptionTextField.isEditing {
            return true
        }
        return false
    }
    
}

extension AddWordViewController: UIPickerViewDelegate {
    // Picker안의 pickerList파악을 위해 delegate의 필수요건이라서 생성
}

extension AddWordViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categoryViewModel.numOfCategories()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryViewModel.userCategoryNameArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        newWordCategoryTextField.text = categoryViewModel.userCategoryNameArray[row]
    }
    
}
