//
//  WordViewModel.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/30.
//

import Combine

// 여기에 오른쪽탭에서 단어 카테고리 수정할때 필요한 것들 추가 예를들어 userCategory는 뭐가있는지 등

final class WordViewModel {
    
//    var usages: [Usage]?
//    // 굳이 Word로 하지 않는다.
//    var relatedWords: [String]?
    // 안쓴다?
    // TODO: toggle로 바꿀 생각하자.
    var categories: ObservableObject<[Category2]?> = ObservableObject(nil)// 얘는 변하면 울리는데 여러곳에서 부르면 변하지 않으므로 아래처럼 토글로 하면된다
    var changesInUserCategories: ObservableObject<Bool?> = ObservableObject(nil)
    
    var word2: ObservableObject<Word2?> = ObservableObject(nil)
    
    private let manager = DataManager.shared

    var bag = Set<AnyCancellable>()
    
//    var word: Word2
    
    init(word: Word2) {
        
//        self.word = word
        
        manager.wordPublisher.sink { _ in
            self.word2.value = self.manager.wordPublisher.value
        }.store(in: &bag)
//        manager.initCategory(category: category)
        manager.initWord(word: word)
        
        manager.categoryArrayPublisher.sink {
            self.categories.value = $0
            print("categoryArrayPublisher 변화")
//            self.word = self.manager.word
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
