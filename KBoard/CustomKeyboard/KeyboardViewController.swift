//
//  KeyboardViewController.swift
//  rrrr
//
//  Created by 박진웅 on 2022/07/28.
//

import UIKit

protocol textInput {
    func tapped(text: String)
}

extension KeyboardViewController: textInput {
    func tapped(text: String) {
        var proxy = textDocumentProxy as UIKeyInput
        proxy.insertText(text)
    }
}

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!

    override func updateViewConstraints() {
        super.updateViewConstraints()

        // Add custom view sizing constraints here
    }

    private let layout: UICollectionViewFlowLayout = {
        let guideline = UICollectionViewFlowLayout()
        guideline.scrollDirection = .vertical
        guideline.minimumLineSpacing = 50
        guideline.minimumInteritemSpacing = 0
        return guideline
    }()

    private let categoryLayout: UICollectionViewFlowLayout = {
        let guideline = UICollectionViewFlowLayout()
        guideline.scrollDirection = .horizontal
        guideline.minimumLineSpacing = 50
        guideline.minimumInteritemSpacing = 0
        return guideline
    }()

    private lazy var customCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.scrollIndicatorInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 4)
        view.contentInset = .zero
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var categoryCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.categoryLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.scrollIndicatorInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 4)
        view.contentInset = .zero
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var category = ["💜BTS💜", "V-App", "💜JungKook💜"]
    lazy var finalRow = ["보라해💜", "💜JungKook💜", "💜JIN💜", "최애", "존멋", "💜제이홉💜", "LOVE", "애교폭탄", "카톡왔숑", "사랑해제이홉오빠", "ㄹㅇㅋㅋ", "뀨", "음방", "뷔 내꺼!", "ㄹㅇㅋㅋ", "뀨", "음방", "뷔 내꺼!"]
    func createFinalArray(input: [String]) -> [[String]] {
        var row: [[String]] = []
        var index = 0
        while finalRow.isEmpty == false {
            var subRow1: [String] = []
            var length: Int = 0
            while length <= Int(view.frame.width-14) {
                if index > finalRow.count - 1 {
                    break
                }
                length += Int(textSize(text: input[index]) + 30 + 10)
                if length <= Int(view.frame.width) {
                    subRow1.append(input[index])
                    index += 1
                } else {break}
            }
            row.append(subRow1)
            if index > finalRow.count - 1 {
                break
            }
        }
        return row
    }
    private lazy var memberName = createFinalArray(input: finalRow)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)

        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false

        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)

        self.view.addSubview(self.nextKeyboardButton)

        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        customCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(customCollectionView)
        var row = UIView(frame: CGRect.init(x: 0, y: 0, width: 320, height: 30))
        var categoryRow = UIView(frame: CGRect.init(x: 0, y: 0, width: 320, height: 30))
        self.view.addSubview(row)
        self.view.addSubview(categoryRow)
        row.backgroundColor = UIColor.blue

        customCollectionView.anchor(top: categoryRow.bottomAnchor, left: view.leftAnchor, bottom: row.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0)
        customCollectionView.anchor(height: 200)
        customCollectionView.register(CollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellIdentifier")
        customCollectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionViewDelegate()

        row.translatesAutoresizingMaskIntoConstraints = false
        categoryRow.translatesAutoresizingMaskIntoConstraints = false
        row.backgroundColor = .systemGray5
        categoryRow.backgroundColor = .systemGray5
        categoryRow.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 0, paddingLeft: 0)
        categoryRow.anchor(bottom: customCollectionView.topAnchor, right: view.rightAnchor, paddingBottom: 0, paddingRight: 0)
        categoryRow.anchor(height: 50)
        row.anchor(top: customCollectionView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        row.anchor(height: 50)
        let firstCategoryButton = createFirstCategoryButton(name: category[0])
        let secondCategoryButton = createCategoryButton(name: category[1])
        let thirdCategoryButton = createCategoryButton(name: category[2])

        let backButton = createBackButton(name: "<=")
        let spaceButton = createSpaceButton(name: "Space")
        let enterButton = createEnterButton(name: "Enter")

        categoryRow.addSubview(firstCategoryButton)
        categoryRow.addSubview(secondCategoryButton)
        categoryRow.addSubview(thirdCategoryButton)
        categoryRow.addSubview(backButton)
        firstCategoryButton.anchor(left: view.leftAnchor, paddingLeft: 0)
        secondCategoryButton.anchor(left: firstCategoryButton.rightAnchor, paddingLeft: 0)
        thirdCategoryButton.anchor(left: secondCategoryButton.rightAnchor, paddingLeft: 0)
        backButton.anchor(left: thirdCategoryButton.rightAnchor, paddingLeft: 2)
        backButton.centerY(inView: categoryRow)

        row.addSubview(spaceButton)
        spaceButton.centerY(inView: row)
        spaceButton.centerX(inView: row)
        row.addSubview(enterButton)
        enterButton.centerY(inView: row, leftAnchor: spaceButton.rightAnchor, paddingLeft: 10)
    }

    func collectionViewDelegate() {
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
    }

    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }

    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.

        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
}

extension KeyboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let size = CGSize(width: width, height: 50)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memberName.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as? CollectionViewCell else {return CollectionViewCell()}
        cell.delegate = self
        cell.title = memberName[indexPath.row]
        return cell
    }

    func createBackButton(name: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        button.widthAnchor.constraint(equalToConstant: textSize(text: name) + 22).isActive = true
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.black.cgColor
//        button.setTitle(name, for: UIControl.State.normal)
        button.setImage(UIImage(systemName: "delete.backward"), for: UIControl.State.normal)
        button.backgroundColor = UIColor.systemGray2
        button.tintColor = UIColor.black
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(backSpacePressed), for: .touchUpInside)
        return button
    }

    func createSpaceButton(name: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: textSize(text: name) + 130).isActive = true
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle(name, for: UIControl.State.normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(spacePressed), for: .touchUpInside)
        return button
    }

    func createEnterButton(name: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: textSize(text: name) + 30).isActive = true
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle(name, for: UIControl.State.normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(returnPressed), for: .touchUpInside)
        return button
    }

    func textSize(text: String) -> CGFloat {
        return (text as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 17)]).width
    }

    func createFirstCategoryButton(name: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: textSize(text: name) + 30).isActive = true
//        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 300)
        button.layer.cornerRadius = 0
        button.layer.borderColor = UIColor.black.cgColor
//        button.layer.masksToBounds = true
        button.setTitle(name, for: UIControl.State.normal)
        button.backgroundColor = UIColor.systemGray2
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
//        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }

    func createCategoryButton(name: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: textSize(text: name) + 30).isActive = true
//        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 300)
        button.layer.cornerRadius = 0
        button.layer.borderColor = UIColor.black.cgColor
//        button.layer.masksToBounds = true
        button.setTitle(name, for: UIControl.State.normal)
        button.backgroundColor = UIColor.systemGray5
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
//        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }

    @objc func backSpacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }

    @objc func spacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText(" ")
    }

    @objc func returnPressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
}
