//
//  DictionaryViewController.swift
//  KBoard
//
//  Created by ParkJunHyuk on 2022/07/24.
//

import UIKit

class DictionaryViewController: UIViewController {
    
    private let dictionaryHeaderView = DictionaryHeaderView()
    var tableView = UITableView()
    var headerViewTopConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configureUI()
        setupTableView()
    }
    
    private func render() {
        
        view.addSubview(dictionaryHeaderView)
        view.addSubview(tableView)
        
        dictionaryHeaderView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        headerViewTopConstraint = dictionaryHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)

        NSLayoutConstraint.activate([
        
            headerViewTopConstraint!,
            dictionaryHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dictionaryHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            
            tableView.topAnchor.constraint(equalTo: dictionaryHeaderView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
}

extension DictionaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none // cell line 없애기
        tableView.register(WordCustomCell.self , forCellReuseIdentifier: WordCustomCell.tableCellId)
        
    }
    
    // TableView scroll 시 실행되는 메소드
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y // Y 축으로 스크롤 되는 크기

        let swipingDown = y <= 0 // 아래로 스크롤 됐다는 상태 변수
        let shouldSnap = y > 60 // UpperHeaderView 높이 + padding
        let headerHeight = 170 // 전체 HeaderView 높이
        
        UIView.animate(withDuration: 0.3){
            self.dictionaryHeaderView.upperHeaderView.alpha = swipingDown ? 1.0 : 0.0
        }

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            self.headerViewTopConstraint?.constant = CGFloat(shouldSnap ? -headerHeight : 0)
            self.view.layoutIfNeeded()
        })

    }

    // 행의 개수를 설정하는 메소드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Word.words.count
    }

    // 셀을 만드는 메소드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCustomCell.tableCellId, for: indexPath) as! WordCustomCell
//        cell.backgroundColor = UIColor(rgb: 0xF7F8FA)
        cell.selectionStyle = .none
        cell.HangleName.text = Word.words[indexPath.row].hangleName
        cell.EnglishName.text = Word.words[indexPath.row].englishName

        return cell
    }
    
    // DetailView로 들어가기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let word = Word.words[indexPath.row]
        let vc = WordDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
