//
//  GameRoundModel.swift
//  RightOnTarget
//
//  Created by Pavel Yarovoi on 27.10.2021.
//

import Foundation


protocol GameRoundProtocol {
    var score: Int { get }
    var currentHiddenValue: Int { get }
    
    func calculateScore(with value: Int)
}


class GameRound: GameRoundProtocol {
    var score: Int = 0
    var currentHiddenValue: Int = 0
    
    init(hiddenValue: Int) {
        currentHiddenValue = hiddenValue
    }
    
    func calculateScore(with value: Int) {
        if value > currentHiddenValue {
            score += 50 - value + currentHiddenValue
        } else if value < currentHiddenValue {
            score += 50 - currentHiddenValue + value
        } else {
            score += 50
        }
    }
}
