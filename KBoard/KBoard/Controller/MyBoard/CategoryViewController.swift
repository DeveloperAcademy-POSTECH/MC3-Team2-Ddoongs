//
//  CategoryViewController.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/26.
//

import UIKit

// TODO: MyBoardViewController에서 navigation large 적용 필요.

class CategoryViewController: UIViewController {

    fileprivate let reuseIdentifier = "cellID"
    fileprivate let reuseHeaderIdentifier = "headerID"
    fileprivate let data = ["q", "w", "e", "r"]
    
    fileprivate var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var keyBoard: UIButton = {
        let button = UIButton()
        let boldSearch = UIImage(systemName: "keyboard")
        button.setImage(boldSearch, for: .normal)
        // TODO: KeyboardViewController
//        button.addTarget(self, action: #selector(saveSelector), for: .touchUpInside)
      return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        collectionViewDelegate()
        configureUI()
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
        // TODO: Edit Words
//        let categoryEditViewController = CategoryEditViewController()
//        navigationController?.pushViewController(categoryEditViewController, animated: true)
    }
    
    fileprivate func registerCollectionView() {
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(CategoryCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseHeaderIdentifier)
    }
    
    fileprivate func collectionViewDelegate() {
            collectionView.delegate = self
            collectionView.dataSource = self
    }
    
    fileprivate func configureUI() {
        view.addSubview(collectionView)
        view.backgroundColor = .systemGray6
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16)
        collectionView.backgroundColor = .systemGray6
    }
}

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return data.count
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
                    cell.wordLabel.text = data[indexPath.row]
            return cell
        }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.intervalBetweenCells
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseHeaderIdentifier, for: indexPath) as? CategoryCollectionHeaderView else {
                    return UICollectionReusableView()
                }
                header.render()
                header.tapHandler = {
                    // TODO: addWordViewController
                }
                return header
            default:
                return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: WordDetailViewController
    }
}
