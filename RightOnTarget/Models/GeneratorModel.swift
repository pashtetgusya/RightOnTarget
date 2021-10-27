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
