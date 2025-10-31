//
//  Sliding Window – Group 1: Maximum Sum Subarray Variations
//  ----------------------------------------------------------
//
//  Concept Focus:
//  Learn how to find the maximum (or minimum) sum of contiguous subarrays
//  of fixed size `k` efficiently using the **sliding window** technique.
//
//  Key Idea:
//  Instead of recalculating the sum of each window from scratch (O(n * k)),
//  we slide the window by one element at a time and update the sum in O(1).
//
//   Pro Tip:
//  Practice each by first writing the brute-force (nested loop) solution,
//  then optimize it with a true sliding window approach.
//

import Cocoa


// MARK: - Basic Maximum Sum Subarray of Size K
// Find the maximum sum of any contiguous subarray of size k
/*
 Input: [2, 1, 5, 1, 3, 2], k = 3
 Output: 9
*/

print("Basic Maximum Sum Subarray of Size K BRUTE FORCE")

// MARK: Brute Force
// O(n*k)
func maxSumSubarrayBF(of array:[Int], size k: Int) -> Int {
    guard k <= array.count else { return 0 }
    var maxSum = 0
    
    for i in 0...(array.count-k) {
        let window = array[i..<(i+k)]
        let sum = window.reduce(0, +)
        maxSum = max(maxSum, sum)
        print("window: \(window), sum: \(sum)")
        print("Maximum sum of subarray of size \(k): \(maxSum)")
    }
    
    return maxSum
}

maxSumSubarrayBF(of: [2, 1, 5, 1, 3, 2], size: 3)

// MARK: Slding Window
// O(n)

print("\nBasic Maximum Sum Subarray of Size K SLIDING WINDOW")

func maxSumSubarraySW(of array:[Int], size k: Int) -> Int {
    guard k <= array.count else { return 0 }
   
    // Compute sum of the first window
    var currentSum = array[0..<k].reduce(0, +)
    var maxSum = currentSum
    print("Initial window:", array[0..<k], "sum:", currentSum)
    
    //  Slide the window forward from second window
    for end in k..<array.count {
        /*
         array[end] → new element entering the window
         array[end - k] → old element leaving the window
         */
        currentSum += array[end] - array[end - k]
        maxSum = max(maxSum, currentSum)
        print("Updated Window:", array[(end - k + 1)...end], "sum:", currentSum, "max:", maxSum)
    }
    
    return maxSum
}
 
maxSumSubarraySW(of: [2, 1, 5, 1, 3, 2], size:3)


// MARK: - Maximum Sum Subarray with Negative Numbers
// Find the maximum sum of any contiguous subarray with negative numbers of size k.
/*
 Input: [4, -1, 2, 10, -2, 3, 1, 0, 5], k = 3
 Output: 12 (window [10, -2, 3, 1])
*/

print("\nMaximum Sum Subarray with Negative Numbers BRUTE FORCE")

// MARK: Brute Force
// O(n*k)

func maxSumSubarrayNegaiveBF(for array: [Int], size k: Int) -> Int {
    guard k <= array.count else { return 0 }
    
    // Handles the firt windows of all numbers are negative
    // Ensuring negative results are handled correctly
    var maxSum = array[0..<k].reduce(0, +)
    
    for i in 0...(array.count - k) {
        let window = array[i..<(i+k)]
        let sum = window.reduce(0, +)
        maxSum = max(maxSum, sum)
        print("window: \(window), sum: \(sum)")
        print("Maximum sum of subarray of size \(k): \(maxSum)")
    }
    return maxSum
}
print("Result (Brute Force):", maxSumSubarrayNegaiveBF(for: [4, -1, 2, 10, -2, 3, 1, 0, 5], size: 3))


// MARK: Sliding Window
// O(n)

print("\nMaximum Sum Subarray with Negative Numbers - SLIDING WINDOW")

func maxSumSubarrayNegativeSW(for array: [Int], size k: Int) -> Int {
    guard k <= array.count else { return 0 }
    
    // Compute first window sum
    var currentSum = array[0..<k].reduce(0, +)
    var maxSum = currentSum
    print("Initial window:", array[0..<k], "sum:", currentSum)
    
    // Slide the window
    for end in k..<array.count {
        currentSum += array[end] - array[end - k]
        maxSum = max(maxSum, currentSum)
        print("Window:", array[(end - k + 1)...end], "sum:", currentSum, "max:", maxSum)
    }
    
    return maxSum
}

print("Result (Sliding Window):", maxSumSubarrayNegativeSW(for: [4, -1, 2, 10, -2, 3, 1, 0, 5], size: 3))


// MARK: - Maximum Sum Subarray of Size K with Indices
/*
 Goal: Return both the maximum sum and its starting index.
 Input: [2, 3, 4, 1, 5], k = 2
 Output: Max Sum = 7, Start Index = 1
*/

print("\nMaximum Sum Subarray of Size K with Indices BRUTE FORCE")

// MARK: Brute Force
// O(n*k)

func maxSumSubarayWithIndicesBF(for array: [Int], size k: Int) -> (maxSum: Int, startIndex: Int) {
    guard k <= array.count else { return (0, -1) }
    
    var maxSum = Int.min
    var startIndex = 0
      
    for i in 0...(array.count - k) {
        let window = array[i..<(i+k)]
        let sum = window.reduce(0, +)
        
        if sum > maxSum {
            maxSum = sum
            startIndex = i
        }
        
        print("window: \(window), sum: \(sum), startIndex: \(startIndex), maxSum: \(maxSum)")
    }
    
    
    
    return (maxSum, startIndex)
}

