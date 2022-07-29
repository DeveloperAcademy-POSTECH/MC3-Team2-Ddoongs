//
//  MyBoardListViewModel.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/28.
//

import Foundation

final class BoardListViewModel {
    
    private let manager = DataManager.shared
    
    var categories: ObservableObject<[Category2]?> = ObservableObject(nil)
    
    var userCategoryNameArray: [String] {
        manager.userCategories.map {$0.categoryName}
    }
    
    var numOfCategories: Int {
        manager.numOfCategories
    }
    
    func getCategoryAt(_ index: Int) -> Category2 {
        manager.getCategoryAt(index)
    }
    
    func removeCategoryAt(_ index: Int) {
        manager.removeCategoryAt(index)
        categories.value = manager.getCategories()
    }
    
    func addCategory(name: String) {
        manager.addCategory(categoryName: name)
        print(manager.getCategories().count)
        categories.value = manager.getCategories()
    }
    
    func swapCategory(from sourceIndex: Int, to destinationIndex: Int) {
        manager.swapCategoryOrder(from: sourceIndex, to: destinationIndex)
        categories.value = manager.getCategories()
    }
    
    func fetchSavedCategories() {
        manager.fetchSavedUserCategories { categories in
            self.categories.value = categories
        }
    }
    
    func editCategoryName(category: Category2, name: String) {
        manager.editCategoryName(category: category, newName: name)
        categories.value = manager.getCategories()
    }
    
    
    
    
    
    
    func numberOfWordsAtCategory(category: Category2) -> Int {
        manager.numberOfWordsAtCategory(category: category)
    }
    
    func wordNameAtIndex(category: Category2, _ index: Int) -> String {
        guard let word =  manager.getWordAtIndex(category: category, index: index) else {
            return ""
        }
        return word.name
    }
    
    func addWord(categoryName: String, wordName: String, wordDescription: String) {
        manager.addWord(categoryName: categoryName, wordName: wordName, description: wordDescription)
        categories.value = manager.getCategories()
    }
    
    func swapWord(category: Category2, from sourceIndex: Int, to destinationIndex: Int) {
        manager.swapWordOrder(category: category, from: sourceIndex, to: destinationIndex)
        categories.value = manager.getCategories()
    }
    
    func removeWord(category: Category2, index: Int) {
        manager.removeWordAt(category: category, index: index)
        categories.value = manager.getCategories()
    }
    
}

final class CategoryViewModel {
    
    private let manager = DataManager.shared
    
    var category: ObservableObject<Category2?> = ObservableObject(nil)
    
    
}
