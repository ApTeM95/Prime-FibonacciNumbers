//
//  NumbersPair.swift
//  Prime&Fibonacci Numbers
//
//  Created by Артем on 13.07.2021.
//

import Foundation

struct NumbersPair {
    var leftNumber: Int = -1
    var rightNumber: Int = -1
    
    mutating func apendNumber(_ number: Int) {
        if leftNumber == -1 {
            leftNumber = number
            return
        }
        if rightNumber == -1 {
            rightNumber = number
            return
        }
    }
    
    mutating func clearPair() {
        rightNumber = -1
        leftNumber = -1
    }
    
    func isPairFilled() -> Bool {
        return leftNumber != -1 && rightNumber != -1
    }
}
