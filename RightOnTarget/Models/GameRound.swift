//
//  GameRoundModel.swift
//  RightOnTarget
//
//  Created by Pavel Yarovoi on 27.10.2021.
//

import Foundation


protocol GameRoundProtocol {
    associatedtype ValueType
    var score: Int { get }
    var currentHiddenValue: ValueType { get }
    
    func calculateScore(with value: ValueType)
}


class GameRound<ValueType: Comparable>: GameRoundProtocol {
    var score: Int = 0
    var currentHiddenValue: ValueType
    
    init(hiddenValue: ValueGenerator<ValueType>) {
        currentHiddenValue = hiddenValue.getRandomValue()
    }
    
    func calculateScore(with value: ValueType) {
        if let selectedValue = value as? Int {
            if let currentHiddenValue = currentHiddenValue as? Int {
                if selectedValue > currentHiddenValue {
                    score = 50 - selectedValue + currentHiddenValue
                } else if selectedValue < currentHiddenValue {
                    score = 50 - currentHiddenValue + selectedValue
                } else {
                    score = 50
                }
            }
        } else if let selectedValue = value as? String {
            if let currentHiddenValue = currentHiddenValue as? String {
                print(currentHiddenValue, selectedValue)
                if currentHiddenValue == selectedValue {
                    print("123")
                    score = 50
                } else {
                    score = 0
                }
            }
        }
    }
}
