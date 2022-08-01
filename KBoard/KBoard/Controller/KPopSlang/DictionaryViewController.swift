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
    
    var kPopSlangViewModel = KPopSlangViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configureUI()
        setupTableView()
        setUpBinding()
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
//        cell.backgroundColor = UIColor(rgb: 0xF7F8FA)
        cell.isStar = kPopSlangViewModel.getWordAtIndex(indexPath.row).userCateogry != ""
        cell.selectionStyle = .none
        let word = kPopSlangViewModel.getWordAtIndex(indexPath.row)
        cell.HangleName.text = word.name
        cell.EnglishName.text = word.pronunciation
        
//        cell.HangleName.text = Word.words[indexPath.row].hangleName
//        cell.EnglishName.text = Word.words[indexPath.row].englishName

        return cell
    }
    
    // DetailView로 들어가기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let word = Word.words[indexPath.row]
        let word = kPopSlangViewModel.getWordAtIndex(indexPath.row)
        print("qqwqw", word)
        let vc = WordDetailViewController(wordViewModel: WordViewModel(word: word))
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
