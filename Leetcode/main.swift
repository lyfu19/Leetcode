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
}

let result = Solution().numPrimeArrangements(100)
print(result)

