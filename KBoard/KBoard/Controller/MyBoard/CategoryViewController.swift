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
        view.backgroundColor = .systemGray6
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
    
    // MARK: - UICollectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 80)
    }
    
    fileprivate func registerCollectionView() {
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(CategoryCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseHeaderIdentifier)
    }
    
    fileprivate func collectionViewDelegate() {
            collectionView.delegate = self
            collectionView.dataSource = self
    }
    
    fileprivate func configureUI() {
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16)
        collectionView.backgroundColor = .systemGray6
    }
}

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return data.count
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
                    cell.wordLabel.text = data[indexPath.row]
            return cell
        }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
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
                header.update()
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

class CategoryCollectionHeaderView: UICollectionReusableView {
    
    var tapHandler: (() -> Void)?
    
    fileprivate let  addMyOwnWordLabel: UILabel = {
        let label = UILabel()
        label.text = "Add My Own Word"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .lightGray
        return label
    }()
    
    fileprivate let  plusButtonImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "plus.circle")!
        imageView.image = image
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    @objc fileprivate func addword() {
        tapHandler?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update() {
        let headerButton = UIButton()
        headerButton.addTarget(self, action: #selector(addword), for: .touchUpInside)
        headerButton.backgroundColor = .clear
        let hstack = UIStackView(arrangedSubviews: [plusButtonImage, addMyOwnWordLabel])
        plusButtonImage.setWidth(width: 30)
        plusButtonImage.setHeight(height: 30)
        hstack.axis = .horizontal
        hstack.spacing = 10
        self.addSubview(hstack)
        self.addSubview(headerButton)
        headerButton.addDashedBorder(x: self.frame.size.width - 2, y: 50)
        headerButton.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 6, paddingLeft: 1, paddingBottom: 24, paddingRight: 1)
        hstack.centerX(inView: headerButton)
        hstack.centerY(inView: headerButton)
    }
}

// MARK: - UICollectionViewCell

class CollectionViewCell: UICollectionViewCell {
    
    var wordLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
    }
    
    func setUpCell() {
        let containerView = UIView()
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 6
        self.contentView.addSubview(containerView)
        containerView.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        containerView.addSubview(wordLabel)
        wordLabel.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, left: containerView.safeAreaLayoutGuide.leftAnchor, bottom: containerView.safeAreaLayoutGuide.bottomAnchor, right: containerView.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: Constants.cellHorizontalInterval, paddingBottom: 0, paddingRight: Constants.cellHorizontalInterval)
        }
}
