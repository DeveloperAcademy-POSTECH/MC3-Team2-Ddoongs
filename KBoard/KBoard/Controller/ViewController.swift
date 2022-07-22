//
//  ViewController.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/13.
//

import UIKit

private let reuseIdentifier = "CustomTableCell"
// reuseIdentifier = 재사용 가능한 셀을 식별하는데 사용되는 문자열

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    // tableView 생성
    private let tableView = UITableView()
    
    let categorywords = ["윌진규", "바보", "메롱", "임시데이터자리"]

    lazy var category = [
        ["💜BTS💜", "\(categorywords.count) Words"],
        ["💜JungKook💜", "\(categorywords.count) Words" ],
        ["💜JIN💜", "\(categorywords.count) Words"]
    ]
    
//    let word1 = Word(name: "비티짱1", isFavorite: true, isOriginal: true, description: "바티바티", relatedWords: ["바티짱2", "바티짱3"])
//    let word2 = Word(name: "비티짱2", isFavorite: false, isOriginal: true, description: "짱", relatedWords: ["바티짱1", "바티짱3"])
//    let word3 = Word(name: "비티짱3", isFavorite: true, isOriginal: true, description: "ㅋㅋㅋㅋ", usages: [Usage(korean: "지난 주 뮤직쇼 봤어?", english: "music show you see?"), Usage(korean: "지난 치티치티치티?", english: "티clclslsl?")], relatedWords: ["바티장1", "바티짱2"])
//    let word4 = Word(name: "아오나1", isFavorite: true, isOriginal: false)
//    let word5 = Word(name: "zz", isFavorite: false, isOriginal: true, description: "zzzz")
//    let word6 = Word(name: "gg1", isFavorite: false, isOriginal: false, description: "zz")
//    lazy var categories = [Category(categoryName: "BTS", count: "8", words: [word1, word2, word3]),
//    Category(categoryName: "아이돌", count: "8", words: [word4, word5]),
//    Category(categoryName: "소녀시대", count: "8", words: [word6])]
    
    private let editButton: UIButton = {
        let editButton = UIButton()
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.blue, for: .normal)
        return editButton
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
    
    //메소드 영역
    private func setCategoryListContent() {
        self.tableView.backgroundColor = .clear
        tableView.register(CustomTableCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.frame
        
        let vstack = UIStackView(arrangedSubviews: [editButton, tableView])
        vstack.axis = .vertical
        self.view.addSubview(vstack)
        vstack.backgroundColor = .red
        vstack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16)
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
        // 코드 수정 필요!! 삭제 팝업에서 선택한 카테고리명이 떠야하는데 이거 어케 해야할지 조사필요
        let deleteAlert = UIAlertController(title: "Delete Category", message: "Do you want to delete category?", preferredStyle: .alert)
        let delete = UIAlertAction(title: "Delete", style: .destructive) {_ in
            // 코드 수정 필요!! 선택한 셀을 지워야함
//            print("카테고리 삭제 기능 넣어야함 어케 없애누..")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        deleteAlert.addAction(delete)
        deleteAlert.addAction(cancel)
        self.present(deleteAlert, animated: true, completion: nil)
    }
    
    private func showRenameAlert() {
        let renameAlert = UIAlertController(title: "Rename Category", message: "Do you want to rename category?", preferredStyle: .alert)
        let save = UIAlertAction(title: "Save", style: .default) {_ in
            print("저장")
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
}

// MARK: - UITableVIewDataSource

extension ViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CustomTableCell
        cell.categoryInfo = category[indexPath.section]
        cell.cellDelegate = self
        cell.moreButton.tag = indexPath.section
        return cell
    }
    
//    func append(category: Category, to tableView: UITableView) {
//        category.append(category)
//        tableView.insertRows(at: [IndexPath(row: players.count-1, section: 0)], with: .automatic)
//    }
    
    func remove(at indexPath: IndexPath, to tableView: UITableView) {
        category.remove(at: indexPath.section)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let currentCell = tableView.cellForRow(at: indexPath) as? CustomTableCell else return
        tableView.deselectRow(at: indexPath, animated: true)
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

extension ViewController: CategoryEditDelegate {
    func tapMoreButton() {
        showActionSheet()
    }
}
