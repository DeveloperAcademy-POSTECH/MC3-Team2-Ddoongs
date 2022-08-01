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
    
    var filteredData: [Word]!
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
        
        kPopSlangViewModel.category.bind { [weak self] _ in
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

        filteredData = []
        
        if searchText == "" {
            filteredData = Word.words
            
        } else {
            
            for word in Word.words {
                if word.hangleName.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(word)
                    
                } else if word.englishName.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(word)
                    
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
        return kPopSlangViewModel.getNumberOfWords()
    }

    // 셀을 만드는 메소드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCustomCell.tableCellId, for: indexPath) as! WordCustomCell
        cell.isStar = kPopSlangViewModel.getWordAtIndex(indexPath.row).userCateogry != ""
        cell.selectionStyle = .none
        let word = kPopSlangViewModel.getWordAtIndex(indexPath.row)
        cell.HangleName.text = word.name
        cell.EnglishName.text = word.pronunciation
        return cell
    }
    
    // DetailView로 들어가기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let word = kPopSlangViewModel.getWordAtIndex(indexPath.row)
        print("qqwqw", word)
        let vc = WordDetailViewController(wordViewModel: WordViewModel(word: word))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // TableView scroll 시 실행되는 메소드
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y // Y 축으로 스크롤 되는 크기

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

