//
//  WordList.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//

struct WordList: Decodable, Equatable {
    var eng: String
    var spa: String
    
    private enum CodingKeys: String, CodingKey {
        case eng = "text_eng"
        case spa = "text_spa"
    }
}

struct GameData {
    var question: String
    var answer: String
    var isTranslation: Bool
}

struct Answers {
    var isCorrect: Bool
}
