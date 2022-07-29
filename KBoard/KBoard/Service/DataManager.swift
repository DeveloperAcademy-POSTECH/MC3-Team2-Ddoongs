//
//  DataManager.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/28.
//

import Foundation
import Combine

final class DataManager {
    
    static let shared = DataManager()
    
    private(set) var userCategories: [Category2] = []
    var categoryArrayPublisher: CurrentValueSubject<[Category2], Never> = CurrentValueSubject([])
    var categoryPublisher: CurrentValueSubject<Category2, Never> = CurrentValueSubject(Category2(categoryName: ""))
    
    var numOfCategories: Int {
        return categoryArrayPublisher.value.count
    }
    
    private(set) var defaultCategories: [DefaultCategory] = []
    
    private init() { }
    
    func getCategories() -> [Category2] {
        return categoryArrayPublisher.value
    }
    
    func getCategoryAt(_ index: Int) -> Category2 {
        categoryArrayPublisher.value[index]
    }
    
    func addCategory(categoryName: String) {
        let newCategory = Category2(categoryName: categoryName)
        categoryArrayPublisher.value.append(newCategory)
    }
    
    func editCategoryName(category: Category2, newName: String) {
        guard let categoryIndex = categoryArrayPublisher.value.firstIndex(of: category) else { return }
        categoryArrayPublisher.value[categoryIndex].editName(newName)
    }
    
    func swapCategoryOrder(from sourceIndex: Int, to destinationIndex: Int) {
        categoryArrayPublisher.value.swapAt(sourceIndex, destinationIndex)
    }
    
    func removeCategoryAt(_ index: Int) {
        categoryArrayPublisher.value.remove(at: index)
    }

    func fetchSavedUserCategories2() {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            let word1 = Word2(name: "바티짱1", isFavorite: true, userCateogry: "BTS", defaultCategory: .행복, isOriginal: true, description: "바티바티", relatedWords: ["바티짱2", "바티짱3"])
            let word2 = Word2(name: "바티짱2", isFavorite: false, userCateogry: "BTS", defaultCategory: .행복, isOriginal: true, description: "짱", relatedWords: ["바티짱1", "바티짱3"])
            let word3 = Word2(name: "바티짱3", isFavorite: true, userCateogry: "BTS", defaultCategory: .기쁨, isOriginal: true, description: "ㅋㅋㅋㅋ", usages: [Usage(korean: "지난 주 뮤직쇼 봤어?", english: "music show you see?"), Usage(korean: "지난 치티치티치티?", english: "티clclslsl?")], relatedWords: ["바티짱1", "바티짱2"])
            
            let word4 = Word2(name: "아오나1", isFavorite: true, userCateogry: "소녀시대", defaultCategory: .행복, isOriginal: false)
            let word5 = Word2(name: "zz", isFavorite: false, userCateogry: "소녀시대", defaultCategory: .기쁨, isOriginal: true, description: "zzzz")
            
            let word6 = Word2(name: "gg1", isFavorite: false, userCateogry: "아니이", defaultCategory: .행복, isOriginal: false, description: "zz")
            
            let userCategories: [Category2] = [Category2(categoryName: "BTS", words: [word1, word2, word3]), Category2(categoryName: "소녀시대", words: [word4, word5]), Category2(categoryName: "아니이", words: [word6])]
            
            let defaultCategories: [DefaultCategory] = [DefaultCategory(categoryName: .행복, words: [word1, word2, word4, word6]), DefaultCategory(categoryName: .기쁨, words: [word3, word5])]
            
            self?.userCategories = userCategories
            self?.defaultCategories = defaultCategories
            // TODO: background에서 받으려나? 확인
            DispatchQueue.main.async {
                self?.categoryArrayPublisher.value = userCategories
            }
        }
    }
    
    func initCategory(category: Category2) {
        categoryPublisher.value = category
    }
    
    func getCateogry() -> Category2 {
        categoryPublisher.value
    }
    
    func numberOfWordsAtCategory() -> Int {
        return categoryPublisher.value.words.count
    }
    
    func getWordNameAtIndex(index: Int) -> String {
        return categoryPublisher.value.words[index].name
    }
    
    func getCategoryIndex(category: Category2) -> Int {
        guard let categoryIndex = categoryArrayPublisher.value.firstIndex(of: category) else { return 0 }
        return categoryIndex
    }
    func swapWordOrder(category: Category2, from sourceIndex: Int, to destinationIndex: Int) {
        guard let categoryIndex = categoryArrayPublisher.value.firstIndex(of: category) else { return }
        categoryArrayPublisher.value[categoryIndex].words.swapAt(sourceIndex, destinationIndex)
        categoryPublisher.value.words.swapAt(sourceIndex, destinationIndex)
    }

    func getWord(category: Category2, word: Word2) -> Word2? {
        guard let categoryIndex = userCategories.firstIndex(of: category) else { return nil }
        guard let wordIndex = userCategories[categoryIndex].words.firstIndex(of: word) else { return nil }
        return userCategories[categoryIndex].words[wordIndex]
    }
    
    func addWord(categoryName: String, wordName: String, description: String) {
        let newWord = Word2(name: wordName, isFavorite: true, userCateogry: categoryName, isOriginal: false, description: description)
        if categoryPublisher.value.categoryName == categoryName {
            categoryPublisher.value.words.append(newWord)
        }
        
        guard let index = categoryArrayPublisher.value.firstIndex(where: { $0.categoryName == categoryName }) else { return }
        categoryArrayPublisher.value[index].addWord(newWord)
    }
    
    func removeWordAt(category: Category2, index: Int) {
        categoryPublisher.value.words.remove(at: index)
        guard let index = categoryArrayPublisher.value.firstIndex(of: category) else { return }
        categoryArrayPublisher.value[index].words.remove(at: index)
    }
}
