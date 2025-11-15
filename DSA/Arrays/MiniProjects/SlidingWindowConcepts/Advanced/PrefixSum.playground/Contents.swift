//  Sliding Window – Group 7: Advanced – Prefix Sum
//  ---------------------------------------------------------------
//
//  🎯 Concept Focus:
//  Use **Prefix Sums** to precompute running totals and efficiently find
//  subarray sums or patterns in O(1) time per query (after O(n) preprocessing).
//  Often combined with hashmaps for counting or indexing relationships.
//
//  💡 Key Idea:
//  Prefix Sum lets you express subarray sum(i...j) = prefix[j] - prefix[i-1].
//  When paired with HashMaps, you can quickly check how many earlier prefix
//  sums satisfy conditions like `prefix[j] - k` existing.
//
//  🧩 Pro Tip:
//  Prefix sums shine when the window or range length varies —
//  perfect for problems where you *don’t know the window size in advance*.
//  They’re foundational for balance, sum, or difference tracking problems.


import Cocoa

// MARK: Print Statements Helper

enum MethodType: String {
    case bruteForce = "💡 BRUTE FORCE"
    case slidingWindow = "⚡️ SLIDING WINDOW"
}

func methodLabel(_ problem: String,  _ method: MethodType)  {
    return print("\(problem) \(method.rawValue)")
}


// MARK: -  Problem 1: Subarray Sum Equals K

/* Goal:
 Given an array of integers nums and an integer k, return the total number of continuous subarrays whose sum equals k.
 Example:
 Input: nums = [1, 1, 1], k = 2
 Output: 2
 Explanation: The subarrays [1,1] and [1,1] both sum to 2.
 
 */


// MARK: Brute Force
// Time Complexity: O(n²) → Nested loops to check all possible subarrays
// Space Complexity: O(1) → Just keeping track of the count, and current sum


methodLabel("Problem 1: Subarray Sum Equals K", .bruteForce)


func subarraySumEqualsKBF(_ nums: [Int], _ k: Int) -> Int {
    var count = 0
    
    for i in 0..<nums.count {
        var currentSum = 0
        for j in i..<nums.count {
            var char = nums[j]
            currentSum += char
            
            print("window: \(nums[i...j]), currentSum: \(currentSum), count: \(count)")
            
            if currentSum == k {
                count += 1
            }
        }
    }
    
    return count
}

subarraySumEqualsKBF([2, 1, 2, 1, 2], 3) // 4


// MARK: Sliding Window
// Time Complexity: O(n)
// Space Complexity: O(n)


methodLabel("Problem 1: Subarray Sum Equals K", .slidingWindow)

func subarraySumEqualsKSW(_ nums: [Int], _ k: Int) -> Int {
    var count = 0
    var sumFrequency: [Int: Int] = [0:1] // prefix sum 0 has one occurrence (base case)
    var prefixSum = 0
    
    for num in nums {
        prefixSum += num
        
        // Check if there's a prefix sum that forms a valid subarray
        // If the amount you need (prefixSum − k) has appeared before, those earlier prefix sums can be removed to leave exactly k
        if let freq = sumFrequency[prefixSum - k] {
            count += freq
        }
        
        sumFrequency[prefixSum, default: 0] += 1
        
        print("Num: \(num), PrefixSum: \(prefixSum), count: \(count), Map: \(sumFrequency)")
    }
    
    
    return count
    
}

subarraySumEqualsKSW([2, 1, 2, 1, 2], 3) // 4


// MARK: -  Problem 2: Longest Subarray with Sum Equal to K

/* Goal:
 Given an array of integers nums and an integer k, find the length of the longest subarray that sums to exactly k.
 Example:
 Input: nums = [10, 5, 2, 7, 1, 9], k = 15
 Output: 4
 Explanation: [5, 2, 7, 1] sums to 15.
 */


// MARK: Brute Force
// Time Complexity: O(n²) → Nested loops to check all possible subarrays
// Space Complexity: O(1) → Just keeping track of the max length, and current sum


methodLabel("Problem 2: Longest Subarray with Sum Equal to K", .bruteForce)

func longestSubarrayWithSumEqualToKBF(_ nums: [Int], _ k: Int) -> Int {
    var maxLength = 0
    
    for i in 0..<nums.count {
        var currentSum = 0
        
        for j in i..<nums.count {
            let currentNum = nums[j]
            
            currentSum += currentNum
            
            print("window: \(nums[i...j]), current sum: \(currentSum), maxLength: \(maxLength)")
            
            if currentSum == k {
                maxLength = max(maxLength, j - i + 1)
            }
        }
    }
    return maxLength
}

longestSubarrayWithSumEqualToKBF([10, 5, 2, 7, 1, 9], 15)


// MARK: Sliding Window
// Time Complexity:
// Space Complexity:


methodLabel("Problem 2: Longest Subarray with Sum Equal to K", .slidingWindow)

