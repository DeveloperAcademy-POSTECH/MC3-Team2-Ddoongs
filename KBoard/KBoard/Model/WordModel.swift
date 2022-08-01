//
//  WordModel.swift
//  KBoard
//
//  Created by ParkJunHyuk on 2022/07/26.
//

import Foundation

struct Word {
    let hangleName: String
    let englishName: String
    let category: [String]
    var isFavorite: Bool
}

extension Word {
    static let words: [Word] = [Word(hangleName: "존잼", englishName: "very fun", category: ["All", "Happy", "Good"], isFavorite: true),
                                Word(hangleName: "오빠", englishName: "brother", category: ["All", "Sad", "Angry"], isFavorite: false),
                                Word(hangleName: "킹받네", englishName: "very angry", category: ["All", "Angry", "Sad"], isFavorite: true),
                                Word(hangleName: "존맛탱(JMT)", englishName: "effing awesome", category: ["All", "Good"], isFavorite: false),
                                Word(hangleName: "안녕", englishName: "hello", category: ["All", "Happy"], isFavorite: true),
                                Word(hangleName: "잘가", englishName: "bye", category: ["All", "Sad"], isFavorite: false),
                                Word(hangleName: "킹받드라슈", englishName: "get King", category: ["All", "Angry"], isFavorite: true),
                                Word(hangleName: "별다줄", englishName: "abc", category: ["All", "Sad"], isFavorite: false),
                                Word(hangleName: "노잼", englishName: "no fun", category: ["All", "Angry"], isFavorite: true)]
}

