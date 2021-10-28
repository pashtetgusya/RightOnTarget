//
//  Game.swift
//  RightOnTarget
//
//  Created by Pavel Yarovoi on 26.10.2021.
//

import Foundation


protocol GameProtocol {
    associatedtype ValueType: Comparable
    var score: Int { get }
    var currentRound: GameRound<ValueType> { get }
    var hiddenValueGenerator: ValueGenerator<ValueType> { get }
    var isGameEnded: Bool { get }
    
    func restartGame()
    func startNewRound()
}

class Game<ValueType: Comparable>: GameProtocol {
    
    var score: Int = 0
    var hiddenValueGenerator: ValueGenerator<ValueType>
    private var roundsCount: Int
    var currentRound: GameRound<ValueType>
    var rounds: [GameRound<ValueType>] = []
    var isGameEnded: Bool {
        if roundsCount == rounds.count {
            return true
        } else {
            return false
        }
    }
    
    init?(valueGenerator: ValueGenerator<ValueType>, gameRound: GameRound<ValueType>,rounds: Int) {
        hiddenValueGenerator = valueGenerator
        currentRound = gameRound
        roundsCount = rounds
        startNewRound()
    }
    
    func startNewRound() {
        currentRound.currentHiddenValue = hiddenValueGenerator.getRandomValue()
        rounds.append(currentRound)
        score += currentRound.score
    }
    
    func restartGame() {
        score = 0
        rounds = []
        startNewRound()
    }
}
