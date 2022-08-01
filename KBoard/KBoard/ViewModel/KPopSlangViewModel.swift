//
//  KPopSlangViewModel.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/28.
//

import Foundation
import Combine

final class KPopSlangViewModel {
    
    private let manager = DataManager.shared
    
    var bag = Set<AnyCancellable>()
    
    var changesInUserCategories: ObservableObject<Bool?> = ObservableObject(nil)
    
    var category: ObservableObject<DefaultCategory?> = ObservableObject(nil)
                                    
    init() {
        
//        manager.dictionaryArrayPublisher.sink {
//            self.defaultCategories.value = $0
//        }
//        .store(in: &bag)
        manager.categoryArrayPublisher.sink { _ in
            self.changesInUserCategories.value?.toggle()
        }.store(in: &bag)
        
        manager.dictionaryPublisher.sink {
            self.category.value = $0
        }.store(in: &bag)

    }
    
//    func getWordsAtCategory(_ defaultCategory: DefaultCategory) -> [Word2] {
//        manager.getWordAtCategory(defaultCategory: DefaultCategory)
//    }
    
    func getNumberOfWords() -> Int {
        manager.getNumberOfWordsAtDefaultCategory()
    }
    
    func getWordAtIndex(_ index: Int) -> Word2 {
        
        return manager.getWordAtIndexInDefaultCategory(index)
    }
    
    func switchCategoryAt(_ index: Int) {
        manager.switchCategoryAt(index)
    }
    
    func getNumberOfDefaultCategories() -> Int {
        return DefaultCateogryName.allCases.count
    }
    
    func defaultCategoryStringAt(_ index: Int) -> String {
        DefaultCateogryName.allCases[index].rawValue
    }
//    func clickCategoryAt(_ index: IndexPath) {
//        manager.switchCategoryAt(category: )
//    }
}
