//
//  NumberGenerator.swift
//  Prime&Fibonacci Numbers
//
//  Created by Артем on 11.07.2021.
//

import Foundation

enum NumberType: Int {
    case prime
    case fibonacci
}

final class NumberGenerator {
    
    private(set) var numberDataSource = [NumbersPair]()
    private var currentType: NumberType
    private var currentQuantity: Int
    private var isGenerateNow = false
    private var currentWorkItem: DispatchWorkItem?
    private var needRemoveData = false
    
    init(_ type: NumberType, _ quantity: Int) {
        currentType = type
        currentQuantity = quantity
    }
    
    func changeType(_ type: NumberType) {
        guard currentType != type else {
            return
        }
        currentWorkItem?.cancel()
        currentType = type
        numberDataSource.removeAll()
    }
    
    func changeQuatity(_ quantity: Int) {
        guard currentQuantity != quantity else {
            return
        }
        currentQuantity = quantity
    }
    
    func generateFirstNumbers(_ completion: @escaping (_ success: Bool) -> Void) {
        needRemoveData = true
        generateNextNumbers(completion)
    }
    
    func generateNextNumbers(_ completion: @escaping (_ success: Bool) -> Void) {
        guard !isGenerateNow else {
            completion(false)
            return
        }
        switch currentType {
        case .fibonacci:
            generateFibonacciNumbers(quantity: currentQuantity, completion)
        case .prime:
            generatePrimeNumbers(quantity: currentQuantity, completion)
        }
    }
}

// MARK: - generating metods

private extension NumberGenerator {
    func generateFibonacciNumbers(quantity: Int, _ completion: @escaping (_ success: Bool) -> Void) {
        if needRemoveData {
            numberDataSource.removeAll()
            needRemoveData = false
        }
        print("start generate fibonacci")
        isGenerateNow = true
        let workItem = DispatchWorkItem(block: {
            var numbersPair = NumbersPair()
            for _ in 0 ..< quantity * 2 {
                let offset = numbersPair.leftNumber == -1 ? 0 : 1
                let number = self.numberDataSource.count * 2 + offset
                let fibNumber = self.fibonacci(number)
                if fibNumber == -1 {
                    break
                }
                numbersPair.apendNumber(fibNumber)
                if numbersPair.isPairFilled() {
                    print("generate pair of fibonacci\(numbersPair)")
                    self.numberDataSource.append(numbersPair)
                    numbersPair.clearPair()
                }
            }

            DispatchQueue.main.async {
                self.isGenerateNow = false
                print("finish generate fibonacci")
                completion(true)
            }
        })
        DispatchQueue.global(qos: .userInitiated).async(execute: workItem)
        currentWorkItem = workItem
    }
    
    func generatePrimeNumbers(quantity: Int, _ completion: @escaping (_ success: Bool) -> Void) {
        if needRemoveData {
            numberDataSource.removeAll()
            needRemoveData = false
        }
        print("start generate prime")
        let finalCount = self.numberDataSource.count + quantity
        isGenerateNow = true
        var j = numberDataSource.last?.rightNumber ?? 0
        let workItem = DispatchWorkItem(block: {
            var numbersPair = NumbersPair()
            while self.numberDataSource.count != finalCount {
                if !self.isGenerateNow {
                    break
                }
                if self.isPrime(number: j) {
                    numbersPair.apendNumber(j)
                    if numbersPair.isPairFilled() {
                        print("generate pair of prime\(numbersPair)")
                        self.numberDataSource.append(numbersPair)
                        numbersPair.clearPair()
                    }
                }
                j += 1
            }
            DispatchQueue.main.async {
                self.isGenerateNow = false
                print("finish generate prime")
                completion(true)
            }
        })
        DispatchQueue.global(qos: .userInitiated).async(execute: workItem)
        currentWorkItem = workItem
    }
    

}

// MARK: - algorithms

private extension NumberGenerator {
    func fibonacci(_ i: Int) -> Int {
        if i == 0 {
            return 0
        }
        if i <= 2 {
            return 1
        } else {
            guard let isCancel = currentWorkItem?.isCancelled, !isCancel else {
                return -1
            }
            return fibonacci(i - 1) + fibonacci(i - 2)
        }
    }
    
    func isPrime(number: Int) -> Bool {
        switch number {
        case 0, 1: // you can put multiple cases on one line
            return false
        case 2, 3:
            return true
        default:
            for i in 2...Int(sqrt(Double(number))) {
                if number % i == 0 {
                    return false
                }
            }
            return true
        }
    }
}
