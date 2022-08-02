//
//  File.swift
//  CustomKeyboard
//
//  Created by 박진웅 on 2022/08/01.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var delegate: textInput?

    var memberNameLabel: UIButton!
    lazy var title: [String] = ["2보5ㅎ", "ㅎ"] {
        didSet(oldVal) {
            setUpCell()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
    }

    func setUpCell() {
        var individualRow: UIView = createRow(buttonTitles: title)
        contentView.addSubview(individualRow)
        individualRow.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
    }

    func createButton(name: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: textSize(text: name) + 30).isActive = true
        button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 300)
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.black.cgColor
//        button.layer.masksToBounds = true
        button.setTitle(name, for: UIControl.State.normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }

    func createRow(buttonTitles: [String]) -> UIView {
        var buttons: [UIButton] = []
        var row = UIView(frame: CGRect.init(x: 0, y: 0, width: 320, height: 40))
        row.backgroundColor = UIColor.systemGray5
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
            var leftConstraint: NSLayoutConstraint!
            if index == 0 {
                leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 12)
            } else {
                let prevButton = buttons[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: prevButton, attribute: .right, multiplier: 1.0, constant: 10)
            }
            view.addConstraints([leftConstraint])
        }
    }

    func textSize(text: String) -> CGFloat {
        return (text as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 17)]).width
    }

    @objc func handleButton(_ sender: UIButton) {
        let title = sender.title(for: UIControl.State.normal)
        self.delegate?.tapped(text: title!)
//        self.present(nextVC, animated: true, completion: nil)
    }
}
