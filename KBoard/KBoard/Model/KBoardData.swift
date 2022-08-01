////
////  KBoardDate.swift
////  KBoard
////
////  Created by Yu ahyeon on 2022/07/26.
////
//
// import Foundation

struct Category {
    let categoryName: String
    let count: String?
    var kwords: [KWord]?
}
struct KWord: Equatable {

    let name: String
    var isFavorite: Bool
    let isOriginal: Bool
    var description: String?
    var usages: [Usage]?
    var relatedWords: [String]?

    public static func ==(lhs: KWord, rhs: KWord) -> Bool {
        return lhs.name == rhs.name
    }

}
// struct Usage {
//    let korean: String
//    let english: String
// }

//
//  Category.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/20.
//

import Foundation

struct Category2: Equatable {
    var categoryName: String
    var count: Int {
        words.count
    }
    var words: [Word2] = []
    mutating func addWord(_ word: Word2) {
        words.append(word)
    }
    
    mutating func editName(_ name: String) {
        categoryName = name
    }
    
    public static func ==(lhs: Category2, rhs: Category2) -> Bool {
        return lhs.categoryName == rhs.categoryName
    }
}

enum DefaultCateogryName: String, CaseIterable {
    case 행복
    case 기쁨
    
    static var firstCateogryName: Self {
        DefaultCateogryName.allCases[0]
    }
}

struct DefaultCategory {
    
    var categoryName: DefaultCateogryName
    var words: [Word2] = []
    
}

struct Word2: Equatable {
    let name: String
    var isFavorite: Bool
    
    var pronunciation: String?
    var shortDestination: String?
    var userCateogry: String?
    var defaultCategory: DefaultCateogryName?

    var description: String?
    var usages: [Usage]?
    var relatedWords: [String]?
    
    public static func ==(lhs: Word2, rhs: Word2) -> Bool {
        return lhs.name == rhs.name
    }
    
    mutating func toggleFavorite() {
        isFavorite.toggle()
    }
    
    mutating func applyUserCategory(cateogry: String) {
        userCateogry = cateogry
    }
    
}
struct Usage {
    let korean: String
    let english: String
}
