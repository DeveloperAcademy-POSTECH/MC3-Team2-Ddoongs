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
        setTableView()
        //        setEditButton()
    }
    
    private func setNavigation() {
        self.navigationItem.title = "My Board"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "keyboard"), style: .done, target: self, action: nil)
        ]
    }
    
    //  테이블뷰 메소드
    private func setTableView() {
        self.tableView.backgroundColor = .clear
        tableView.register(CustomTableCell.self, forCellReuseIdentifier: reuseIdentifier)
        //        tableView.rowHeight = 120
        //        tableView.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16) 오류뜸
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        
    }
    
    private func setEditButton() {
        view.addSubview(editButton)
        editButton.frame = view.frame
        editButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: 50, paddingRight: 10)
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
        // 코드 수정 필요!! 삭제 팝업에서 선택한 카테고리명이 떠야하는데 이거 어케 해야할지 물어보기!
        let deleteAlert = UIAlertController(title: "Delete Category", message: "Do you want to delete \(category[0].first) category?", preferredStyle: .alert)
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
    
}

// MARK: - UITableVIewDataSource

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CustomTableCell
        cell.categoryInfo = category[indexPath.row]
        cell.cellDelegate = self
        cell.moreButton.tag = indexPath.row
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let currentCell = tableView.cellForRow(at: indexPath) as? CustomTableCell else return
        tableView.deselectRow(at: indexPath, animated: true)
        print("카테고리선택됨")
    }
}

extension ViewController: CategoryEditDelegate {
    func tapMoreButton() {
        showActionSheet()
    }
}
