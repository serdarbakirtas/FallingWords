//
//  GameAPIRepo.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//

import Foundation

class GameAPIRepo: GameAPI {
    
    // SINGLETON
    static let sharedInstance = GameAPIRepo()
    
    private init() {}
}
