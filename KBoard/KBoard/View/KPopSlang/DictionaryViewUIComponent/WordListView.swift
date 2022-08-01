//
//  WordListView.swift
//  KBoard
//
//  Created by ParkJunHyuk on 2022/07/24.
//

import UIKit

class WordListView: UIView {
    
    private lazy var wordTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none // cell line 없애기
        tableView.register(WordCustomCell.self, forCellReuseIdentifier: WordCustomCell.tableCellId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        self.addSubview(wordTableView)

        wordTableView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    
    }
    
}

// MARK: UITableView Setting
extension WordListView: UITableViewDelegate, UITableViewDataSource {
    
    // 행의 개수를 설정하는 메소드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Word.words.count
    }

    // 셀을 만드는 메소드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCustomCell.tableCellId, for: indexPath) as! WordCustomCell
        cell.selectionStyle = .none // cell 선택시 배경 색 없애기
        
        cell.HangleName.text = Word.words[indexPath.row].hangleName
        cell.EnglishName.text = Word.words[indexPath.row].englishName

        return cell
    }
}
