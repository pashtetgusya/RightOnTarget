//
//  GeneratorModel.swift
//  RightOnTarget
//
//  Created by Pavel Yarovoi on 27.10.2021.
//

import Foundation


protocol NuberGeneratorProtocol {
    func getRandomValue() -> Int
}


class NumberGenerator: NuberGeneratorProtocol {
    private let startRangeValue: Int
    private let endRangeValue: Int
    
    init?(startValue: Int, endValue: Int) {
        guard startValue <= endValue else {
            return nil
        }
        startRangeValue = startValue
        endRangeValue = endValue
    }
    
    func getRandomValue() -> Int {
        (startRangeValue...endRangeValue).randomElement()!
    }
}


protocol ValueGeneratorProtocol {
    associatedtype ValueType
    func getRandomValue() -> ValueType
}

class ValueGenerator<ValueType: Comparable>: ValueGeneratorProtocol {
    private var startRangeValue: Int = 0
    private var endRangeValue: Int = 0
    private let hexCharracters = ["1","2","3","4","5","6","7","8","9","a", "b", "c", "d", "e", "f"]
    private var randomValue: ValueType
    
    init?(startValue: Int, endValue: Int) {
        guard startValue <= endValue else {
            return nil
        }
        startRangeValue = startValue
        endRangeValue = endValue
        randomValue = Int() as! ValueType
    }
    
    init() {
        randomValue = String() as! ValueType
    }
    
    func getRandomValue() -> ValueType {
        if let _ = randomValue as? Int {
            randomValue = (startRangeValue...endRangeValue).randomElement() as! ValueType
        } else if let _ = randomValue as? String {
            var hexString = "#"
            for _ in Range(1...8) {
                hexString = hexString.appending(hexCharracters[Int(arc4random_uniform(15))])
            }
            randomValue = hexString as! ValueType
        }
        return randomValue
    }
}
