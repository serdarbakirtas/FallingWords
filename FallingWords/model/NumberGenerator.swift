//
//  NumberGenerator.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//

struct NumberGenerator: RandomNumberGenerator {
    let random: () -> UInt64

    func next() -> UInt64 {
        random()
    }
}
