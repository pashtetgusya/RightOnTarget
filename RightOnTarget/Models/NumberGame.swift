//
//  Game.swift
//  RightOnTarget
//
//  Created by Pavel Yarovoi on 26.10.2021.
//

import Foundation


protocol GameProtocol {
    var score: Int { get }
    var currentRound: GameRoundProtocol! { get }
    var isGameEnded: Bool { get }
    var hiddenValueGenerator: NuberGeneratorProtocol { get }
    func restartGame()
    func startNewRound()
}

class Game: GameProtocol {
    var score: Int {
        var totalScore: Int = 0
        for round in self.rounds {
            totalScore += round.score
        }
        return totalScore
    }
    var hiddenValueGenerator: NuberGeneratorProtocol
    private var roundsCount: Int!
    var currentRound: GameRoundProtocol!
    var rounds: [GameRoundProtocol] = []
    var isGameEnded: Bool {
        if roundsCount == rounds.count {
            return true
        } else {
            return false
        }
    }
    
    init(valueGenerator: NuberGeneratorProtocol, rounds: Int) {
        hiddenValueGenerator = valueGenerator
        roundsCount = rounds
        startNewRound()
    }
    
    func startNewRound() {
        let newHiddenValue = self.getNewHiddenValue()
        currentRound = GameRound(hiddenValue: newHiddenValue)
        rounds.append(currentRound)
    }
    
    func restartGame() {
        rounds = []
        startNewRound()
    }
    
    private func getNewHiddenValue() -> Int {
        return hiddenValueGenerator.getRandomValue()
    }
}
