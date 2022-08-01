//
//  MyBoardListViewModel.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/28.
//

import Foundation
import Combine

final class BoardListViewModel {
    
    private let manager = DataManager.shared
    
    var bag = Set<AnyCancellable>()
    
    var categories: ObservableObject<[Category2]?> = ObservableObject(nil)
    
    init() {

        manager.categoryArrayPublisher.sink {
            print("여기는역시")
            self.categories.value = $0
        }
        .store(in: &bag)
        
        manager.fetchSavedUserCategories2()
    }
    
    var numOfCategories: Int {
        manager.numOfCategories
    }
    
    func getCategoryAt(_ index: Int) -> Category2 {
        manager.getCategoryAt(index)
    }
    
    func removeCategoryAt(_ index: Int) {
        manager.removeCategoryAt(index)
    }
    
    func addCategory(name: String) {
        manager.addCategory(categoryName: name)
    }
    
    func swapCategory(from sourceIndex: Int, to destinationIndex: Int) {
        manager.swapCategoryOrder(from: sourceIndex, to: destinationIndex)
    }
    
    func editCategoryName(category: Category2, name: String) {
        manager.editCategoryName(category: category, newName: name)
    }
    
}

final class CategoryViewModel {
    
    private let manager = DataManager.shared
    
    var bag = Set<AnyCancellable>()
    
    var category: ObservableObject<Category2?> = ObservableObject(nil)
    
    init(category: Category2) {
        
        manager.categoryPublisher.sink {
            self.category.value = $0
        }
        .store(in: &bag)
        manager.initCategory(category: category)
    }
    
    func getCategoryIndex() -> Int? {
        manager.getCategoryIndexWithCategoryName(categoryName: getCategoryName())
    }
    
    func getCategoryName() -> String {
        return manager.getCateogry().categoryName
    }
    
    func numOfCategories() -> Int {
        return manager.numOfCategories
    }
    var userCategoryNameArray: [String] {
        return manager.getCategories().map {$0.categoryName}
    }
    
    func numberOfWordsAtCategory() -> Int {
        return manager.numberOfWordsAtCategory()
    }
    
    func wordNameAtIndex(_ index: Int) -> Word2 {
        return manager.getWordNameAtIndex(index: index)
    }
    
    func addWord(categoryName: String, wordName: String, wordDescription: String) {
        return manager.addWord(categoryName: categoryName, wordName: wordName, description: wordDescription)
    }
    
    func swapWord(from sourceIndex: Int, to destinationIndex: Int) {
        let category = manager.getCateogry()
        return manager.swapWordOrder(category: category, from: sourceIndex, to: destinationIndex)
    }
    
    func removeWordAt(_ index: Int) {
        let category = manager.getCateogry()
        return manager.removeWordAt(category: category, index: index)
    }
    
}
