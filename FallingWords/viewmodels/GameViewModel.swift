//
//  GameViewModel.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//

import Foundation

struct GameViewModel {
    
    var engName: String?
    var spaName: String?
    var isTranslation: Bool?
    
    init(from items: GameData) {
        engName = getEnglishName(items: items)
        spaName = getSpanishName(items: items)
        isTranslation = isTranslation(items: items)
    }
    
    // MARK: FUNCTIONS
    func getEnglishName(items: GameData) -> String {
        return items.question
    }
    
    func getSpanishName(items: GameData) -> String {
        return items.answer
    }
    
    func isTranslation(items: GameData) -> Bool {
        return items.isTranslation
    }
}
