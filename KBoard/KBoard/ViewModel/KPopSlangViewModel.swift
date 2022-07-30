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
    
    var defaultCategories: ObservableObject<[DefaultCategory]?> = ObservableObject(nil)
    
    init() {

        manager.dictionaryArrayPublisher.sink {
            self.defaultCategories.value = $0
        }
        .store(in: &bag)
        print(defaultCategories.value)

    }
    
}
