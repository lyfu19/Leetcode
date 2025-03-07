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
    
    func minimumAbsDifference(_ arr: [Int]) -> [[Int]] {
        let sorted = arr.sorted()
        var minimum = Int.max
        var ans = [[Int]]()
        
        for i in 1..<sorted.count {
            if sorted[i] - sorted[i-1] < minimum {
                minimum = sorted[i] - sorted[i-1]
                ans = [[sorted[i-1], sorted[i]]]
            } else if sorted[i] - sorted[i-1] == minimum {
                ans.append([sorted[i-1], sorted[i]])
            }
        }
        
        return ans
    }
    
    func uniqueOccurrences(_ arr: [Int]) -> Bool {
        let counts = arr.reduce(into: [:]) { $0[$1, default: 0] += 1 }.values
        let set = Set(counts)
        return counts.count == set.count
    }
    
    func minCostToMoveChips(_ position: [Int]) -> Int {
        var evenSum = 0
        var oddSum = 0
        
        for index in position {
            if index.isMultiple(of: 2) {
                evenSum += 1
            } else {
                oddSum += 1
            }
        }
        
        return min(evenSum, oddSum)
    }
    
    func balancedStringSplit(_ s: String) -> Int {
        var balance = 0
        var ans = 0
        for char in s {
            if char == "L" {
                balance += 1
            } else {
                balance -= 1
            }
            if balance == 0 {
                ans += 1
            }
        }
        return ans
    }
    
    func checkStraightLine(_ coordinates: [[Int]]) -> Bool {
        let p1 = coordinates[0]
        let p2 = coordinates[1]
        
        for index in 2..<coordinates.count {
            let p = coordinates[index]
            if (p2[1] - p1[1]) * (p[0] - p1[0]) != (p2[0] - p1[0]) * (p[1] - p1[1]) {
                return false
            }
        }
        
        return true
    }
    
    func oddCells(_ m: Int, _ n: Int, _ indices: [[Int]]) -> Int {
        var rowCount = Array(repeating: 0, count: m)
        var columnCount = Array(repeating: 0, count: n)
        
        for index in indices {
            rowCount[index[0]] += 1
            columnCount[index[1]] += 1
        }
        
        let oddRow = rowCount.filter { !$0.isMultiple(of: 2) }.count
        let oddColumn = columnCount.filter { !$0.isMultiple(of: 2) }.count
        
        return oddRow * (n - oddColumn) + oddColumn * (m - oddRow)
    }
    
    func shiftGrid(_ grid: [[Int]], _ k: Int) -> [[Int]] {
        let length = grid[0].count
        let flatted = grid.flatMap { $0 }
        let index = k % flatted.count
        let shifted = Array(flatted[(flatted.count-index)...] + flatted[..<(flatted.count-index)])
        let ans = stride(from: 0, to: shifted.count, by: length).map { i in
            Array(shifted[i..<min(i+length, shifted.count)])
        }
        return ans
    }
    
    func minTimeToVisitAllPoints(_ points: [[Int]]) -> Int {
        var time = 0
        
        for i in 1..<points.count {
            let point = points[i]
            let prePoint = points[i-1]
            
            let width = abs(point[0] - prePoint[0])
            let height = abs(point[1] - prePoint[1])
            time += max(width, height)
        }
        
        return time
    }
    
    func tictactoe(_ moves: [[Int]]) -> String {
        var grid = [[Int]](repeating: [Int](repeating: 0, count: 3), count: 3)
        for (index, move) in moves.enumerated() {
            let row = move[0]
            let column = move[1]
            grid[row][column] = index.isMultiple(of: 2) ? 1 : -1
        }
        
        for i in 0..<3 {
            if abs(grid[i][0] + grid[i][1] + grid[i][2]) == 3 {
                return grid[i][0] == 1 ? "A" : "B"
            }
            if abs(grid[0][i] + grid[1][i] + grid[2][i]) == 3 {
                return grid[0][i] == 1 ? "A" : "B"
            }
        }
        
        if abs(grid[0][0] + grid[1][1] + grid[2][2]) == 3 {
            return grid[1][1] == 1 ? "A" : "B"
        }
        if abs(grid[0][2] + grid[1][1] + grid[2][0]) == 3 {
            return grid[1][1] == 1 ? "A" : "B"
        }
        
        return moves.count == 9 ? "Draw" : "Pending"
    }
    
    func subtractProductAndSum(_ n: Int) -> Int {
        var product = 1
        var sum = 0
        var n = n
        while n > 0 {
            let digit = n % 10
            product *= digit
            sum += digit
            n /= 10
        }
        
        return product - sum
    }
}

let moves = [[0,0],[2,0],[1,1],[2,1],[2,2]]
let result = Solution().tictactoe(moves)
print(result)

