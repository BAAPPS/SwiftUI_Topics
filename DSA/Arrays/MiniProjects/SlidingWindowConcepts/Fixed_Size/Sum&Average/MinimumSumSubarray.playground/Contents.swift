//
//  Sliding Window – Group 3: Minimum Sum Subarray Variations
//  ----------------------------------------------------------
//
//  Concept Focus:
//  Learn how to efficiently find the **minimum sum** (or smallest total)
//  among all contiguous subarrays of a fixed size `k`.
//
//  Key Idea:
//  Similar to finding a maximum sum subarray — but instead of tracking the
//  highest total, we continuously update and compare to find the *lowest*.
//  Use a running sum and slide the window forward one element at a time.
//  Pro Tip:
//  - Initialize `minSum` to a large value (like `Int.max`).
//  - Use a running sum to avoid re-summing every window (O(n) time).
//  - Double-check boundary conditions when sliding the window.
//

import Cocoa

// MARK: Print Statements Helper

enum MethodType: String {
    case bruteForce = "💡 BRUTE FORCE"
    case slidingWindow = "⚡️ SLIDING WINDOW"
}

func methodLabel(problem: String,  method: MethodType)  {
    return print("\(problem) \(method.rawValue)")
}

func stepsForIntArraysWithMinSum<T: Collection>(window: T, sum: Int, minSum: Int) where T.Element == Int {
    print("Current window: \(window), Current sum: \(sum), Current min sum: \(minSum)")
}

// MARK: - Minimum Sum Subarray of Size K

// MARK: Brute FORCE
// O(n*k)
/*
 Goal: Find the subarray with the minimum sum of length k
 Input: [4, 2, 2, 7, 8, 1, 2, 8, 1, 0], k = 3
 Output: 8
*/
methodLabel(problem: "Minimum Sum Subarray of Size K", method: .bruteForce)

func minSumSubarrayBF(_ arr: [Int], _ k: Int) -> Int {
    guard k <= arr.count else {return 0}
    
    var minSum = Int.max
    
    for i in 0...(arr.count - k) {
        let window = arr[i..<i+k]
        let sum = window.reduce(0, +)
        minSum = min(minSum, sum)
        stepsForIntArraysWithMinSum(window: window, sum: sum, minSum: minSum)
    }
    return minSum
}

minSumSubarrayBF([4, 2, 2, 7, 8, 1, 2, 8, 1, 0], 3)

// MARK: Sliding Window
/*
 Complexity:
 Time: O(n) → we visit each element once.
 Space: O(1) → only tracking sum and minSum.
*/

methodLabel(problem: "\nMinimum Sum Subarray of Size K", method: .slidingWindow)

func minSumSubarraySW(_ arr: [Int], _ k: Int) -> Int {
    guard k <= arr.count else {return 0}
    var currentSum = 0
    var minSum = Int.max
    
    for i in 0..<arr.count {
        currentSum += arr[i]
        
        if i >= k - 1 {
            minSum = min(currentSum, minSum)
            stepsForIntArraysWithMinSum(window: arr[(i - k + 1)...i], sum: currentSum, minSum: minSum)
            currentSum -= arr[i-k + 1]
        }
    }
    
    return minSum
}

minSumSubarraySW([4, 2, 2, 7, 8, 1, 2, 8, 1, 0], 3)


// MARK: - Minimum Average of Size K

// MARK: Brute Force
// O(n*k)
/*
 Goal: Find the subarray of size k with the smallest average.
 Input: [3, 7, 5, 20, -10, 0, 12], k = 2
 Output: -5.0  ([-10, 0])
*/
methodLabel(problem: "\nMinimum Average of Size K", method: .bruteForce)

func minAvgOfSizeKBF(_ arr: [Int], _ k: Int) -> Double {
    guard k <= arr.count else { return 0.0 }
    
    // works for any array of positive or negative elements
    var minAverage: Double = Double.greatestFiniteMagnitude
    
    for i in 0...(arr.count - k) {
        let window = arr[i..<i+k]
        let sum = window.reduce(0, +)
        let average = (Double(sum)/Double(k))
        minAverage = min(minAverage, average)
        print("Current window: \(window), Current sum: \(sum), Current average: \(minAverage)")
    }
    return minAverage
}

