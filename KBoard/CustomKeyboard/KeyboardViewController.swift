//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by 박진웅 on 2022/07/19.
//
import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!

    private let layout: UICollectionViewFlowLayout = {
        let guideline = UICollectionViewFlowLayout()
        guideline.scrollDirection = .vertical
        guideline.minimumInteritemSpacing = 0
        guideline.minimumLineSpacing = 7
        return guideline
    }()

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.scrollIndicatorInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 4)
        view.contentInset = .zero
        view.backgroundColor = .blue
        view.clipsToBounds = true
//        view.register(MyCell.self, forCellWithReuseIdentifier: MyCell.id)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

    override func updateViewConstraints() {
        super.updateViewConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.nextKeyboardButton = UIButton(type: .system)

        self.nextKeyboardButton.setTitle(NSLocalizedString("NEXT", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false

        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)

        self.view.addSubview(self.nextKeyboardButton)

        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self

        let row1 = ["보라해💜", "💜JungKook💜", "💜JIN💜"]
        let row2 = ["최애", "존멋", "💜제이홉💜", "LOVE"]
        let row3 = ["애교폭탄", "카톡왔숑", "사랑해제이홉오빠"]
        let row4 = ["ㄹㅇㅋㅋ", "뀨", "음방", "뷔 내꺼!"]

        var list1 = createRow(buttonTitles: row1)
        var list2 = createRow(buttonTitles: row2)
        var list3 = createRow(buttonTitles: row3)
        var list4 = createRow(buttonTitles: row4)
        var list: [UIView] = [list1, list2, list3, list4]
        self.view.addSubview(list1)
        self.view.addSubview(list2)
        self.view.addSubview(list3)
        self.view.addSubview(list4)
//        self.view.addSubview(collectionView)

//        self.view.addSubview(list1)
//        self.view.addSubview(list2)
//        self.view.addSubview(list3)
//        self.view.addSubview(list4)

        list1.translatesAutoresizingMaskIntoConstraints = false
        list2.translatesAutoresizingMaskIntoConstraints = false
        list3.translatesAutoresizingMaskIntoConstraints = false
        list4.translatesAutoresizingMaskIntoConstraints = false

        rowConstraints(view: self.view, rowViews: [list1, list2, list3, list4])
    }

    private func textSize(text: String) -> CGFloat {
        return (text as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 17)]).width
    }

    private func createButton(name: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: textSize(text: name) + 40).isActive = true
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.black.cgColor
//        button.layer.masksToBounds = true
        button.setTitle(name, for: UIControl.State.normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        return button
    }

    @objc func tapped(_ sender: AnyObject?) {
        let text = sender?.title(for: UIControl.State.normal)
        var proxy = textDocumentProxy as UIKeyInput
        proxy.insertText(text!)
    }

    private func createRow(buttonTitles: [String]) -> UIView {
        var buttons: [UIButton] = []
        var row = UIView(frame: CGRect.init(x: 0, y: 0, width: 320, height: 0))
        row.backgroundColor = UIColor.systemGray6
        for buttonTitle in buttonTitles {
            let button = createButton(name: buttonTitle)
            buttons.append(button)
            row.addSubview(button)
        }
       buttonConstraints(buttons: buttons, view: row)
        return row
    }

    private func buttonConstraints(buttons: [UIButton], view: UIView) {
        for (index, button) in buttons.enumerated() {
            var topConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 12)
            var bottomConstraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -3)
//            var rightConstraint: NSLayoutConstraint!
//            if index == buttons.count - 1 {
//                rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10)
//            } else {
//                let nextButton = buttons[index+1]
//                rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: nextButton, attribute: .left, multiplier: 1.0, constant: -10)
//            }
            var leftConstraint: NSLayoutConstraint!
            if index == 0 {
                leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 12)
            } else {
                let prevtButton = buttons[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: prevtButton, attribute: .right, multiplier: 1.0, constant: 10)
                let firstButton = buttons[0]
                var widthConstraint = NSLayoutConstraint(item: firstButton, attribute: .width, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1.0, constant: 0)
//                view.addConstraint(widthConstraint)
            }
            view.addConstraints([topConstraint, bottomConstraint, leftConstraint])
        }
    }

    private func rowConstraints(view: UIView, rowViews: [UIView]) {
        for (index, rowView) in rowViews.enumerated() {
            var rightSideConstraint = NSLayoutConstraint(item: rowView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -1)
            var leftConstraint = NSLayoutConstraint(item: rowView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 1)
            view.addConstraints([leftConstraint, rightSideConstraint])
            var topConstraint: NSLayoutConstraint
            if index == 0 {
                topConstraint = NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
            } else {
                let prevRow = rowViews[index-1]
                topConstraint = NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: prevRow, attribute: .bottom, multiplier: 1.0, constant: 0)
                let firstRow = rowViews[0]
                var heightConstraint = NSLayoutConstraint(item: firstRow, attribute: .height, relatedBy: .equal, toItem: rowView, attribute: .height, multiplier: 1.0, constant: 0)
                view.addConstraint(heightConstraint)
            }
            view.addConstraint(topConstraint)
            var bottomConstraint: NSLayoutConstraint
            if index == rowViews.count - 1 {
                bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
            } else {
                let nextRow = rowViews[index+1]
                bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .bottom, relatedBy: .equal, toItem: nextRow, attribute: .top, multiplier: 1.0, constant: 0)
            }
            view.addConstraint(bottomConstraint)
        }
    }

    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }

    override func textWillChange(_ textInput: UITextInput?) {
    }

    override func textDidChange(_ textInput: UITextInput?) {
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

 extension KeyboardViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width
        print("collectionView width=\(collectionView.frame.width)")
        print("cell하나당 width=\(width)")
        print("root view width = \(self.view.frame.width)")

        let size = CGSize(width: width, height: width)
        return size
    }
 }
