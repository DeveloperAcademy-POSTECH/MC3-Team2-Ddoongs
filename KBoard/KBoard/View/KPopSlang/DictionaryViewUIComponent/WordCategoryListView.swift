//
//  CategoryListView.swift
//  KBoard
//
//  Created by ParkJunHyuk on 2022/07/27.
//

import UIKit

class WordCategoryListView: UIView {
    
//    let categoryTitle = DefaultCateogryName.allCases
    var kPopSlangViewModel: KPopSlangViewModel
    
    lazy var clickedCategory: ObservableObject<DefaultCateogryName> = ObservableObject(DefaultCateogryName.firstCateogryName)
    // MARK: property
    
    private lazy var categorycollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CollectionCustomCell.self, forCellWithReuseIdentifier: "CollectaionCellId")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    init(kPopSlangViewModel: KPopSlangViewModel) {
        self.kPopSlangViewModel = kPopSlangViewModel
        super.init(frame: CGRect())
        render()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        render()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func render() {
        self.addSubview(categorycollectionView)

        categorycollectionView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: self.frame.width, height: 40)
    }
    
}

// MARK: UICollectionView Setting

extension WordCategoryListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64, height: 30)
    }
}

extension WordCategoryListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return categoryTitle.count
        return kPopSlangViewModel.getNumberOfDefaultCategories()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectaionCellId", for: indexPath) as! CollectionCustomCell
        cell.backgroundColor = .gray
//        cell.categoryLabel.text = categoryTitle[indexPath.row].rawValue
        cell.categoryLabel.text = kPopSlangViewModel.defaultCategoryStringAt(indexPath.row)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        clickedCategory = DefaultCateogryName.allCases[indexPath.row]
        kPopSlangViewModel.switchCategoryAt(indexPath.row)
    }
}
