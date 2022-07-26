//
//  KBoardDate.swift
//  KBoard
//
//  Created by Yu ahyeon on 2022/07/26.
//

import Foundation

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
struct Usage {
    let korean: String
    let english: String
}