minAvgOfSizeKBF([3, 7, 5, 20, -10, 0, 12], 2)


// MARK: Sliding Window
/*
 Complexity:
 Time: O(n) → we visit each element once.
 Space: O(1) → only tracking currentSum and minAverage.
*/

methodLabel(problem: "\nMinimum Average of Size K", method: .slidingWindow)

func minAvgOfSizeKSW(_ arr: [Int], _ k: Int) -> Double {
    guard k <= arr.count else {return 0.0}
    var currentSum = 0
    var minAverage: Double = Double.greatestFiniteMagnitude
    
    for i in 0..<arr.count {
        currentSum += arr[i]
        
        if i >= k - 1 {
            let average = Double(currentSum) / Double(k)
            minAverage = min(minAverage, average )
            print("Current window: \(arr[(i - k + 1)...i]), Current sum: \(currentSum), Current average: \(minAverage)")
            currentSum -= arr[i - k + 1]
        }
    }
    
    return minAverage
}

minAvgOfSizeKSW([3, 7, 5, 20, -10, 0, 12], 2)


// MARK: - Minimum Average Subarray of Size K

// MARK: Brute Force
// O(n*k)
/*
 Goal: Find the subarray of size k with the smallest average.
 Input: [3, 7, 5, 20, -10, 0, 12], k = 2
 Output: [-10, 0] (average = -5.0)
*/


methodLabel(problem: "\nMinimum Average Subarray of Size K", method: .bruteForce)

func minAvgSubarrayfSizeKBF(_ arr: [Int], _ k: Int) -> [Int] {
    guard k <= arr.count else {return []}
    
    var averageSubarray: [Int] = []
    var minAverage: Double = Double.greatestFiniteMagnitude
    
    
    for i in 0...(arr.count - k) {
        let window  = arr[i..<i+k]
        let sum = window.reduce(0, +)
        let average = Double(sum) / Double(k)
        
        if  average < minAverage {
            minAverage = average
            averageSubarray = Array(window)
        }
        
        print("Current window: \(window), Current sum: \(sum), Current average: \(minAverage), average subarray: \(averageSubarray)")
    }
    
    return averageSubarray
}


minAvgSubarrayfSizeKBF([3, 7, 5, 20, -10, 0, 12], 2)



// MARK: Sliding Window
/*
 Complexity:
 Time: O(n) → we visit each element once.
 Space: O(1) → only tracking  minStartIndex, currentSum and minAverage.
*/

methodLabel(problem: "\nMinimum Average Subarray of Size K", method: .slidingWindow)

func minAvgSubarraySW(_ arr: [Int], _ k: Int) -> ([Int], Double) {
    guard k <= arr.count else { return ([], 0.0) }
    var currentSum  = 0
    var minAverage: Double = Double.greatestFiniteMagnitude
    var minStartIndex = 0
    
    for i in 0..<arr.count {
        currentSum += arr[i]
        
        if i >= k - 1 {
            let average = Double(currentSum) / Double(k)
            
            if average < minAverage {
                minAverage = average
                minStartIndex = i - k + 1
            }
            
            print("Current window: \(arr[(i - k + 1)...i]), Current sum: \(currentSum), Current average: \(minAverage)")
            currentSum -= arr[i - k + 1]
        }
    }
    let minSubarray = Array(arr[minStartIndex..<minStartIndex + k])
    return (minSubarray, minAverage)
}

let result = minAvgSubarraySW([3, 7, 5, 20, -10, 0, 12], 2)
print("Minimum Average Subarray: \(result.0), Average: \(result.1)")


// MARK: - Minimum Sum Subarray with Negative and Positive Numbers

// MARK: Brute Force
// O(n*k)
/*
 Goal: Handle both positive and negative numbers.
 Input: [2, -3, 4, -1, -2, 1, 5, -3], k = 3
 Output: -2 (window [-1, -2, 1])
*/

methodLabel(problem: "\nMinimum Sum Subarray with Negative and Positive Numbers", method: .bruteForce)

