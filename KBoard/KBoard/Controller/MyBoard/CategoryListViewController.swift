//
//  ViewController.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/13.
//

import UIKit

class CategoryListViewController: UIViewController, CategoryNameProtocol {
    
    deinit {
        print("deinit")
    }
    
    // MARK: - Properties
    private let reuseIdentifier = "CustomTableCell"
    
    private let tableView = UITableView()

    private var boardListViewModel = BoardListViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        boardListViewModel.categories.bind { [weak self] _ in
            self?.tableView.reloadData()
            print("reload listview")
            print("zz", self?.boardListViewModel.categories.value)
            // TODO 수정할때는 내려가면 안된다.
            self?.scrollToBottom()
        }
    }

    private func configureUI() {
        self.view.backgroundColor = .systemGray5
        setNavigation()
        setCategoryListContent()
    }
    
    private func scrollToBottom() {
        let lastRowOfIndexPath = self.tableView.numberOfSections - 1
        print(lastRowOfIndexPath)
        if lastRowOfIndexPath >= 0 {
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: 0, section: lastRowOfIndexPath)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    private func setNavigation() {
        navigationController?.navigationBar.topItem?.title = "My Board"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
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
//        categories.append(Category(categoryName: name, count: "0 Words", kwords: nil))
    }
    
    private func showActionSheet(category: Category2) {
        let actionSheet = UIAlertController(title: "타이틀", message: "액션시트 메시지", preferredStyle: .actionSheet)
        let rename = UIAlertAction(title: "Rename", style: .default) { _ in
//            self.showRenameAlert(category: category)
            self.tapAddButton(UIButton())
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(rename)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
//    private func showRenameAlert(category: Category2) {
//        let renameAlert = UIAlertController(title: "Rename Category", message: "Do you want to rename category?", preferredStyle: .alert)
//        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
//            // To-Do : 카테고리 명 수정 시 카테고리 리스트에 적용
//            guard let text = renameAlert.textFields?.first?.text,
//                  !text.isEmpty
//            else { return }
//            self?.boardListViewModel.editCategoryName(category: category, name: text)
//
//        }
//        let cancel = UIAlertAction(title: "cancel", style: .cancel)
//        renameAlert.addAction(save)
//        renameAlert.addAction(cancel)
//        renameAlert.addTextField { (newCategoryName) in
//            newCategoryName.placeholder = "\(category.categoryName)"
//        }
//        self.present(renameAlert, animated: true, completion: nil)
//    }
    
    @objc private func tapAddButton(_ sender: Any) {
        let addModel = AddNewCategory()
        addModel.categoryNameDelegate = self
        addModel.boardListViewModel = boardListViewModel
        let nav = UINavigationController(rootViewController: addModel)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
                    sheet.detents = [.medium()]
                }
                present(nav, animated: true, completion: nil)
    }
    
    @objc func tapEditButton(_ sender: UIBarButtonItem) {
        
        tableView.setEditing(!tableView.isEditing, animated: true)
//        if tableView.isEditing {
//            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapEditButton))
//        } else {
//            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapEditButton))
//        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: tableView.isEditing ? .done : .edit, target: self, action: #selector(tapEditButton))

    }
}

// MARK: - UITableVIewDataSource
extension CategoryListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return boardListViewModel.numOfCategories
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardListViewModel.numOfCategories == 0 ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CustomTableCell
//        cell.categoryInfo = categories[indexPath.section]
        cell.categoryInfo = boardListViewModel.getCategoryAt(indexPath.section)
        cell.cellDelegate = self
        cell.moreButton.tag = indexPath.section
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension CategoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let vc = CategoryViewController(boardListViewModel: boardListViewModel, category: boardListViewModel.getCategoryAt(indexPath.section))
        let category = boardListViewModel.getCategoryAt(indexPath.section)
        let vc = CategoryViewController(categoryViewModel: CategoryViewModel(category: category))
        
        navigationController?.pushViewController(vc, animated: true)
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
            self.boardListViewModel.removeCategoryAt(indexPath.section)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        return swipeActions
    }
    
    // 셀 이동
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        boardListViewModel.swapCategory(from: sourceIndexPath.section, to: destinationIndexPath.section)
    }
}

extension CategoryListViewController: CategoryEditDelegate {
    func tapMoreButton(category: Category2) {
        showActionSheet(category: category)
    }
}
