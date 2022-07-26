//
//  WordModel.swift
//  KBoard
//
//  Created by ParkJunHyuk on 2022/07/25.
//

import Foundation

struct Word {
    let hangleName : String
    let englishName : String
    let favorites : Bool
    let category : String
}

extension Word {
    static let words: [Word] = [Word(hangleName: "존잼", englishName: "very fun", favorites: false, category: "All"),
                            Word(hangleName: "오빠", englishName: "brother", favorites: false, category: "Happy"),
                            Word(hangleName: "킹받네", englishName: "very angry", favorites: false, category: "Sad"),
                            Word(hangleName: "존맛탱(JMT)", englishName: "effing awesome", favorites: false, category: "Angry"),
                            Word(hangleName: "존잼", englishName: "very fun", favorites: false, category: "Good"),
                            Word(hangleName: "오빠", englishName: "brother", favorites: false, category: "Angry"),
                            Word(hangleName: "킹받네", englishName: "very angry", favorites: false, category: "Good")]
}
