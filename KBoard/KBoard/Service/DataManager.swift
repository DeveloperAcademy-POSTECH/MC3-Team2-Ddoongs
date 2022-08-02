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
    
    var categoryArrayPublisher: CurrentValueSubject<[Category2], Never> = CurrentValueSubject([])
    var categoryPublisher: CurrentValueSubject<Category2, Never> = CurrentValueSubject(Category2(categoryName: ""))
    var dictionaryArray: [DefaultCategory] = []
    var dictionaryPublisher: CurrentValueSubject<DefaultCategory, Never> = CurrentValueSubject(DefaultCategory(categoryName: DefaultCateogryName.firstCateogryName))
    var wordPublisher: CurrentValueSubject<Word2, Never> = CurrentValueSubject(Word2(name: "", isFavorite: false))
    
    private init() { }
    
    func getCategories() -> [Category2] {
        return categoryArrayPublisher.value
    }
    
    var numOfCategories: Int {
        return categoryArrayPublisher.value.count
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
        
        let numOfWords = categoryArrayPublisher.value[categoryIndex].words.count
        
        for i in 0 ..< numOfWords {
            categoryArrayPublisher.value[categoryIndex].words[i].applyUserCategory(cateogry: newName)
            if wordPublisher.value.name == categoryArrayPublisher.value[categoryIndex].words[i].name {
                wordPublisher.value = categoryArrayPublisher.value[categoryIndex].words[i]
            }
            
        }
        
        for i in 0..<dictionaryArray.count {
            for j in 0..<dictionaryArray[i].words.count {
                if dictionaryArray[i].words[j].userCateogry == category.categoryName {
                    dictionaryArray[i].words[j].applyUserCategory(cateogry: newName)
                }
            }
        }
        
        guard let dictIndex = dictionaryArray.map {$0.categoryName}.firstIndex(of: dictionaryPublisher.value.categoryName) else { return }
        dictionaryPublisher.value = dictionaryArray[dictIndex]
    }
    
    func swapCategoryOrder(from sourceIndex: Int, to destinationIndex: Int) {
        categoryArrayPublisher.value.swapAt(sourceIndex, destinationIndex)
    }
    
    func removeCategoryAt(_ index: Int) {
        let numOfWords = categoryArrayPublisher.value[index].words.count
        for i in 0..<dictionaryArray.count {
            for j in 0..<dictionaryArray[i].words.count {
                if dictionaryArray[i].words[j].userCateogry == categoryArrayPublisher.value[index].categoryName {
                    dictionaryArray[i].words[j].applyUserCategory(cateogry: "")
                }
                if dictionaryArray[i].words[j].name == wordPublisher.value.name {
                    wordPublisher.value = dictionaryArray[i].words[j]
                }
            }
        }
        categoryArrayPublisher.value.remove(at: index)
        guard let dictIndex = dictionaryArray.map {$0.categoryName}.firstIndex(of: dictionaryPublisher.value.categoryName) else { return }
        dictionaryPublisher.value = dictionaryArray[dictIndex]
    }

    func fetchSavedUserCategories2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            let word1 = Word2(name: "바티짱1", isFavorite: true, userCateogry: "BTS", defaultCategory: .행복, description: "바티바티", relatedWords: ["바티짱2", "바티짱3"])
            let word2 = Word2(name: "바티짱2", isFavorite: false, userCateogry: "BTS", defaultCategory: .행복, description: "짱", relatedWords: ["바티짱1", "바티짱3"])
            let word3 = Word2(name: "바티짱3", isFavorite: true, userCateogry: "BTS", defaultCategory: .기쁨, description: "ㅋㅋㅋㅋ", usages: [Usage(korean: "지난 주 뮤직쇼 봤어?", english: "music show you see?"), Usage(korean: "지난 치티치티치티?", english: "티clclslsl?")], relatedWords: ["바티짱1", "바티짱2"])
            
            let word4 = Word2(name: "아오나1", isFavorite: true, userCateogry: "소녀시대", defaultCategory: .행복)
            let word5 = Word2(name: "zz", isFavorite: false, userCateogry: "소녀시대", defaultCategory: .기쁨, description: "zzzz")
            
            let word6 = Word2(name: "gg1", isFavorite: false, userCateogry: "아니이", defaultCategory: .행복, description: "zz")
            
            let userCategories: [Category2] = [Category2(categoryName: "BTS", words: [word1, word2, word3]), Category2(categoryName: "소녀시대", words: [word4, word5]), Category2(categoryName: "아니이", words: [word6])]
            
            let defaultCategories: [DefaultCategory] = [DefaultCategory(categoryName: .행복, words: [word1, word2, word4, word6]), DefaultCategory(categoryName: .기쁨, words: [word3, word5])]
            
            // TODO: background에서 받으려나? 확인
            DispatchQueue.main.async {
                self?.categoryArrayPublisher.value = userCategories
                self?.dictionaryArray = defaultCategories
                self?.dictionaryPublisher.value = self?.dictionaryArray.filter { $0.categoryName == .firstCateogryName}[0] ?? DefaultCategory(categoryName: .firstCateogryName)
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
    
    func getWordNameAtIndex(index: Int) -> Word2 {
        return categoryPublisher.value.words[index]
    }
    
    func getCategoryIndexWithCategoryName(categoryName: String?) -> Int? {
        guard let categoryIndex = categoryArrayPublisher.value.firstIndex(where: {$0.categoryName == categoryName}) else { return nil }
        return categoryIndex
    }
    
    func swapWordOrder(category: Category2, from sourceIndex: Int, to destinationIndex: Int) {
        guard let categoryIndex = categoryArrayPublisher.value.firstIndex(of: category) else { return }
        categoryArrayPublisher.value[categoryIndex].words.swapAt(sourceIndex, destinationIndex)
        categoryPublisher.value.words = categoryArrayPublisher.value[categoryIndex].words
    }
    
    func addWord(categoryName: String, wordName: String, description: String) {
        let newWord = Word2(name: wordName, isFavorite: true, userCateogry: categoryName, description: description)
        guard let index = categoryArrayPublisher.value.firstIndex(where: { $0.categoryName == categoryName }) else { return }
        categoryArrayPublisher.value[index].addWord(newWord)
        categoryPublisher.value = categoryArrayPublisher.value[index]
    }
    
    func removeWordAt(category: Category2, index: Int) {
        guard let index = categoryArrayPublisher.value.firstIndex(of: category) else { return }
        categoryArrayPublisher.value[index].words.remove(at: index)
        categoryPublisher.value.words = categoryArrayPublisher.value[index].words
    }
    
    func getNumberOfWordsAtDefaultCategory() -> Int {
        dictionaryPublisher.value.words.count
    }
    
    func getWordAtIndexInDefaultCategory(_ index: Int) -> Word2 {
        return dictionaryPublisher.value.words[index]
    }
    
    func switchCategoryAt(_ index: Int) {
        guard let defualtCategory = dictionaryArray.filter({ $0.categoryName == DefaultCateogryName.allCases[index] }).first else { return }
        dictionaryPublisher.value = defualtCategory
    }
    
    func getDefaultCategoryName() -> DefaultCateogryName {
        dictionaryPublisher.value.categoryName
    }
    
    func initWord(word: Word2) {
        wordPublisher.value = word
    }
    func getWord() -> Word2 {
        return wordPublisher.value
    }
    var wordName: String {
        wordPublisher.value.name
    }
    var wordEnglishName: String? {
        wordPublisher.value.pronunciation
    }
    var isFavorite: Bool {
        wordPublisher.value.isFavorite
    }
    var pronunciation: String? {
        wordPublisher.value.pronunciation
    }
    var shortDestination: String? {
        wordPublisher.value.shortDestination
    }
    var userCategory: String? {
        wordPublisher.value.userCateogry
    }
    var description: String? {
        wordPublisher.value.description
    }
    var usages: [Usage]? {
        wordPublisher.value.usages
    }
    var relatedWords: [String]? {
        wordPublisher.value.relatedWords
    }
    // 모델이 클래스 아니어서 일일히 해야한다.?
    func selectFavoriteCategory(word: Word2, userCategory: String) {
        // dictionary 변경
        guard let index = dictionaryArray.firstIndex(where: {$0.categoryName == word.defaultCategory}) else { return }
        guard let wordIndex = dictionaryArray[index].words.firstIndex(of: word) else { return }
        
        dictionaryArray[index].words[wordIndex].applyUserCategory(cateogry: userCategory)
        if dictionaryPublisher.value.categoryName == dictionaryArray[index].categoryName {
            dictionaryPublisher.value = dictionaryArray[index]
        }
        // 이전 단어가 빈 거 일때
        if word.userCateogry == "" {
            guard let changedPublisherIndex = categoryArrayPublisher.value.firstIndex(where: {$0.categoryName == userCategory}) else { return}
            var newWord = word
            newWord.applyUserCategory(cateogry: userCategory)
            categoryArrayPublisher.value[changedPublisherIndex].words.append(newWord)
            wordPublisher.value = newWord
            if categoryPublisher.value.categoryName == newWord.userCateogry {
                categoryPublisher.value = categoryArrayPublisher.value[changedPublisherIndex]
            }
        }
        // 카테고리 바꾸기
        guard let categoryIndex = categoryArrayPublisher.value.firstIndex(where: { a in
            print(a.categoryName)
            print(word.userCateogry)
            return a.categoryName == word.userCateogry
            
        }) else { return }
        guard let wordIndex = categoryArrayPublisher.value[categoryIndex].words.firstIndex(of: word) else { return }
//
        var changedWord = categoryArrayPublisher.value[categoryIndex].words.remove(at: wordIndex)
//        changedWord.toggleFavorite() //TODO
        changedWord.applyUserCategory(cateogry: userCategory)
        if categoryPublisher.value.categoryName == word.userCateogry {
            categoryPublisher.value = categoryArrayPublisher.value[categoryIndex]
        }
        if userCategory == "" {
            wordPublisher.value = changedWord
        }
        // 새로운 카테고리와 같은곳을 찾는다.
        guard let changedPublisherIndex = categoryArrayPublisher.value.firstIndex(where: {$0.categoryName == userCategory}) else { return}
        categoryArrayPublisher.value[changedPublisherIndex].words.append(changedWord)
        wordPublisher.value = changedWord
        if categoryPublisher.value.categoryName == word.userCateogry {
            categoryPublisher.value = categoryArrayPublisher.value[categoryIndex]
        } else if categoryPublisher.value.categoryName == userCategory {
            categoryPublisher.value = categoryArrayPublisher.value[changedPublisherIndex]
        }
        
    }
    
}
