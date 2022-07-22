//
//  KBoardDate.swift
//  KBoard
//
//  Created by Yu ahyeon on 2022/07/22.
//

import Foundation

struct Category {
    let categoryName: String
    let count: String
    var words: [Word]
}
struct Word: Equatable {
    
    let name: String
    var isFavorite: Bool
    let isOriginal: Bool
    var description: String?
    var usages: [Usage]?
    var relatedWords: [String]?

    public static func ==(lhs: Word, rhs: Word) -> Bool {
        return lhs.name == rhs.name
    }

}
struct Usage {
    let korean: String
    let english: String
}
