//
//  File.swift
//  RightOnTarget
//
//  Created by Pavel Yarovoi on 27.10.2021.
//

import Foundation
import UIKit


protocol ColorGameProtocol {
    var score: Int { get }
    var currentHiddenColor: String { get }
    var isGameEnded: Bool { get }
    
    func restartGame()
    func startNewRound()
    func calculateScore(with value: UIColor)
}

class ColorGame: ColorGameProtocol {
    var score: Int = 0
    var currentHiddenColor: String = "#000000"
    private var lastRount: Int
    private var currentRound: Int = 1
    var isGameEnded: Bool {
        if currentRound == lastRount {
            return true
        } else {
            return false
        }
    }
    
    init?(round: Int) {
        lastRount = round
        currentHiddenColor = self.getRandomColor()
    }
    
    private func getNewHiddenValue() -> String {
        return ""
    }
    
    func startNewRound() {
        currentHiddenColor = self.getRandomColor()
        currentRound += 1
    }
    
    func restartGame() {
        currentRound = 0
        score = 0
        startNewRound()
    }
    
    func calculateScore(with value: UIColor) {
        if value == UIColor(hex: currentHiddenColor) {
            score += 50
        }
    }
    
    func getRandomColor() -> String {
        let hexCharracters = ["1","2","3","4","5","6","7","8","9","a", "b", "c", "d", "e", "f"]
        var hexString = "#"
        for _ in Range(1...8) {
            hexString = hexString.appending(hexCharracters[Int(arc4random_uniform(15))])
            
        }
        return hexString
    }
    
}
