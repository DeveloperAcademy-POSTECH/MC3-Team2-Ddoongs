//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by 박진웅 on 2022/07/19.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!

    override func updateViewConstraints() {
        super.updateViewConstraints()

        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Perform custom UI setup here
//        let img = NSTextAttachment()
//        img.image = UIImage(systemName: "globe")
//        let str = NSAttributedString(attachment: img).string

        self.nextKeyboardButton = UIButton(type: .system)

        self.nextKeyboardButton.setTitle(NSLocalizedString("NEXT", comment: "Title for 'Next Keyboard' button"), for: [])
//        self.nextKeyboardButton.setImage(UIImage(systemName: "globe"), for: UIControl.State.normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false

        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)

        self.view.addSubview(self.nextKeyboardButton)

        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        let row1 = ["보라해💜", "💜JungKook💜", "💜JIN💜"]
        let row2 = ["최애", "존멋", "💜제이홉💜", "LOVE"]
        let row3 = ["애교폭탄", "카톡왔숑", "사랑해제이홉오빠"]
        let row4 = ["ㄹㅇㅋㅋ", "뀨", "음방", "뷔 내꺼!"]

        var list1 = createRow(buttonTitles: row1)
        var list2 = createRow(buttonTitles: row2)
        var list3 = createRow(buttonTitles: row3)
        var list4 = createRow(buttonTitles: row4)

        self.view.addSubview(list1)
        self.view.addSubview(list2)
        self.view.addSubview(list3)
        self.view.addSubview(list4)

        list1.translatesAutoresizingMaskIntoConstraints = false
        list2.translatesAutoresizingMaskIntoConstraints = false
        list3.translatesAutoresizingMaskIntoConstraints = false
        list4.translatesAutoresizingMaskIntoConstraints = false

        rowConstraints(view: self.view, rowViews: [list1, list2, list3, list4])
    }

    func createButton(name: String) -> UIButton {
        let button = UIButton()
//        button.anchor(top: topRow.topAnchor, left: topRow.leftAnchor, bottom: topRow.bottomAnchor, right: topRow.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
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

    func createRow(buttonTitles: [String]) -> UIView {
        var buttons: [UIButton] = []
        var row = UIView(frame: CGRect.init(x: 0, y: 0, width: 320, height: 10))
        row.backgroundColor = UIColor.systemGray6
//        row.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        for buttonTitle in buttonTitles {
            let button = createButton(name: buttonTitle)
            buttons.append(button)
            row.addSubview(button)
        }
       buttonConstraints(buttons: buttons, view: row)
        return row
    }

    func buttonConstraints(buttons: [UIButton], view: UIView) {
        for (index, button) in buttons.enumerated() {
            var topConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 12)
            var bottomConstraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -3)
            var rightConstraint: NSLayoutConstraint!
            if index == buttons.count - 1 {
                rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10)
            } else {
                let nextButton = buttons[index+1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: nextButton, attribute: .left, multiplier: 1.0, constant: -10)
            }
            var leftConstraint: NSLayoutConstraint!
            if index == 0 {
                leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 12)
            } else {
                let prevtButton = buttons[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: prevtButton, attribute: .right, multiplier: 1.0, constant: 10)
                    let firstButton = buttons[0]
                    var widthConstraint = NSLayoutConstraint(item: firstButton, attribute: .width, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1.0, constant: 0)
                view.addConstraint(widthConstraint)
            }
            view.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }

    func rowConstraints(view: UIView, rowViews: [UIView]) {
        for (index, rowView) in rowViews.enumerated() {
            var rightSideConstraint = NSLayoutConstraint(item: rowView, attribute: .right, relatedBy: .equal, toItem: inputView, attribute: .right, multiplier: 1.0, constant: -1)
            var leftConstraint = NSLayoutConstraint(item: rowView, attribute: .left, relatedBy: .equal, toItem: inputView, attribute: .left, multiplier: 1.0, constant: 1)
            view.addConstraints([leftConstraint, rightSideConstraint])
            var topConstraint: NSLayoutConstraint
            if index == 0 {
                topConstraint = NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: inputView, attribute: .top, multiplier: 1.0, constant: 0)
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
                bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .bottom, relatedBy: .equal, toItem: inputView, attribute: .bottom, multiplier: 1.0, constant: 0)
            } else {
                let nextRow = rowViews[index+1]
                bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .bottom, relatedBy: .equal, toItem: nextRow, attribute: .top, multiplier: 1.0, constant: 0)
            }
            view.addConstraint(bottomConstraint)
        }

    }

//    func addConstraints(buttons: [UIButton], containingView: UIView) {
//
//        for (index, button) in buttons.enumerated() {
//
//            var topConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: containingView, attribute: .top, multiplier: 1.0, constant: 1)
//
//            var bottomConstraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: containingView, attribute: .bottom, multiplier: 1.0, constant: -1)
//
//                var leftConstraint: NSLayoutConstraint!
//
//                if index == 0 {
//
//                    leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: containingView, attribute: .left, multiplier: 1.0, constant: 1)
//
//                } else {
//
//                    leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: buttons[index-1], attribute: .right, multiplier: 1.0, constant: 1)
//
//                    var widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .width, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1.0, constant: 0)
//
//                    containingView.addConstraint(widthConstraint)
//                }
//
//                var rightConstraint: NSLayoutConstraint!
//
//                if index == buttons.count - 1 {
//
//                    rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: containingView, attribute: .right, multiplier: 1.0, constant: -1)
//
//                } else {
//
//                    rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: buttons[index+1], attribute: .left, multiplier: 1.0, constant: -1)
//                }
//
//                containingView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
//            }
//        }

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

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }

        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    func centerX(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {

        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true

        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }

    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    func setHeight(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func setWidth(width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

}

import SwiftUI

struct RootViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = KeyboardViewController

    func makeUIViewController(context: Context) -> KeyboardViewController {
        return KeyboardViewController()
    }

    func updateUIViewController(_ uiViewController: KeyboardViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        RootViewControllerRepresentable()
    }
}
