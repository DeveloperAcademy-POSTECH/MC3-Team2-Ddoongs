//
//  ViewController.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/13.
//

import UIKit

class CategoryListViewController: UIViewController, CategoryNameProtocol {
    
    // MARK: - Properties
    private let reuseIdentifier = "CustomTableCell"
    
    private let tableView = UITableView()
    
    let word1 = KWord(name: "비티짱1", isFavorite: true, isOriginal: true, description: "바티바티", relatedWords: ["바티짱2", "바티짱3"])
    let word2 = KWord(name: "비티짱2", isFavorite: false, isOriginal: true, description: "짱", relatedWords: ["바티짱1", "바티짱3"])
    let word3 = KWord(name: "비티짱3", isFavorite: true, isOriginal: true, description: "ㅋㅋㅋㅋ", usages: [Usage(korean: "지난 주 뮤직쇼 봤어?", english: "music show you see?"), Usage(korean: "지난 치티치티치티?", english: "티clclslsl?")], relatedWords: ["바티장1", "바티짱2"])
    let word4 = KWord(name: "아오나1", isFavorite: true, isOriginal: false)
    let word5 = KWord(name: "zz", isFavorite: false, isOriginal: true, description: "zzzz")
    let word6 = KWord(name: "gg1", isFavorite: false, isOriginal: false, description: "zz")
    var categories: [Category] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        categories = [Category(categoryName: "💜BTS💜", count: "8 Words", kwords: [word1, word2, word3]),
                      Category(categoryName: "아이돌", count: "8 Words", kwords: [word4, word5]),
                      Category(categoryName: "소녀시대", count: "8 Words", kwords: [word6])]
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemGray5
        setNavigation()
        setCategoryListContent()
    }
    
    private func setNavigation() {
        self.navigationItem.title = "My Board"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapEditButton(_:)))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddButton(_:))),
            UIBarButtonItem(image: UIImage(systemName: "keyboard"), style: .done, target: self, action: nil)
        ]
    }
    
    private func setCategoryListContent() {
        self.tableView.backgroundColor = .clear
        tableView.register(CustomTableCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16)
    }
    
    func categoryNameSend(name: String) {
        categories.append(Category(categoryName: name, count: "0 Words", kwords: nil))
        
    }
    
    private func showActionSheet() {
        let actionSheet = UIAlertController(title: "타이틀", message: "액션시트 메시지", preferredStyle: .actionSheet)
        let rename = UIAlertAction(title: "Rename", style: .default) { _ in
            self.tapAddButton(UIButton())
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(rename)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc private func tapAddButton(_ sender: Any) {
        let addModel = AddNewCategory()
        addModel.categoryNameDelegate = self
        let nav = UINavigationController(rootViewController: addModel)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
                    sheet.detents = [.medium()]
                }
                present(nav, animated: true, completion: nil)
    }
    
    @objc func tapEditButton(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: tableView.isEditing ? .done : .edit, target: self, action: #selector(tapEditButton))
    }
}

// MARK: - UITableVIewDataSource
extension CategoryListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CustomTableCell
        cell.categoryInfo = categories[indexPath.section]
        cell.cellDelegate = self
        cell.moreButton.tag = indexPath.section
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CategoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(CategoryViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat = CGFloat.leastNormalMagnitude
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    // 셀 삭제
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            let indexSet = IndexSet(arrayLiteral: indexPath.section)
            self.categories.remove(at: indexPath.section)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        return swipeActions
    }
    
    // 셀 이동
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        categories.swapAt(sourceIndexPath.section, destinationIndexPath.section)
    }
}

extension CategoryListViewController: CategoryEditDelegate {
    func tapMoreButton() {
        showActionSheet()
    }
}
