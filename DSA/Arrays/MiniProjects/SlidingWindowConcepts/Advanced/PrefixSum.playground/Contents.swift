//  Prefix Sum – Advanced / Implicit Sliding Window – Group 7: Advanced – Prefix Sum & Extreme Tracking
//  ---------------------------------------------------------------
//
//  🎯 Concept Focus:
//  Use **Prefix Sums** to precompute running totals and efficiently find
//  subarray sums or patterns in O(1) per query (after O(n) preprocessing).
//  Often combined with hashmaps for counting or indexing relationships.
//
//  💡 Key Idea:
//  Prefix Sum lets you express subarray sum(i...j) = prefix[j] - prefix[i-1].
//  When paired with HashMaps, you can quickly check how many earlier prefix
//  sums satisfy conditions like `prefix[j] - k` existing.
//
//  🧩 Advanced Trick – Implicit Prefix Sum – Advanced / Implicit Sliding Window (Prefix Extreme):
//  - For problems where the condition is an inequality (sum > 0 or sum < 0),
//    a hashmap is not enough.
//  - Track the **minimum or maximum prefix seen so far** along with its index.
//  - The "window" is implicitly defined between the current index and this extreme index.
//  - Example Problems:
//      • Longest subarray with more 1s than 0s
//      • Longest subarray with more 0s than 1s
//      • Longest subarray with sum > k
//  - This allows O(n) time and O(1) space solutions for problems that appear
//    to require variable-length windows.
//
//  🧩 Pro Tip:
//  Prefix sums shine when the window or range length varies —
//  perfect for problems where you *don’t know the window size in advance*.


import Cocoa

// MARK: Print Statements Helper

