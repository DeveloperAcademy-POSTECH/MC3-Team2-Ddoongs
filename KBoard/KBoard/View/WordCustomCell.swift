//
//  WordCustomCell.swift
//  KBoard
//
//  Created by ParkJunHyuk on 2022/07/24.
//

import UIKit

class WordCustomCell : UITableViewCell, UITableViewDelegate{
    
    static let tableCellId = "TableCellId"
    
    lazy var HangleName : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25) // 기본 size 가 16
        return label
    }()
    
    lazy var EnglishName : UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        return label
    }()
    
    lazy var favoriteButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.tintColor = .systemYellow
        return button
    }()
    
    lazy var RectangleView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 130)
        view.backgroundColor = UIColor.white
        
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 5
        return view
    }()

    // 스토리보드로 셀을 작성하게 될 경우 초기화를 해주기 때문에 안해줘도 되지만 코드로 작성하게될 경우 작성해주어야 한다
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemneted")
    }
    
    func render() {
        
        self.addSubview(RectangleView)
        RectangleView.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.safeAreaLayoutGuide.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)

        self.addSubview(HangleName)
        HangleName.anchor(top: RectangleView.topAnchor, left: RectangleView.leftAnchor, paddingTop: 20, paddingLeft: 20)
        
        self.addSubview(EnglishName)
        EnglishName.anchor(top: HangleName.topAnchor, left: RectangleView.leftAnchor, bottom: RectangleView.bottomAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 20)
        
        self.addSubview(favoriteButton)
        favoriteButton.centerY(inView: RectangleView)
        favoriteButton.anchor(right: RectangleView.rightAnchor, paddingRight: 20)
    }
}