print("Result (Brute Force):", maxSumSubarayWithIndicesBF(for:  [2, 3, 4, 1, 5], size: 2))

print("\nMaximum Sum Subarray of Size K with Indices SLIDING WINDOW")

// MARK: Sliding Window
// O(n)


func maxSumSubarrayWithIndicesSW(for array: [Int], size k: Int) -> (maxSum: Int, startIndex: Int) {
    guard k <= array.count else { return (0, -1) }
    
    var currentSum = array[0..<k].reduce(0, +)
    var maxSum = currentSum
    var startIndex = 0
    
    for rightWindow in k..<array.count {
        // Add next element, remove first element of the previous window
        currentSum += array[rightWindow] - array[rightWindow - k]
              
        
        // If new sum is greater, record it and its starting index
        if currentSum > maxSum {
            maxSum = currentSum
            startIndex = rightWindow - k + 1
        }
        
        print("Window:", array[(rightWindow - k + 1)...rightWindow], "sum:", currentSum, "maxSum:", maxSum, "startIndex:", startIndex)
    }
    
    return (maxSum, startIndex)
}
let result = maxSumSubarrayWithIndicesSW(for: [2, 3, 4, 1, 5], size: 2)

print("Result (Sliding Window): Max Sum =", result.maxSum, "| Start Index =", result.startIndex)


// MARK: - Maximum Sum Subarray of Size K – Variable Window Movement
/*
 Goal: Instead of fixed steps, slide conditionally (only when the window reaches size k).
 Input: [1, 9, -1, -2, 7, 3, -1, 2], k = 4
 Output: 13
*/

print("\nMaximum Sum Subarray of Size K – Variable Window Movement BRUTE FORCE")

// MARK: Brute Force
// O(n*k)

func maxSumSubarrayOfSizeKVariableWindowMovementBF(for array: [Int], size k: Int) -> Int {
    guard k <= array.count else {return 0}
    
    var maxSum = Int.min
    
    for i in 0...(array.count - k) {
        let window = array[i..<(i+k)]
        let sum = window.reduce(0, +)
        maxSum = max(maxSum, sum)
        print("window: \(window), sum: \(sum), current max: \(maxSum)")
    }
    
    return maxSum
}

 
print("Result: Maximum sum for window size 4 = \(maxSumSubarrayOfSizeKVariableWindowMovementBF(for: [1, 9, -1, -2, 7, 3, -1, 2], size: 4))")

print("\nMaximum Sum Subarray of Size K – Variable Window Movement SLIDING WINDOW")

// MARK: Sliding Window
// TC: O(n); SC: O(1)

func maxSumSubarrayOfSizeKVariableWindowMovementSW(for array: [Int], size k: Int) -> Int {
    guard k <= array.count else { return 0 }

    // Compute sum of the first window
    var currentSum = array[0..<k].reduce(0, +)
    var maxSum = currentSum
    print("Initial window:", array[0..<k], "sum:", currentSum)

    // Slide the window
    for end in k..<array.count {
        // Add next element, remove first element of previous window
        currentSum += array[end] - array[end - k]
        maxSum = max(maxSum, currentSum)
        print("Window:", array[(end - k + 1)...end], "sum:", currentSum, "maxSum:", maxSum)
    }

    return maxSum
}

print("Result: Maximum sum for window size 4 = \(maxSumSubarrayOfSizeKVariableWindowMovementSW(for: [1, 9, -1, -2, 7, 3, -1, 2], size: 4))")

// MARK: - Maximum Sum Subarray with Threshold
/*
 Goal: Find how many windows have a sum greater than or equal to a given threshold
 Input: [2, 1, 5, 2, 3, 2], k = 3, threshold = 7
 Output: 2
*/

print("\nMaximum Sum Subarray with Threshold BRUTE FORCE")

// MARK: Brute Force
// O(n*k)

func maxSumSubarrayWithThresoholdBF(for array: [Int], size k: Int, of threshold: Int) -> Int {
    guard k <= array.count else {return 0}

    var count = 0

    for i in 0...(array.count - k){
        let window = array[i..<(i+k)]
        let sum = window.reduce(0, +)
    
        if sum >= threshold {
            count += 1
        }
        print("window: \(window), sum: \(sum),threshold count: \(count)")
    }
    
    return count
    
}

print("Result: Maximum Sum Subarray with Threshold = \(maxSumSubarrayWithThresoholdBF(for: [2, 1, 5, 2, 3, 2], size: 3, of: 7))")


print("\nMaximum Sum Subarray with Threshold SLIDING WINDOW")

// MARK: Sliding Window
// TC: O(n); SC: O(1)

func maxSumSubarrayWithThresholdSW(for array: [Int], size k: Int, threshold: Int) -> Int {
    guard k <= array.count else { return 0 }
    
    var currentSum = array[0..<k].reduce(0, +)
    var count = currentSum >= threshold ? 1 : 0
    print("Initial window:", array[0..<k], "sum:", currentSum, "count:", count)

    for end in k..<array.count {
        currentSum += array[end] - array[end - k]
        
        if currentSum >= threshold {
            count += 1
        }
        print("window:", array[(end - k + 1)...end], "sum:", currentSum, "count:", count)
    }
    
    return count
}

print("Result: Maximum Sum Subarray with Threshold = \(maxSumSubarrayWithThresholdSW(for: [2, 1, 5, 2, 3, 2], size: 3, threshold: 7))")