enum MethodType: String {
    case bruteForce = "💡 BRUTE FORCE"
    case prefixSum = "⚡️ Prefix Sum – Advanced / Implicit Sliding Window"
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


// MARK: Prefix Sum – Advanced / Implicit Prefix Sum – Advanced / Implicit Sliding Window
// Time Complexity: O(n)
// Space Complexity: O(n)


methodLabel("Problem 1: Subarray Sum Equals K", .prefixSum)

func subarraySumEqualsKPrefix(_ nums: [Int], _ k: Int) -> Int {
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

subarraySumEqualsKPrefix([2, 1, 2, 1, 2], 3) // 4


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


// MARK: Prefix Sum – Advanced / Implicit Sliding Window
// Time Complexity:
// Space Complexity:


methodLabel("Problem 2: Longest Subarray with Sum Equal to K", .prefixSum)

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

func longestSubarrayWithSumEqualToKPrefix(_ nums: [Int], _ k: Int) -> Int {
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



longestSubarrayWithSumEqualToKPrefix([10, 5, 2, 7, 1, 9], 15)



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


// MARK: Prefix Sum – Advanced / Implicit Sliding Window
// Time Complexity: O(n) — single pass through the array
// Space Complexity: O(min(n, k)) — storing mod values

methodLabel("Problem 3: Continuous Subarray Sum (Multiple of K)", .prefixSum)


func subarraySumMultipleOfKPrefix(_ nums: [Int], _ k: Int) -> Bool {
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


subarraySumMultipleOfKPrefix([23, 2, 4, 6, 7], 6)


// MARK: -  Problem 4: Number of Subarrays with Sum Divisible by K

/* Goal:
 Given an integer array nums and an integer k, return the number of non-empty subarrays with a sum divisible by k.
 Example:
 Input: nums = [4,5,0,-2,-3,1], k = 5
 Output: 7
 Explanation: 7 subarrays have sums divisible by 5.
 */


// MARK: Brute Force
// Time Complexity: O(n²) → We check every possible subarray (i..j)
// Space Complexity: O(1) → Only storing sum and count.

methodLabel("Problem 4: Number of Subarrays with Sum Divisible by K", .bruteForce)


func numberOfSubarraysDivisibleByKBF(_ nums: [Int], _ k: Int) -> Int {
    guard !nums.isEmpty else {return 0}
    
    var count = 0
    
    for i in 0..<nums.count {
        var currentSum = 0
        for j in i..<nums.count {
            let currentNum = nums[j]
            
            currentSum += currentNum
            
            print("window: \(nums[i...j]), current sum: \(currentSum), currentNum: \(currentNum), count: \(count)")
            
            if currentSum % k == 0 {
                count += 1
            }
            
        }
    }
    return count
    
}

numberOfSubarraysDivisibleByKBF([4,5,0,-2,-3,1], 5)



// MARK: Prefix Sum – Advanced / Implicit Sliding Window
// Time Complexity: O(n)
// Space Complexity: O(k) (or O(n) worst case for negative values)

methodLabel("Problem 4: Number of Subarrays with Sum Divisible by K", .prefixSum)


func numberOfSubarraysDivisibleByKPrefix(_ nums: [Int], _ k: Int) -> Int {
    var count = 0
    var runningSum = 0
    
    var remainderFreq: [Int: Int] = [0: 1]   // remainder 0 occurs once initially
    
    for num in nums {
        runningSum += num
        
        // Normalize remainder for negative numbers
        let mod = ((runningSum % k) + k) % k
        
        // If this remainder was seen before, add how many times
        if let freq = remainderFreq[mod] {
            count += freq
        }
        
        // Store/update remainder frequency
        remainderFreq[mod, default: 0] += 1
    }
    
    return count
}


// MARK: -  Balanced 0 & 1 Problems
// Using the 0 → -1 transform technique

// MARK: Problem 5: Longest Subarray with Equal 0s and 1s

/* Goal:
 Given a binary array nums, find the length of the longest subarray with equal number of 0s and 1s. Use prefix sum transformation (0 → -1 trick).
 Example:
 Input: nums = [0,1,0]
 Output: 2
 Explanation: The subarray [0,1] or [1,0] is balanced.
 */


// MARK: Brute Force
// Time Complexity: O(n²) → We check every possible subarray (i..j)
// Space Complexity: O(1) → Only counters and maxLength stored

methodLabel("Problem 5: Longest Subarray with Equal 0s and 1s", .bruteForce)


func longestSubarrayEqual0sAnd1sBF(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    var maxLength = 0
    
    
    for i in 0..<nums.count {
        var zeroCount = 0
        var oneCount = 0
        
        for j in i..<nums.count {
            let currentNum = nums[j]
            if currentNum == 0 {
                zeroCount += 1
            } else {
                oneCount += 1
            }
            
            if zeroCount == oneCount {
                maxLength = max(maxLength, j - i + 1)
            }
            
            print("window: \(nums[i...j]), zero count: \(zeroCount), one count: \(oneCount), max length: \(maxLength)")
        }
    }
    return maxLength
}


longestSubarrayEqual0sAnd1sBF([0,1,0])



// MARK: Prefix Sum – Advanced / Implicit Sliding Window
// Time Complexity:
// Space Complexity:

methodLabel("Problem 5: Longest Subarray with Equal 0s and 1s", .prefixSum)

func longestSubarrayEqual0sAnd1sPrefix(_ nums: [Int]) -> Int {
    var maxLength = 0
    var prefixSum = 0
    
    // Base Case: prefix sum = 0 has index -1
    // This allows subarrays starting at index 0 to be counted.
    // Reason:
    // If prefixSum(i) == 0, then prefixSum(i) - prefixSum(-1) = 0 → balanced
    // So length = i - (-1) = i + 1
    var firstIndex: [Int: Int] = [0: -1]
    
    for (i, num) in nums.enumerated() {
        
        // Convert 0 → -1 so balanced subarrays have sum == 0
        prefixSum += (num == 0 ? -1 : 1)
        
        // If this prefixSum has been seen before,
        // then the subarray between the first occurrence and now has sum 0.
        if let prev = firstIndex[prefixSum] {
            maxLength = max(maxLength, i - prev)
        }
        
        // Store ONLY the first occurrence,
        // because the earliest index gives the longest subarray.
        if firstIndex[prefixSum] == nil {
            firstIndex[prefixSum] = i
        }
        
        print("i: \(i), num: \(num), prefixSum: \(prefixSum), firstIndex: \(firstIndex), maxLength: \(maxLength)")
    }
    
    return maxLength
}


longestSubarrayEqual0sAnd1sPrefix([0,1,0])


// MARK: Problem 6:  Count Balanced Subarrays

/* Goal:
    Count all subarrays containing the same number of 0s and 1s
 Example:
    Input: [0,0,1,0,1]
    Output: 4
    Explanation: balanced subarrays: [0,1], [0,1], [0,0,1,0,1], [0,1]

 */


// MARK: Brute Force
// Time Complexity: O(n²) → We check every possible subarray (i..j)
// Space Complexity: O(1) → Only counters and count is stored

methodLabel("Problem 6: Count Balanced Subarrays", .bruteForce)


func countBalancedSubarraysBF(_ nums: [Int]) -> Int {
    var count = 0

    for i in 0..<nums.count {
        var zeroCount = 0
        var oneCount = 0
        
        for j in i..<nums.count {
            var currentNum = nums[j]
           
            if currentNum == 0 {
                zeroCount += 1
            }
            else {
                oneCount += 1
            }
            
            if zeroCount == oneCount {
                count += 1
            }
            
            print("window: \(nums[i...j]), zero count: \(zeroCount), one count: \(oneCount), count: \(count)")
        }
    }
    
    return count
}


countBalancedSubarraysBF([0,0,1,0,1])

// MARK: Prefix Sum – Advanced / Implicit Sliding Window
// Time Complexity: O(n) → Single pass over the array
// Space Complexity: O(n) → Dictionary storing prefix sums

methodLabel("Problem 6: Count Balanced Subarrays", .prefixSum)

func countBalancedSubarraysPrefix(_ nums: [Int]) -> Int {
    var count = 0
    var prefixSum = 0
    var sumFrequency: [Int: Int] = [0: 1]
    
    for (i, num) in nums.enumerated() {
        // Convert 0 -> -1, 1 stays as 1
        prefixSum += (num == 0 ? -1 : 1)
        
        // How many times this prefixSum has occurred before
        let freq = sumFrequency[prefixSum, default: 0]
        count += freq
        
        print("Index: \(i), Num: \(num), PrefixSum: \(prefixSum), Freq: \(freq), Count: \(count), sumFrequency: \(sumFrequency)")
        
        sumFrequency[prefixSum, default: 0] += 1
    }
    
    return count
}

countBalancedSubarraysPrefix([0,0,1,0,1])


// MARK: Problem 7:  Longest Subarray With More 1s Than 0s

/* Goal:
    Given a binary array nums,track longest with sum > 0
 Example:
    Input: [1,0,1,1]
    Output: 4  // whole array has more 1s than 0s

 */


// MARK: Brute Force
// Time Complexity: O(n²) → We check every possible subarray (i..j)
// Space Complexity: O(1) → Only counters and maxLength stored

methodLabel("Problem 7: Longest Subarray With More 1s Than 0s", .bruteForce)


func longestSubArrayWithMoreOnesThanZerosBF(_ nums: [Int]) -> Int {
    var maxLength = 0
    
    for i in 0..<nums.count {
        var currentSum = 0
        
        for j in i..<nums.count {
            var currentNum = nums[j]
            
            currentSum += (currentNum == 1 ? 1 : -1)

            print("window: \(nums[i...j]), current sum: \(currentSum), max length: \(maxLength)")
            
            if currentSum > 0 {
                maxLength = max(maxLength, j - i + 1)
            }
            
        }
    }
    
    return maxLength
}


longestSubArrayWithMoreOnesThanZerosBF([1,0,1,1])


// MARK: Prefix Sum – Advanced / Implicit Sliding Window
// Time Complexity: O(n) → single pass, constant-time operations per element
// Space Complexity: O(1) → only a few integer variables stored

methodLabel("Problem 7: Longest Subarray With More 1s Than 0s", .prefixSum)

func longestSubArrayWithMoreOnesThanZerosPrefix(_ nums: [Int]) -> Int {
    var maxLength = 0
    var runningSum = 0
    var minPrefix = 0         // lowest prefix sum seen
    var minIndex = -1         // index where lowest prefix sum occurred
    
    for i in 0..<nums.count {
        runningSum += (nums[i] == 1 ? 1 : -1)
        
        // If current prefix is greater than the smallest prefix so far,
        // then the subarray from (minIndex+1 ... i) has sum > 0
        if runningSum > minPrefix {
            maxLength = max(maxLength, i - minIndex)
        }
        
        // Update lowest prefix sum & its index
        if runningSum < minPrefix {
            minPrefix = runningSum
            minIndex = i
        }
        
        print("i: \(i), num: \(nums[i]), prefix: \(runningSum), minPrefix: \(minPrefix), minIndex: \(minIndex), maxLength: \(maxLength)")
    }
    
    return maxLength
}


longestSubArrayWithMoreOnesThanZerosPrefix([1,0,1,1])


// MARK: Problem 8:  Longest Subarray With More 0s Than 1s

/* Goal:
    Given a binary array nums, track longest with sum <= 0
 Example:
    Input: [0,1,0,0,1,0,1]
    Output: 2
 */

// MARK: Brute Force
// Time Complexity: O(n²) → We check every possible subarray (i..j)
// Space Complexity: O(1) → Only counters and maxLength stored

methodLabel("Problem 8: Longest Subarray With More 0s Than 1s", .bruteForce)



func longestSubArrayWithMoreZerosThanOnesBF(_ nums: [Int]) -> Int {
    var maxLength = 0

    for i in 0..<nums.count {
        var currentSum = 0
        
        for j in i..<nums.count {
            var currentNum = nums[j]
            
            currentSum += (currentNum == 0 ? -1 : 1)

            print("window: \(nums[i...j]), current sum: \(currentSum), max length: \(maxLength)")
            
            if currentSum < 0 {
                maxLength = max(maxLength, j - i + 1)
            }
        }
    }
    
    return maxLength
}

longestSubArrayWithMoreZerosThanOnesBF([0,1,0,0,1,0,1])


// MARK: Prefix Sum – Advanced / Implicit Sliding Window
// Time Complexity: O(n)
// Space Complexity: O(1)

methodLabel("Problem 8: Longest Subarray With More 0s Than 1s", .prefixSum)


func longestSubArrayWithMoreZerosThanOnesPrefix(_ nums: [Int]) -> Int {
    var maxLength = 0
    var prefix = 0

    // Track the maximum prefix seen so far and its index
    var maxPrefix = 0
    var maxIndex = -1

    for i in 0..<nums.count {
        // 0 -> -1, 1 -> +1
        prefix += (nums[i] == 0 ? -1 : 1)

        // If current prefix is smaller than the largest previous prefix,
        // then (maxIndex+1 .. i) has sum < 0 (more zeros than ones).
        if prefix < maxPrefix {
            maxLength = max(maxLength, i - maxIndex)
        }

        // Update the maximum prefix & its index when we find a new larger prefix
        if prefix > maxPrefix {
            maxPrefix = prefix
            maxIndex = i
        }

        print("i: \(i), num: \(nums[i]), prefix: \(prefix), maxPrefix: \(maxPrefix), maxIndex: \(maxIndex), maxLength: \(maxLength)")
    }

    return maxLength
}


longestSubArrayWithMoreZerosThanOnesPrefix([0,1,0,0,1,0,1])


// MARK: Problem 9:  Count Subarrays Where #1s - #0s = K

/* Goal:
    Find how many subarrays have (#1s - #0s) = k.
    Since 0 counts as -1 and 1 counts as +1,
    we convert:
        1 → +1
        0 → -1
 Example:
    Input: nums = [1,0,1], k = 1
    Output: 3

 Explanation (convert 0 → -1):
     [1]         → sum = 1                 ✅ count = 1
     [1,0]       → sum = 1 + (-1) = 0      ❌
     [1,0,1]     → sum = 1 + (-1) + 1 = 1  ✅ count = 2
     [0]         → sum = -1                ❌
     [0,1]       → sum = -1 + 1 = 0        ❌
     [1]         → sum = 1                 ✅ count = 3
 */


// MARK: Brute Force
// Time Complexity: O(n²) → We check every possible subarray (i..j)
// Space Complexity: O(1) → Only counters and maxLength stored

methodLabel("Problem 9: Count Subarrays Where #1s - #0s = K", .bruteForce)

func countSubarraySumEqualsKBF(_ nums: [Int], _ k: Int) -> Int {
    var count = 0
    
    for i in 0..<nums.count {
        var currentSum = 0
        
        for j in i..<nums.count {
            let currentNum = nums[j]
            
            currentSum += (currentNum == 0 ? -1 : 1)
            
            if currentSum == k {
                count += 1
            }
            
            print("window: \(nums[i...j]), sum: \(currentSum), count: \(count)")
        }
    }
    
    return count
}

countSubarraySumEqualsKBF([1,0,1], 1)

// MARK:  Prefix Sum – Advanced / Implicit Sliding Window
// Time Complexity:
// Space Complexity:

methodLabel("Problem 9: Count Subarrays Where #1s - #0s = K", .prefixSum)

func countSubarraySumEqualsKPrefix(_ nums: [Int], _ k: Int) -> Int {
    var count  = 0
    var prefixSum = 0
    var sumFrequency: [Int:Int] = [0:1]
    
    for (i, num) in nums.enumerated() {
        prefixSum += (num == 0 ? -1 : 1)
        
        let neededSum = prefixSum - k
        let freq = sumFrequency[neededSum, default: 0]
        count += freq
        
        sumFrequency[prefixSum, default: 0] += 1
        
        print("""
            i: \(i), num: \(num)
            prefixSum: \(prefixSum)
            prefixSum - k: \(neededSum)
            freq of neededSum: \(freq)
            count so far: \(count)
            sumFrequency: \(sumFrequency)
            -----------------------------
            """)
    }
    
    return count
}

countSubarraySumEqualsKPrefix([1,0,1], 1)


// MARK: Problem 10: Find All Balanced Subarray Indices
/* Goal:
    Return all (start,end) pairs where the subarray has equal 0s and 1s.
 Example:
    Input: [0,1,1,0]
    Output: [(0,1), (2,3), (0,3)]


 */


// MARK: Brute Force
// Time Complexity: O(n²) → We check every possible subarray (i..j)
// Space Complexity: O(R) → R = number of balanced subarray pairs returned

methodLabel("Problem 10: Find All Balanced Subarray Indices", .bruteForce)


func findAllBalancedSubarrayIndicesBF(_ nums: [Int]) -> [[Int]] {
    var result: [[Int]] = []
    
    for i in 0..<nums.count {
        var count = 0
        
        for j in i..<nums.count {
            count += (nums[j] == 0 ? -1 : 1)
            
            print("window: \(nums[i...j]), count: \(count), result: \(result)")
            
            if count == 0 {
                result.append([i,j])
            }
        
        }
    }
    
    return result
}

findAllBalancedSubarrayIndicesBF([0,1,1,0])



// MARK:  Prefix Sum – Advanced / Implicit Sliding Window
// Time Complexity: O(n²) → because we may output many pairs
// Space Complexity: O(n + R) → hashmap + result pairs

methodLabel("Problem 10: Find All Balanced Subarray Indices", .prefixSum)

func findAllBalancedSubarrayIndicesPrefix(_ nums: [Int]) -> [[Int]] {
    var result: [[Int]] = []
    var prefixSum = 0
    
    // Store 0: [-1] so that a prefix sum of 0 at any real index forms a balanced subarray starting at index 0
    var sumIndex: [Int: [Int]] = [0: [-1]]
    
    for i in 0..<nums.count {
        let val = (nums[i] == 0 ? -1 : 1)
        prefixSum += val
        
        print("\nIndex \(i), num: \(nums[i]) → mapped: \(val)")
        print("Current prefix sum = \(prefixSum)")
        
        if let previous = sumIndex[prefixSum] {
            print("Found previous prefix matches at indices: \(previous)")
            for start in previous {
                print("  → Balanced subarray found: (\(start + 1), \(i))")
                result.append([start + 1, i])
                print("  → indice appended: \(result)")
            }
        } else {
            print("No previous prefix match found.")
        }
        
        sumIndex[prefixSum, default: []].append(i)
        print("Updated sumIndex[\(prefixSum)] = \(sumIndex[prefixSum]!)")
        
    }
    
    return result
}


findAllBalancedSubarrayIndicesPrefix([0,1,1,0])




// MARK: Problem 11: Longest Balanced Subarray in a Binary String
/* Goal:
    Given a binary string (e.g., "001101"), find the length of the longest substring where the number of 0s and 1s are equal.
    This is the string-based version of the balanced subarray problem, where '0' is treated as -1 and '1' as +1.
 Example:
    Input:  "001101"
    Output: 6    // the entire string is balanced
*/


// MARK: Brute Force
// Time Complexity: O(n²) → We check every possible subarray (i..j)
// Space Complexity: O(1) → We're keeping track of the current length and max length

methodLabel("Problem 11: Longest Balanced Subarray in a Binary String", .bruteForce)

func longestBalancedBinaryStringBF(_ s: String) -> Int {
    var maxLength = 0
    let character = Array(s)
    
    for i in 0..<character.count {
        var currentLength = 0
        
        for j in i..<character.count {
            currentLength += (character[j] == "0") ? -1 : 1
            
            print("window: \(character[i...j]), currentLength: \(currentLength), max length: \(maxLength)")
            
            if currentLength == 0 {
                maxLength = max(maxLength, j - i + 1)
            }
        }
    }
    
    return maxLength
}

longestBalancedBinaryStringBF("001101")


// MARK: Prefix Sum – Advanced / Implicit Sliding Window
// Time Complexity: O(n) → single pass through string
// Space Complexity: O(n) → hashmap storing first occurrence of prefix sums


methodLabel("Problem 11: Longest Balanced Subarray in a Binary String", .prefixSum)

func longestBalancedBinaryStringPrefix(_ s: String) -> Int {
    var maxLength = 0
    var prefixSum = 0
    var firstIndex: [Int: Int] = [0: -1] // base case
    let characters = Array(s)

    
    for i in 0..<characters.count {
        prefixSum += (characters[i] == "0") ? -1 : 1
        
        print("\nIndex \(i), char: \(characters[i]), mapped: \((characters[i] == "0") ? -1 : 1)")
        print("Current prefixSum: \(prefixSum)")
        
        if let prevIndex = firstIndex[prefixSum] {
            let length = i - prevIndex
            maxLength = max(maxLength, length)
            print("  → Found previous prefix at index \(prevIndex). Current balanced length: \(length). maxLength: \(maxLength)")
        } else {
            firstIndex[prefixSum] = i
            print("  → First occurrence of prefixSum \(prefixSum) at index \(i).")
        }
        
        print("  → firstIndex map: \(firstIndex)")
    }
    
    return maxLength
}


longestBalancedBinaryStringPrefix("001101")


// MARK: Problem 12: Balanced Subarray Starting From Index 0
/* Goal:  Find longest subarray starting specifically at index 0 with equal 0s and 1s.
   
 Example:
    Input: [0,1,1,0,1]
    Output: 4  // [0,1,1,0]

*/


// MARK: Brute Force
// Time Complexity: O(n) → Single pass through the array/string
// Space Complexity: O(1) → Only counters and maxLength are used
methodLabel("Problem 12: Balanced Subarray Starting From Index 0", .bruteForce)


func balancedSubarrayStartingFromIndex0BF(_ s: [Int]) -> Int {
    var maxLength = 0
    var zeroCount = 0
    var oneCount = 0

    for j in 0..<s.count {
        if s[j] == 0 {
            zeroCount += 1
        } else {
            oneCount += 1
        }

        if zeroCount == oneCount {
            maxLength = j + 1
        }

        print("window: \(s[0...j]), zero: \(zeroCount), one: \(oneCount), maxLength: \(maxLength)")
    }

    return maxLength
}

balancedSubarrayStartingFromIndex0BF([0,1,1,0,1])


// MARK: Prefix Sum – Advanced / Implicit Sliding Window
// Time Complexity: O(n) → Single pass through the array/string
// Space Complexity: O(1) → Only prefixSum  and maxLength are used

methodLabel("Problem 12:  Balanced Subarray Starting From Index 0", .prefixSum)


func balancedSubarrayStartingFromIndex0Prefix(_ s: [Int]) -> Int {
    var maxLength = 0
    var prefixSum = 0
    
    
    for i in 0..<s.count {
        prefixSum += (s[i] == 0 ? -1 : 1)
        
        if prefixSum == 0 {
            maxLength = i + 1
        }
        
        print("window: \(s[0...i]),  preifx sum: \(prefixSum), maxLength: \(maxLength)")
    }
    
    return maxLength
}



balancedSubarrayStartingFromIndex0Prefix([0,1,1,0,1])


// MARK: Problem 13:  Smallest Balanced Subarray
/* Goal:
 Find the shortest subarray with equal 0s and 1s. Always length >= 2.
   
 Example:
    Input: [0,1,0,1]
    Output: 2

*/


// MARK: Brute Force
// Time Complexity: O(n²) → We check every possible subarray (i..j)
// Space Complexity: O(1) → Only using counters (zeroCount, oneCount) and minLength

methodLabel("Problem 13:  Smallest Balanced Subarray", .bruteForce)

func smallestBalancedSubarrayBF(_ s: [Int]) -> Int {
    var minLength = Int.max
    
    for i in 0..<s.count {
        var zeroCount = 0
        var oneCount = 0
        for j in i..<s.count {
            
            if s[j] == 0 {
                zeroCount += 1
            } else {
                oneCount += 1
            }
            
            if zeroCount == oneCount {
                minLength = min(minLength, j - i + 1)
            }
            
            print("window: \(s[0...j]), zero: \(zeroCount), one: \(oneCount), min length: \(minLength)")
        }
    }
    
    return minLength == Int.max ? 0 : minLength
}


smallestBalancedSubarrayBF([0,1,0,1])

// MARK: Prefix Sum – Advanced / Implicit Sliding Window
// Time Complexity: O(n) → single pass through array
// Space Complexity: O(n) → storing first occurrence of each prefix sum

methodLabel("Problem 13:  Smallest Balanced Subarray", .prefixSum)

func smallestBalancedSubarrayPrefix(_ s: [Int]) -> Int {
    var minLength = Int.max
    var prefixSum = 0
    var firstIndexOfPrefix: [Int: Int] = [0: -1]  // base case
    
    for i in 0..<s.count {
        prefixSum += (s[i] == 0 ? -1 : 1)
        
        if let prevIndex = firstIndexOfPrefix[prefixSum] {
            minLength = min(minLength, i - prevIndex)
            print("Index \(i), num: \(s[i]), prefixSum: \(prefixSum), prevIndex: \(prevIndex), minLength: \(minLength)")
        } else {
            firstIndexOfPrefix[prefixSum] = i
            print("Index \(i), num: \(s[i]), prefixSum: \(prefixSum), storing firstIndex: \(i)")
        }
    }
    
    return minLength == Int.max ? 0 : minLength
}

smallestBalancedSubarrayPrefix([0,1,0,1])



// MARK: Problem 15: Longest Balanced Subarray After One Flip
/* Goal:
    You may flip one element (0→1 or 1→0).
    Goal: maximize balanced length.
    Hint: try prefix sum technique + consider both flip possibilities.
   
 Example:
    Input: [1,1,1,0]
    Output: 4  // flipping one '1' makes 2 zeros, 2 ones
*/


// MARK: Brute Force
// Time Complexity: O(n²) → We check every possible subarray (i..j)
// Space Complexity: O(1) → We're keeping track of the counters and max length

methodLabel("Problem 15: Longest Balanced Subarray After One Flip", .bruteForce)


func longestBalancedSubarrayFlippedBF(_ s: [Int]) -> Int {
    var maxLength = 0
    
    for i in 0..<s.count {
        var zeroCount = 0
        var oneCount = 0
        for j in i..<s.count {
            if s[j] == 0 {
                zeroCount += 1
            } else {
                oneCount += 1
            }

            // Flipping a 0→1 or 1→0 changes the difference by 2.
                // 0 → 1 → difference increases by 2
                // 1 → 0 → difference decreases by 2
            //  So a difference of 2 can become 0 with one flip.
            if zeroCount == oneCount || abs(zeroCount - oneCount) == 2 {
                maxLength = max(maxLength, j - i + 1)
            }
            print("window: \(s[i...j]), zeros: \(zeroCount), ones: \(oneCount), maxLength: \(maxLength)")

        }
    }
    return maxLength
}

longestBalancedSubarrayFlippedBF( [1,1,1,0])

// MARK: Prefix Sum – Advanced / Implicit Sliding Window
// Time Complexity: O(n)
// Space Complexity: O(n)

methodLabel("Problem 15: Longest Balanced Subarray After One Flip", .prefixSum)

func longestBalancedSubarrayFlippedPrefix(_ s: [Int]) -> Int {
    var maxLength = 0
    var prefixSum = 0
    var firstIndex: [Int: Int] = [0: -1] // base case
    
    for i in 0..<s.count {
        // Convert 0 -> -1, 1 -> 1
        prefixSum += (s[i] == 0 ? -1 : 1)
        
        // Case 1: already balanced
        if let prevIndex = firstIndex[prefixSum] {
            maxLength = max(maxLength, i - prevIndex)
            print("Index \(i), num: \(s[i]), prefixSum: \(prefixSum), prevIndex: \(prevIndex) → balanced, maxLength: \(maxLength)")
        }
        
        // Case 2: can become balanced by flipping one element
        // Flip 0->1 or 1->0 changes sum by ±2
        if let prevIndexPlus = firstIndex[prefixSum + 2] {
            maxLength = max(maxLength, i - prevIndexPlus)
            print("Index \(i), num: \(s[i]), prefixSum+2: \(prefixSum + 2), prevIndex: \(prevIndexPlus) → one flip, maxLength: \(maxLength)")
        }
        if let prevIndexMinus = firstIndex[prefixSum - 2] {
            maxLength = max(maxLength, i - prevIndexMinus)
            print("Index \(i), num: \(s[i]), prefixSum-2: \(prefixSum - 2), prevIndex: \(prevIndexMinus) → one flip, maxLength: \(maxLength)")
        }
        
        // Store first occurrence only
        if firstIndex[prefixSum] == nil {
            firstIndex[prefixSum] = i
            print("Index \(i), num: \(s[i]), storing firstIndex[\(prefixSum)] = \(i)")
        }
    }
    
    return maxLength
}

longestBalancedSubarrayFlippedPrefix( [1,1,1,0])



/*
 SUMMARY: Choosing the Right Prefix Sum Technique

 ------------------------------------------------
 Use a Dictionary (Hash Map) when you need:
 ------------------------------------------------
    ✔ exact matches of prefix sums
    ✔ subarray sum == target
    ✔ count or find balanced subarrays (e.g., equal 0s and 1s)
    ✔ detect when prefix[j] == prefix[i]

 Why?
    - Dictionary tells you the *first index* where a prefixSum occurs.
    - Useful for conditions involving exact equality.

 Examples:
    - Count subarrays with sum K
    - Longest subarray with sum 0
    - Count balanced 0/1 subarrays
    - Number of subarrays divisible by K

 ------------------------------------------------
 Use Min-Prefix Tracking when you need:
 ------------------------------------------------
    ✔ subarray sum > target
    ✔ subarray sum < target
    ✔ longest subarray with positive total
    ✔ longest subarray where 1s > 0s
    ✔ any condition with inequalities: prefix[j] > prefix[i]

 Why?
    - You must compare the current prefixSum to the *smallest (or largest)* prefix seen so far.
    - A dictionary cannot efficiently answer inequality queries.
    - minPrefix gives the best candidate starting point for a positive sum window.

 Examples:
    - Longest subarray with more 1s than 0s
    - Longest subarray with positive sum
    - Longest subarray with sum > K (after transformation)

 ------------------------------------------------
 KEY IDEA:
    Dictionary → equality (==)
    MinPrefix → inequality (< or >)
 ------------------------------------------------
 */
