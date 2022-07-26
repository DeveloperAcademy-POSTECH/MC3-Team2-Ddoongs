//
//  ViewController.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/13.
//

import UIKit

class CategoryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    private let reuseIdentifier = "CustomTableCell"
    // reuseIdentifier = 재사용 가능한 셀을 식별하는데 사용되는 문자열
    
    private let tableView = UITableView()
    
    private let editButton: UIButton = {
        let editButton = UIButton()
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.blue, for: .normal)
        return editButton
    }()
    
    let word1 = Word(name: "비티짱1", isFavorite: true, isOriginal: true, description: "바티바티", relatedWords: ["바티짱2", "바티짱3"])
    let word2 = Word(name: "비티짱2", isFavorite: false, isOriginal: true, description: "짱", relatedWords: ["바티짱1", "바티짱3"])
    let word3 = Word(name: "비티짱3", isFavorite: true, isOriginal: true, description: "ㅋㅋㅋㅋ", usages: [Usage(korean: "지난 주 뮤직쇼 봤어?", english: "music show you see?"), Usage(korean: "지난 치티치티치티?", english: "티clclslsl?")], relatedWords: ["바티장1", "바티짱2"])
    let word4 = Word(name: "아오나1", isFavorite: true, isOriginal: false)
    let word5 = Word(name: "zz", isFavorite: false, isOriginal: true, description: "zzzz")
    let word6 = Word(name: "gg1", isFavorite: false, isOriginal: false, description: "zz")
    var categories: [Category] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        categories = [Category(categoryName: "💜BTS💜", count: "8 Words", words: [word1, word2, word3]),
                      Category(categoryName: "아이돌", count: "8 Words", words: [word4, word5]),
                      Category(categoryName: "소녀시대", count: "8 Words", words: [word6])]
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemGray5
        setNavigation()
        setCategoryListContent()
    }
    
    private func setNavigation() {
        self.navigationItem.title = "My Board"
        navigationController?.navigationBar.prefersLargeTitles = true
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
        self.view.addSubview(editButton)
        editButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingRight: 16)
        tableView.anchor(top: editButton.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16)
        
    }
    
    private func showActionSheet() {
        let actionSheet = UIAlertController(title: "타이틀", message: "액션시트 메시지", preferredStyle: .actionSheet)
        let rename = UIAlertAction(title: "Rename", style: .default) { _ in
            print("수정")
            self.showRenameAlert()
        }
        let delete = UIAlertAction(title: "Delete", style: .destructive) { _ in
            print("삭제")
            self.showDeleteAlert()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(rename)
        actionSheet.addAction(delete)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private func showDeleteAlert() {
        let deleteAlert = UIAlertController(title: "Delete Category", message: "Do you want to delete category?", preferredStyle: .alert)
        let delete = UIAlertAction(title: "Delete", style: .destructive) {_ in
            // To-Do : 선택한 카테고리 리스트 삭제 기능
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        deleteAlert.addAction(delete)
        deleteAlert.addAction(cancel)
        self.present(deleteAlert, animated: true, completion: nil)
    }
    
    private func showRenameAlert() {
        let renameAlert = UIAlertController(title: "Rename Category", message: "Do you want to rename category?", preferredStyle: .alert)
        let save = UIAlertAction(title: "Save", style: .default) {_ in
            // To-Do : 카테고리 명 수정 시 카테고리 리스트에 적용
            print("수정완료")
        }
        let cancel = UIAlertAction(title: "cancel", style: .cancel)
        renameAlert.addAction(save)
        renameAlert.addAction(cancel)
        renameAlert.addTextField { (newCategoryName) in
            newCategoryName.placeholder = "New Category Name"
        }
        self.present(renameAlert, animated: true, completion: nil)
    }
    
    @objc private func tapAddButton(_ sender: Any) {
        let addModel = AddNewCategory()
        let nav = UINavigationController(rootViewController: addModel)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(nav, animated: true, completion: nil)
    }
    
    // TO-DO : 카테고리 삭제 기능 구현 예정..
    func remove(at indexPath: IndexPath, to tableView: UITableView) {
        categories.remove(at: indexPath.section)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - UITableVIewDataSource
extension CategoryListViewController {
    
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
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // TO-Do : 카테고리 선택 시 해당 카테고리 상세로 화면이동
        print("카테고리선택됨")
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
}

extension CategoryListViewController: CategoryEditDelegate {
    func tapMoreButton() {
        showActionSheet()
    }
}
