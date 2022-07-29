//
//  DataManager.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/28.
//

import Foundation

final class DataManager {
    
    static let shared = DataManager()
    
    private(set) var userCategories: [Category2] = []
    
    var numOfCategories: Int {
        userCategories.count
    }
    
    private(set) var defaultCategories: [DefaultCategory] = []
    
    private init() { }
    
    func getCategories() -> [Category2] {
        return userCategories
    }
    
    func getCategoryAt(_ index: Int) -> Category2 {
        userCategories[index]
    }
    func addCategory(categoryName: String) {
        let newCategory = Category2(categoryName: categoryName)
        userCategories.append(newCategory)
        // TODO: 새로고침
    }
    
    func editCategoryName(category: Category2, newName: String) {
        guard let categoryIndex = userCategories.firstIndex(of: category) else { return }
        userCategories[categoryIndex].editName(newName)
        // TODO: 새로고침
    }
    
    func numberOfWordsAtCategory(category: Category2) -> Int {
        guard let categoryIndex = userCategories.firstIndex(of: category) else { return 0 }
        return userCategories[categoryIndex].words.count
    }
    
    func getWordAtIndex(category: Category2, index: Int) -> Word2? {
        guard let categoryIndex = userCategories.firstIndex(of: category) else { return nil }
        return userCategories[categoryIndex].words[index]
    }
    
    func removeCategoryAt(_ index: Int) {
        userCategories.remove(at: index)
    }
    func getCategory(category: Category2) -> Category2? {
        return userCategories.first {
            $0 == category
        } ?? nil
    }
    
    func swapCategoryOrder(from sourceIndex: Int, to destinationIndex: Int) {
        userCategories.swapAt(sourceIndex, destinationIndex)
    }
    
    func swapWordOrder(category: Category2, from sourceIndex: Int, to destinationIndex: Int) {
        guard let categoryIndex = userCategories.firstIndex(of: category) else { return }
        userCategories[categoryIndex].words.swapAt(sourceIndex, destinationIndex)
    }
    
    func getRelatedWord(category: Category2, string: String) -> Word2? {
        guard let categoryIndex = userCategories.firstIndex(of: category) else { return nil }
        let words = userCategories[categoryIndex].words.map {$0.name}
        guard let wordIndex = words.firstIndex(where: { word in
            word == string
        }) else { return nil }
        return userCategories[categoryIndex].words[wordIndex]
    }
    
    func getWord(category: Category2, word: Word2) -> Word2? {
        guard let categoryIndex = userCategories.firstIndex(of: category) else { return nil }
        guard let wordIndex = userCategories[categoryIndex].words.firstIndex(of: word) else { return nil }
        return userCategories[categoryIndex].words[wordIndex]
    }
    
    func addWord(categoryName: String, wordName: String, description: String) {
        guard let index = userCategories.firstIndex(where: { $0.categoryName == categoryName }) else { return }
        let newWord = Word2(name: wordName, isFavorite: true, userCateogry: categoryName, isOriginal: false, description: description)
        userCategories[index].addWord(newWord)
    }
    
    func getWords(category: Category2) -> [Word2]? {
        guard let index = userCategories.firstIndex(of: category) else { return nil }
        return userCategories[index].words
    }
    
    func removeWordAt(category: Category2, index: Int) {
        guard let index = userCategories.firstIndex(of: category) else { return }
        userCategories[index].words.remove(at: index)
    }
    func updateWord(category: Category2, word: Word2) {
        guard let index = userCategories.firstIndex(of: category) else { return }
        guard let wordIndex = userCategories[index].words.firstIndex(of: word) else { return }
        userCategories[index].words[wordIndex].toggleFavorite()
    }
    
    func fetchSavedUserCategories(completion: @escaping (([Category2])) -> Void) {
        
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
            
            DispatchQueue.main.async {
                completion(userCategories)
            }
            
        }
    }
    
}
