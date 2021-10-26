//
//  Game.swift
//  RightOnTarget
//
//  Created by Pavel Yarovoi on 26.10.2021.
//

import Foundation


protocol GameProtocol {
    var score: Int { get }
    var currentHiddenValue: Int { get }
    var isGameEnded: Bool { get }
    
    func restartGame()
    func startNewRound()
    func calculateScore(with value: Int)
}

class Game: GameProtocol {
    var score: Int = 0
    private var minHiddenValue: Int = 0
    private var maxHiddenValue: Int = 0
    var currentHiddenValue: Int = 0
    private var lastRount: Int
    private var currentRound: Int = 1
    var isGameEnded: Bool {
        if currentRound == lastRount {
            return true
        } else {
            return false
        }
    }
    
    init?(startValue: Int, endValue: Int, round: Int) {
        guard startValue <= endValue else {
            return nil
        }
        minHiddenValue = startValue
        maxHiddenValue = endValue
        lastRount = round
        currentHiddenValue = self.getNewHiddenValue()
    }
    private func getNewHiddenValue() -> Int {
        (minHiddenValue...maxHiddenValue).randomElement()!
    }

    func startNewRound() {
        currentHiddenValue = self.getNewHiddenValue()
        currentRound += 1
    }
    func restartGame() {
        currentRound = 0
        score = 0
        startNewRound()
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
