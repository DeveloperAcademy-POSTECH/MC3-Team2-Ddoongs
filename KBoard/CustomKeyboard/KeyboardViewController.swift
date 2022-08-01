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

    private lazy var customCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.scrollIndicatorInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 4)
        view.contentInset = .zero
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
//            view.register(MyCell.self, forCellWithReuseIdentifier: MyCell.id)
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.heightAnchor.constraint(equalToConstant: 250)
        return view
    }()

    lazy var row1 = ["보라해💜", "💜JungKook💜", "💜JIN💜"]
    lazy var row2 = ["최애", "존멋", "💜제이홉💜", "LOVE"]
    lazy var row3 = ["애교폭탄", "카톡왔숑", "사랑해제이홉오빠"]
    lazy var row4 = ["ㄹㅇㅋㅋ", "뀨", "음방", "뷔 내꺼!"]
    lazy var row5 = ["ㄹㅇㅋㅋ", "뀨", "음방", "뷔 내꺼!"]

    private lazy var memberName = [row1, row2, row3, row4, row5]

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
        var row =  UIView(frame: CGRect.init(x: 0, y: 0, width: 320, height: 30))
//        self.view.addSubview(row)
        customCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        customCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        customCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        customCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        customCollectionView.register(CollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellIdentifier")
        customCollectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionViewDelegate()
        row.backgroundColor = UIColor.blue
        row.translatesAutoresizingMaskIntoConstraints = false
//        row.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 1).isActive = true
//        row.topAnchor.constraint(equalTo: view.topAnchor, constant: 1).isActive = true
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

}
