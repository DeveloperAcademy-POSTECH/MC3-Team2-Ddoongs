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

enum DefaultCateogryName: String {
    case 행복
    case 기쁨
}
struct DefaultCategory {
    
    let categoryName: DefaultCateogryName
    
    var words: [Word2] = []
    
}

// TODO: 자기자신을 향하는 struct? String?
struct Word2: Equatable {
    let name: String
    var isFavorite: Bool
    
    var pronunciation: String?
    var shortDestination: String?
    var userCateogry: String?
    var defaultCategory: DefaultCateogryName?
    
    let isOriginal: Bool?
    // TODO: String 메모리
    var description: String?// 없을 수 도 있다.
    var usages: [Usage]?
    // 굳이 Word로 하지 않는다.
    var relatedWords: [String]?
    
//    init(name: String, isFavorite: Bool, isOriginal: Bool, description: String? = "", usages: [Usage]? = nil, relatedWords: [String]? = nil) {
//        self.name = name
//        self.isFavorite = isFavorite
//        self.isOriginal = isOriginal
//        self.description = description
//        self.usages = usages
//    }
    
    public static func ==(lhs: Word2, rhs: Word2) -> Bool {
        return lhs.name == rhs.name
    }
    
    // TODO: mutating 자제?
    mutating func toggleFavorite() {
        isFavorite.toggle()
    }
    
}
struct Usage {
    let korean: String
    let english: String
}
