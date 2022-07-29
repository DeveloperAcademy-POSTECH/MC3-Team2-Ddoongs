//
//  KPopSlangViewModel.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/28.
//

import Foundation
final class KPopSlangViewModel {
    private let manager = DataManager.shared
    
    var words: ObservableObject<[Word]?> = ObservableObject(nil)
    
}
