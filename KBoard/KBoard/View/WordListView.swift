//
//  WordListView.swift
//  KBoard
//
//  Created by ParkJunHyuk on 2022/07/24.
//

import UIKit
struct Word {
    let hangleName : String
    let englishName : String
    let favorites : Bool
    let category : String
}

let words: [Word] = [Word(hangleName: "존잼", englishName: "very fun", favorites: false, category: "All"),
                     Word(hangleName: "오빠", englishName: "brother", favorites: false, category: "Happy"),
                     Word(hangleName: "킹받네", englishName: "very angry", favorites: false, category: "Sad"),
                     Word(hangleName: "존맛탱(JMT)", englishName: "effing awesome", favorites: false, category: "Angry"),
                     Word(hangleName: "존잼", englishName: "very fun", favorites: false, category: "Good"),
                     Word(hangleName: "오빠", englishName: "brother", favorites: false, category: "Angry"),
                     Word(hangleName: "킹받네", englishName: "very angry", favorites: false, category: "Good")]

class WordListView : UIView {
    
    private lazy var wordTableView : UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none // cell line 없애기
        tableView.register(WordCustomCell.self , forCellReuseIdentifier: WordCustomCell.tableCellId)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
//        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(){
        self.addSubview(wordTableView)

        wordTableView.delegate = self
        wordTableView.dataSource = self
        
        wordTableView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
    }
    
    func configureUI() {
        

    }
    
}


// MARK: UITableView Setting

extension WordListView : UITableViewDelegate, UITableViewDataSource {
    
    // 행의 개수를 설정하는 메소드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }

    // 셀을 만드는 메소드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCustomCell.tableCellId, for: indexPath) as! WordCustomCell
//        cell.backgroundColor = UIColor(rgb: 0xF7F8FA)
        cell.selectionStyle = .none // cell 선택시 배경 색 없애기
        
        cell.HangleName.text = words[indexPath.row].hangleName
        cell.EnglishName.text = words[indexPath.row].englishName

        return cell
    }
    
    // DetailView로 들어가기
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        let word = words[indexPath.row]
//        let vc = WordDetailViewController()
//        vc.wordName = word.hangleName
//        navigationController?.pushViewController(vc, animated: true)
//    }
}


