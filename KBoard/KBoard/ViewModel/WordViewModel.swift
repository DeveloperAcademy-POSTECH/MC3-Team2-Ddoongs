//
//  WordViewModel.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/30.
//

import Combine

final class WordViewModel {

    // TODO: toggle로 바꿀 생각하자.
    var categories: ObservableObject<[Category2]?> = ObservableObject(nil)
    var changesInUserCategories: ObservableObject<Bool?> = ObservableObject(nil)
    
    var word2: ObservableObject<Word2?> = ObservableObject(nil)
    
    private let manager = DataManager.shared

    var bag = Set<AnyCancellable>()

    init(word: Word2) {
        manager.wordPublisher.sink { _ in
            self.word2.value = self.manager.wordPublisher.value
        }.store(in: &bag)
        manager.initWord(word: word)
        
        manager.categoryArrayPublisher.sink {
            self.categories.value = $0
            self.changesInUserCategories.value?.toggle()
        }
        .store(in: &bag)
    }
    
    var wordName: String {
        manager.wordName
    }
    var wordEnglishName: String? {
        manager.pronunciation
    }
    var isFavorite: Bool {
        manager.isFavorite
    }
    var pronunciation: String? {
        manager.pronunciation
    }
    var shortDestination: String? {
        manager.shortDestination
    }
    var userCategory: String? {
        manager.userCategory
    }
    var description: String? {
        manager.description
    }
    var usages: [Usage]? {
        manager.usages
    }
    var relatedWords: [String]? {
        manager.relatedWords
    }
    
    var numOfuserCategories: Int {
        manager.numOfCategories
    }
    
    var userCategories: [Category2] {
        manager.getCategories()
    }
    
    func userCategoryNameAt(_ index: Int) -> String {
        manager.getCategoryAt(index).categoryName
    }
    
    func switchUserCategory(category: String) {
        manager.selectFavoriteCategory(word: manager.getWord(), userCategory: category)
        
    }
    
    func getCategoryIndex() -> Int? {
        return manager.getCategoryIndexWithCategoryName(categoryName: manager.getWord().userCateogry)
    }
    
}
