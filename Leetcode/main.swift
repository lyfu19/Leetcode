//
//  main.swift
//  Leetcode
//
//  Created by 阿福 on 22/02/2025.
//

import Foundation

class Solution {
    func numPrimeArrangements(_ n: Int) -> Int {
        let MOD = 1_000_000_007
        
        func factorial(_ n: Int) -> Int {
            guard n > 1 else {
                return 1
            }
            return (n * factorial(n - 1)) % MOD
        }
        
        let primeNumbers: Set<Int> = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29,
                                 31, 37, 41, 43, 47, 53, 59, 61, 67,
                                 71, 73, 79, 83, 89, 97]
        var count = 0
        var indexPrimes = Array(repeating: 0, count: 101)
        for i in indexPrimes.indices {
            if primeNumbers.contains(i) {
                count += 1
            }
            indexPrimes[i] = count
        }
        
        let primes = indexPrimes[n]
        let unprimes = n - primes
        
        let count1 = factorial(primes)
        let count2 = factorial(unprimes)
        
        let ans = (count1 * count2) % MOD
        
        return ans
    }
    
    func distanceBetweenBusStops(_ distance: [Int], _ start: Int, _ destination: Int) -> Int {
        let left = min(start, destination)
        let right = max(start, destination)
        
        let total = distance.reduce(into: 0) { $0 += $1 }
        let clockwise = distance[left..<right].reduce(into: 0) { $0 += $1 }
        let counterclockwise = total - clockwise
        
        return min(clockwise, counterclockwise)
    }
    
    func dayOfTheWeek(_ day: Int, _ month: Int, _ year: Int) -> String {
        var m = month
        var y = year
        if m < 3 {
            m += 12
            y -= 1
        }
        
        let K = y % 100   // Last two digits of the year
        let J = y / 100   // First two digits of the year
        
        // Apply Zeller's Congruence formula
        let h = (day + (13 * (m + 1)) / 5 + K + (K / 4) + (J / 4) - 2 * J) % 7
        
        let daysOfWeek = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        return daysOfWeek[(h + 7) % 7]
    }
    
    func maxNumberOfBalloons(_ text: String) -> Int {
        let charCount = text.reduce(into: [Character : Int]()) { partialResult, char in
            partialResult[char, default: 0] += 1
        }
        
        let required: [Character : Int] = [
            "b": 1,
            "a": 1,
            "l": 2,
            "o": 2,
            "n": 1,
        ]
        
        var ans = Int.max
        for (key, value) in required {
            let count = charCount[key, default: 0]
            ans = min(ans, count / value)
        }
        
        return ans
    }
}

let text = "loonbalxballpoon"
let result = Solution().maxNumberOfBalloons(text)
print(result)