func minSumSubarraysBF(_ arr: [Int], _ k: Int) -> Int {
    guard k <= arr.count else { return 0 }
    
    var minSum = Int.max
    
    for i in 0...(arr.count - k) {
        let window = arr[i..<i+k]
        let sum = window.reduce(0,+)
        minSum = min(minSum, sum)
        
        stepsForIntArraysWithMinSum(window: window, sum: sum, minSum: minSum)
    }
    
    return minSum
}

minSumSubarraysBF([2, -3, 4, -1, -2, 1, 5, -3], 3)


// MARK: Sliding Window
/*
 Complexity:
 Time: O(n) → we visit each element once.
 Space: O(1) → only tracking currentSum and minSum.
*/

methodLabel(problem: "\nMinimum Sum Subarray with Negative and Positive Numbers", method: .slidingWindow)

func minSumSubarraysSW(_ arr: [Int], _ k: Int) -> Int {
    guard k <= arr.count else { return 0 }
    
    var currentSum = 0
    var minSum = Int.max
    
    for i in 0..<arr.count {
        currentSum += arr[i]
        
        if i >= k - 1 {
            minSum = min(currentSum, minSum)
            stepsForIntArraysWithMinSum(window: arr[(i - k + 1...i)], sum: currentSum, minSum: minSum)
            currentSum -= arr[i - k + 1]
        }
    }
    
    return minSum
}

minSumSubarraysSW([2, -3, 4, -1, -2, 1, 5, -3], 3)


// MARK: - Minimum Sum Subarray – Return Indices


// MARK: Brute Force
// O(n*k)
/*
 Goal: Return both the minimum sum and the corresponding start/end indices.
 Input: [5, 2, -1, 0, 3], k = 2
 Output: Min Sum = -1, Indices = (2, 3)
*/

methodLabel(problem: "\nMinimum Sum Subarray – Return Indices", method: .bruteForce)

func minSumSubarrayWithIndicesBF(_ arr:[Int], _ k: Int) -> (Int, (Int, Int)) {
    guard k <= arr.count else { return (0, (0,0)) }
    
    var minSum = Int.max
    var subarrayIndices: (Int, Int) = (0, 0)
    
    for i in 0...(arr.count - k) {
        let window = arr[i..<i+k]
        let sum = window.reduce(0, +)
       
        if sum < minSum {
            minSum = sum
            subarrayIndices = (i, i+k-1)
        }
        print("Current window: \(window), Current min sum: \(minSum), indices: \(subarrayIndices)")
    }
    
    return (minSum, subarrayIndices)
}

let minSumSIndicesBF = minSumSubarrayWithIndicesBF([5, 2, -1, 0, 3], 2)
print("Min Sum = \(minSumSIndicesBF.0), Indices = \(minSumSIndicesBF.1)")

// MARK: Sliding Window
/*
 Complexity:
 Time: O(n) → we visit each element once.
 Space: O(1) → only tracking subarray indices and minSum.
*/


methodLabel(problem: "\nMinimum Sum Subarray – Return Indices", method: .slidingWindow)

func minSumSubarrayWithIndicesSW(_ arr:[Int], _ k: Int) -> (Int, (Int, Int)) {
    guard k <= arr.count else { return (0, (0, 0)) }
    
    var currentSum = 0
    var minSum = Int.max
    var subarrayIndices: (Int, Int) = (0, 0)
    
    for i in 0..<arr.count{
        currentSum += arr[i]
        
        if i >= k - 1 {
            if currentSum < minSum {
                minSum = currentSum
                subarrayIndices = (i - k + 1, i)
            }
            print("Current window: \(arr[(i-k+1)...i]), Current min sum: \(minSum), indices: \(subarrayIndices)")
            currentSum -= arr[i - k + 1]
        }
    }
    
    return (minSum, subarrayIndices)
}

let minSumSIndicesSW = minSumSubarrayWithIndicesSW([5, 2, -1, 0, 3], 2)
print("Min Sum = \(minSumSIndicesSW.0), Indices = \(minSumSIndicesSW.1)")
