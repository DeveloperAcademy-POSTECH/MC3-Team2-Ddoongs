//
//  DictionaryViewController.swift
//  KBoard
//
//  Created by ParkJunHyuk on 2022/07/24.
//

import UIKit

class DictionaryViewController: UIViewController, UISearchBarDelegate {
    
    private let dictionaryHeaderView = DictionaryHeaderView()
    var tableView = UITableView()
    var headerViewTopConstraint: NSLayoutConstraint?
    
    var kPopSlangViewModel = KPopSlangViewModel()
    
    var allWords: [Word2]!
    var filtered: [Word2]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configureUI()
        setupTableView()
        setUpBinding()
        dictionaryHeaderView.searchBar.delegate = self

    }
    
    private func setUpBinding() {
        
        kPopSlangViewModel.changesInUserCategories.bind { [weak self] _ in
            print("reload kpop slang")
            self?.tableView.reloadData()
        }
        
        kPopSlangViewModel.category.bind { [weak self] category in
            guard let category = category else { return }
            self?.allWords = category.words
            self?.filtered = self?.allWords
            self?.tableView.reloadData()
        }
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filtered = []
        
        if searchText == "" {
            print("~!", searchText)
            filtered = allWords
            
        } else {
            print("~!!")
            print("~!!,", allWords.map {$0.name})
            for word in allWords {
                if word.name.lowercased().contains(searchText.lowercased()) {
                    print("~!!추가됩니다.", word.name)
                    filtered.append(word)
                    print("~!!", filtered.map {$0.name})
                }
            
                if let pronunciation = word.pronunciation {
                    if pronunciation.lowercased().contains(searchText.lowercased()) {
                        print("~!!!", word.name)
                        filtered.append(word)

                    }
                }

            }
        }
        
        self.tableView.reloadData()
        
    }
    
}

extension DictionaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none // cell line 없애기
        tableView.register(WordCustomCell.self, forCellReuseIdentifier: WordCustomCell.tableCellId)
    }
    // 행의 개수를 설정하는 메소드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return Word.words.count
        guard let filtered = filtered else { return 0}
        return filtered.count
    }

    // 셀을 만드는 메소드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCustomCell.tableCellId, for: indexPath) as! WordCustomCell

        guard !filtered.isEmpty else { return UITableViewCell()}
        cell.isStar = filtered[indexPath.row].userCateogry != ""
        let word = filtered[indexPath.row]
        print(filtered[indexPath.row].name)
        cell.HangleName.text = filtered[indexPath.row].name
        cell.EnglishName.text = filtered[indexPath.row].pronunciation
        
        cell.selectionStyle = .none
        return cell
    }
    
    // DetailView로 들어가기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let word = filtered[indexPath.row]
        print("qqwqw", word)
        let vc = WordDetailViewController(wordViewModel: WordViewModel(word: word))
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // TableView scroll 시 실행되는 메소드
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y // Y 축으로 스크롤 되는 크기
        guard kPopSlangViewModel.getNumberOfWords() > 4 else { return }
        let swipingDown = y <= 0 // 아래로 스크롤 됐다는 상태 변수
        let shouldSnap = y > 60 // UpperHeaderView 높이 + padding
        let headerHeight = 170 // 전체 HeaderView 높이
        
        UIView.animate(withDuration: 0.3) {
            self.dictionaryHeaderView.upperHeaderView.alpha = swipingDown ? 1.0 : 0.0
        }

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            self.headerViewTopConstraint?.constant = CGFloat(shouldSnap ? -headerHeight : 0)
            self.view.layoutIfNeeded()
        })

    }
    
}
