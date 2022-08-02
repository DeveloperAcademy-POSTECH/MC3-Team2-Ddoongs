//
//  keyboardViewModel.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/08/02.
//

import Foundation
import Combine

final class KeyboardViewModel {

    private let manager = DataManager.shared
    var bag = Set<AnyCancellable>()
    var categories: ObservableObject<[Category2]?> = ObservableObject(nil)

    init() {
        manager.fetchSavedUserCategories2()
        manager.categoryArrayPublisher.sink {
            self.categories.value = $0
        }.store(in: &bag)
    }
}