/*
 // ❌ Without base case:
 // You would need an explicit check for subarrays starting at index 0:
 func longestSubarrayWithSumEqualToKSW(_ nums: [Int], _ k: Int) -> Int {
 var maxLength = 0
 var prefixSum = 0
 var sumIndices: [Int: Int] = [:]
 
 for (i, num) in nums.enumerated() {
 prefixSum += num
 
 // Check subarray starting at index 0
 if prefixSum == k {
 maxLength = max(maxLength, i + 1)
 }
 
 if let prevIndex = sumIndices[prefixSum - k] {
 maxLength = max(maxLength, i - prevIndex)
 }
 
 if sumIndices[prefixSum] == nil {
 sumIndices[prefixSum] = i
 }
 }
 }
 */

func longestSubarrayWithSumEqualToKSW(_ nums: [Int], _ k: Int) -> Int {
    var maxLength = 0
    var prefixSum = 0
    
    // 🔹 Base case for prefix sum:
    // Assume prefix sum 0 occurs "before" the array starts (index -1)
    // - Handles subarrays starting at index 0 automatically
    // - Formula: prefixSum(i) - prefixSum(j) = k
    //   - If prefixSum(i) == k, then prefixSum(i) - 0 = k
    // - Index -1 is outside array
    //   -> Length = i - (-1) = i + 1
    //   -> Correct length for subarrays starting at index 0
    var sumIndices: [Int: Int] = [0: -1]
    
    for (i, num) in nums.enumerated() {
        prefixSum += num
        
        // Check if there exists a previous prefix sum such that:
        // current prefixSum - previous prefixSum = k
        if let prevIndex = sumIndices[prefixSum - k] {
            maxLength = max(maxLength, i - prevIndex)
        }
        
        // Checks if this prefix sum has already been recorded
        // If not, store the first occurrence of each prefix sum -> to remember the earliest index at which each prefix sum occurs (longest subarray)
        // If it has been recorded before, we do nothing — we keep the earlier index.
        if sumIndices[prefixSum] == nil {
            sumIndices[prefixSum] = i
        }
        
        print("i: \(i), num: \(num), prefixSum: \(prefixSum), maxLength: \(maxLength), map: \(sumIndices)")
    }
    
    return maxLength
}



longestSubarrayWithSumEqualToKSW([10, 5, 2, 7, 1, 9], 15)



// MARK: - Problem 3: Continuous Subarray Sum (Multiple of K)

/* Goal:
 Given an array nums and integer k, check if there exists a continuous subarray of size ≥ 2 whose sum is a multiple of k. (sum % k == 0)
 Example:
 Input: nums = [23, 2, 4, 6, 7], k = 6
 Output: true
 Explanation: [2,4] sums to 6 which is a multiple of 6.
 
 */


// MARK: Brute Force
//Time Complexity: O(n²) → Nested loops, each window sum calculated incrementally.
// Space Complexity: O(1) → store currentSum.

methodLabel("Problem 3: Continuous Subarray Sum (Multiple of K)", .bruteForce)


func subarraySumMultipleOfKBF(_ nums: [Int], _ k: Int) -> Bool {
    guard !nums.isEmpty, k > 0 else { return false }
    
    for i in 0..<nums.count {
        var currentSum = 0
        
        for j in i..<nums.count {
            let currentNum = nums[j]
            currentSum += currentNum
            
            print("window: \(nums[i...j]), current sum: \(currentSum), is mulitple of k: \( currentSum % k == 0)")
            
            
            if j - i + 1 >= 2, currentSum % k == 0 {
                return true
            }
        }
    }
    
    return false
}

subarraySumMultipleOfKBF([23, 2, 4, 6, 7], 6)


// MARK: Sliding Window
// Time Complexity: O(n) — single pass through the array
// Space Complexity: O(min(n, k)) — storing mod values

methodLabel("Problem 3: Continuous Subarray Sum (Multiple of K)", .slidingWindow)


func subarraySumMultipleOfKSW(_ nums: [Int], _ k: Int) -> Bool {
    guard !nums.isEmpty, k > 0 else { return false }
    var sumIndices: [Int: Int] = [0:-1] // Base case: prefix sum 0 occurs before array
    var runningSum = 0
    
    for (i, num) in nums.enumerated() {
        runningSum += num
        let mod = runningSum % k
        
        print("Index: \(i), Num: \(num), RunningSum: \(runningSum), Mod: \(mod), Map: \(sumIndices)")
        
        
        if let prevIndex = sumIndices[mod] {
            // Ensure subarray size >= 2
            if i - prevIndex >= 2 {
                print("Found subarray from index \(prevIndex + 1) to \(i) with multiple of k")
                return true
            } else{
                // Store first occurrence of this mod
                sumIndices[mod] = i
            }
        }
        
        
    }
    return false
    
}


subarraySumMultipleOfKSW([23, 2, 4, 6, 7], 6)
