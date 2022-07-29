//
//  CategoryViewController.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/26.
//

import UIKit

// TODO: 카드 둥글기 전역 함수 수정 요구

class CategoryViewController: UIViewController {

    fileprivate let reuseIdentifier = "cellID"
    fileprivate let reuseHeaderIdentifier = "headerID"
    
    var boardListViewModel: BoardListViewModel?
    var category: Category2?
    
//    private var data: [String] = [] {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    fileprivate func setUpBinding() {
        boardListViewModel?.categories.bind({ [weak self] _ in
            self?.tableView.reloadData()
            self?.scrollToBottom()
        })
    }
    
    fileprivate var tableView: UITableView = UITableView()
    
    lazy var keyBoard: UIButton = {
        let button = UIButton()
        let boldSearch = UIImage(systemName: "keyboard")
        button.setImage(boldSearch, for: .normal)
        // TODO: KeyboardViewController
//        button.addTarget(self, action: #selector(saveSelector), for: .touchUpInside)
      return button
    }()
    
    var addMyOwnWordLabel: UILabel {
        let label = UILabel()
        label.text = "Add My Own Word"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .lightGray
        return label
    }
    
    var plusButtonImageView: UIImageView {
        let imageView = UIImageView()
        let image = UIImage(systemName: "plus.circle")
        imageView.image = image
        imageView.setWidth(width: 30)
        imageView.setHeight(height: 30)
        imageView.tintColor = .lightGray
        return imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        talbeViewDelegate()
        configureUI()
        setUpBinding()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: CategoryName
        navigationItem.title = title
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(editWords)),
            UIBarButtonItem(customView: keyBoard )
        ]
        
    }

    @objc fileprivate func editWords() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: tableView.isEditing ? .done : .edit, target: self, action: #selector(editWords))
    }
    
    fileprivate func registerTableView() {
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    fileprivate func talbeViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    fileprivate func configureUI() {
        tableView.rowHeight = 50
        tableView.backgroundColor = .systemGray6
        view.backgroundColor = .systemGray6
        
        let hstack = UIStackView(arrangedSubviews: [plusButtonImageView, addMyOwnWordLabel])
        hstack.axis = .horizontal
        hstack.spacing = 10
        
        let headerButton = UIButton()
        headerButton.addTarget(self, action: #selector(addWord), for: .touchUpInside)
        
        let baseView = UIView()
        baseView.addSubview(hstack)
        baseView.addSubview(headerButton)
        
        headerButton.anchor(top: baseView.topAnchor, left: baseView.leftAnchor, bottom: baseView.bottomAnchor, right: baseView.rightAnchor, paddingTop: 0, paddingLeft: 1, paddingBottom: 0, paddingRight: 1)
        // TODO: 가로모드 할 시 주의
        headerButton.addDashedBorder(x: view.frame.width - (16*2+2), y: 50)
        hstack.centerX(inView: baseView)
        hstack.centerY(inView: baseView)
        
        let vstack = UIStackView(arrangedSubviews: [baseView, tableView])
        view.addSubview(vstack)
        vstack.axis = .vertical
        vstack.spacing = 10
        vstack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: Constants.tableViewHorizontalPadding, paddingBottom: 0, paddingRight: Constants.tableViewHorizontalPadding)
        baseView.anchor(top: vstack.topAnchor, left: vstack.leftAnchor, right: vstack.rightAnchor, paddingTop: 6, paddingLeft: 1, paddingRight: 1, height: 50)
        tableView.anchor(top: baseView.bottomAnchor, left: vstack.leftAnchor, bottom: vstack.bottomAnchor, right: vstack.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 20, paddingRight: 0)
    }
    
    @objc fileprivate func addWord() {
        
        let vc = AddWordViewController()
        vc.category = category
        vc.boardListViewModel = boardListViewModel
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
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
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        guard let vm = boardListViewModel,
              let category = category
        else {
            return 0
        }
        print("!", vm.numberOfWordsAtCategory(category: category))
        return vm.numberOfWordsAtCategory(category: category)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CategoryTableViewCell,
              let vm = boardListViewModel,
              let category = category
        else { return UITableViewCell() }
        
        cell.wordLabel.text = vm.wordNameAtIndex(category: category, indexPath.section)
        
        return cell
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            guard let category = self.category else { return }
            self.boardListViewModel?.removeWord(category: category, index: indexPath.section)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let category = category else { return }
        boardListViewModel?.swapWord(category: category, from: sourceIndexPath.section, to: destinationIndexPath.section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(WordDetailViewController(), animated: true)
    }
    
}
