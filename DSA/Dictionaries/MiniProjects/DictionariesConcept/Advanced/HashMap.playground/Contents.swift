// ---------------------------------------------------------------
// Hash Map – Group 5.2: Advanced Core Concepts & Problem-Solving Reference
// ---------------------------------------------------------------
// 🎯 Purpose of a Hash Map:
// A Hash Map stores key → value pairs with **O(1) average-time**
// lookup, insertion, and deletion.
// It transforms repeated searching into **direct access**.
//
// 🧠 Core Power Insight:
// Hash Maps convert **state tracking** into constant-time decisions.
// Instead of asking “have I seen this before?” by scanning,
// you ask the map — instantly.
//
// ---------------------------------------------------------------
// 🔑 What Hash Maps Track (Mentally):
// ---------------------------------------------------------------
// • Frequency        → counts, parity, balances
// • State            → seen / not seen, valid / invalid
// • Position         → first seen, last seen, distance checks
// • Relationships    → complements, mappings, dependencies
// • Grouping         → buckets, categories, equivalence classes
//
// ---------------------------------------------------------------
// 📘 Canonical Problem Patterns:
// ---------------------------------------------------------------
// • Frequency Counting
//   - Longest Palindrome
//   - Majority Element
//   - Anagram checks
//
// • Seen / Duplicate Detection
//   - First duplicate
//   - Happy Number
//   - Unique constraints
//
// • Index Storage
//   - Two Sum
//   - Subarray sum equals K
//   - Longest distance problems
//
// • Prefix State Tracking
//   - Prefix sums
//   - Balanced 0/1 arrays
//   - Running totals
//
// • Grouping / Bucketing
//   - Group Anagrams
//   - Emails / domains
//   - Categorization problems
//
// ---------------------------------------------------------------
// 🚀 What Hash Maps Unlock:
// ---------------------------------------------------------------
// • Convert O(n²) brute force → O(n)
// • Enable single-pass solutions
// • Allow early exits
// • Make invisible state explicit
// • Serve as the backbone for:
//     - Sliding Window
//     - Prefix Sum
//     - Greedy optimizations
//
// ---------------------------------------------------------------
// ⚠️ Advanced Notes & Gotchas:
// ---------------------------------------------------------------
// • Keys must conform to Hashable
// • Order is NOT guaranteed
// • Space grows with unique keys
// • Average O(1), worst-case O(n) (rare in practice)
// • Choose HashMap when:
//     - You need memory to save time
//     - You need fast membership checks
//
// ---------------------------------------------------------------
// 🧩 Interview Mental Trigger:
// ---------------------------------------------------------------
// If you are:
// • Re-checking values repeatedly
// • Comparing everything with everything
// • Counting or tracking history
//
// → You are probably missing a Hash Map.
// ---------------------------------------------------------------



import Cocoa


// MARK: Print Statements Helper

enum MethodType: String {
    case bruteForce = "💡 BRUTE FORCE"
    case hashMap = "⚡️ HASH MAP"
}

func methodLabel(_ problem: String,  _ method: MethodType)  {
    return print("\(problem) \(method.rawValue)")
}



// MARK: -  Problem 1: Subarrays With Equal 0s and 1s

/*
 Goal:
 Determine how many contiguous subarrays contain an equal number of 0s and 1s by identifying segments where their contributions balance out over the array.
 Example:
 Input: [0, 1]
 Output: 2
 Explanation:
 Both the entire array [0,1] and the empty-balanced interpretation of cumulative contributions result in equal counts of 0s and 1s.
 */

// MARK: Brute Force
/*
Time Complexity: O(n²)
 → Two nested loops generating all subarrays
Space Complexity: O(1)
 → Only counters used, no extra data structures
*/

methodLabel("Problem 1: Subarrays With Equal 0s and 1s", .bruteForce)

func subarraysWithEqualZeroesAndOnesBF(_ array: [Int]) -> Int {
    var result = 0

    for start in 0..<array.count {
        var zeroCount = 0
        var oneCount = 0

        print("Starting new subarrays at index \(start)")

        for end in start..<array.count {
            let value = array[end]

            if value == 0 {
                zeroCount += 1
            } else {
                oneCount += 1
            }

            print("Subarray \(array[start...end])")
            print(" → Zeros: \(zeroCount), Ones: \(oneCount)")

            if zeroCount == oneCount {
                result += 1
                print(" → Balanced → count = \(result)")
            } else {
                print(" → Not balanced")
            }
        }
    }

    print("\n Total balanced subarrays: \(result)")
    return result
}

subarraysWithEqualZeroesAndOnesBF([0, 1, 0, 1])


// MARK: Hash Map + Prefix Sum
/*
 Time Complexity: O(n)
 → Single pass through the array
 → HashMap lookups and updates are O(1) average

 Space Complexity: O(n)
 → HashMap stores frequency of prefix sums
 → Worst case: all prefix sums are unique
 */


methodLabel("Problem 1: Subarrays With Equal 0s and 1s", .hashMap)

func subarraysWithEqualZeroesAndOnesHM(_ array: [Int]) -> Int {
    var count = 0
     var prefixSum = 0
    // We initialize the prefix sum map with {0:1} so subarrays starting at index 0 are counted.
    // When the prefix sum reaches 0 again, it means the elements in between balance out.”
     var prefixFreq: [Int: Int] = [0: 1]

    for num in array {
        prefixSum += (num == 0 ? -1 : 1)
        
        // If a prefix sum has appeared k times before, then encountering it again creates k new valid subarrays.
        if let freq = prefixFreq[prefixSum] {
            count += freq
        }
        // Otherwise, we increment the freq of current num
        prefixFreq[prefixSum, default: 0] += 1
    }
    
    return count
}


func subarraysWithEqualZeroesAndOnesHMDebug(_ array: [Int]) -> Int {
    var count = 0
    var prefixSum = 0
    
    // Base case:
    // prefixSum 0 appears once before we start
    var prefixFrequency: [Int: Int] = [0: 1]
    
    print("Initial prefixFrequency: \(prefixFrequency)\n")

    for (i, num) in array.enumerated() {
        let value = (num == 0) ? -1 : 1
        prefixSum += value
        
        print("Index \(i): num = \(num) → mapped = \(value)")
        print("Current prefixSum: \(prefixSum)")
        
        if let freq = prefixFrequency[prefixSum] {
            count += freq
            print("→ prefixSum \(prefixSum) seen before \(freq) time(s)")
            print("→ Adding \(freq) to count → count = \(count)")
        } else {
            print("→ prefixSum \(prefixSum) not seen before")
        }
        
        prefixFrequency[prefixSum, default: 0] += 1
        print("Updated prefixFrequency: \(prefixFrequency)\n")
    }
    
    print("✅ Final count of subarrays: \(count)")
    return count
}

subarraysWithEqualZeroesAndOnesHMDebug([0, 1, 0, 1])


// MARK: -  Problem 2: Count Number of Nice Subarrays

/*
 Goal:
     Determine how many contiguous subarrays contain exactly `k` odd numbers by tracking
     cumulative odd counts and identifying segments where the difference between prefix
     sums equals `k`.

 Example:
     Input: nums = [1, 1, 2, 1, 1], k = 3
     Output: 2

 Explanation:
     Convert the array into a parity form where odd numbers contribute +1 and even numbers
     contribute 0. As we traverse the array, we store how many times each prefix odd-count
     has occurred. When the current prefix count minus `k` has appeared before, it means
     there exists a subarray ending at the current index with exactly `k` odd numbers.
 */

// MARK: Brute Force
/*
 Time Complexity: O(n²)
  → Two nested loops generating all contiguous subarrays.
 Space Complexity: O(1)
  → Only simple counters (oddCount, count) are used; no extra data structures.
*/

methodLabel("Problem 2: Count Number of Nice Subarrays", .bruteForce)

func niceSubarraysBF(_ nums: [Int], _ k: Int) -> Int {
    var count = 0
    
    for i in 0..<nums.count {
        var oddCount = 0
        print("\nStarting new subarray at index \(i)")
        for j in i..<nums.count {
            // add 1 (odd) or 0 (even)
            oddCount += nums[j] % 2
            print("Including nums[\(j)] = \(nums[j]), oddCount = \(oddCount)")
            
            if oddCount == k {
                count += 1
                print(" → Found a nice subarray ending at index \(j), total count = \(count)")
            } else if oddCount > k {
                print(" → oddCount exceeded k, break")
                break
            }
        }
    }
    
    print("\nFinal count of nice subarrays: \(count)")
    return count
}

niceSubarraysBF([1, 1, 2, 1, 1], 3)

// MARK: Hash Map + Prefix Sum
/*
 Time Complexity: O(n)
  → Single pass through the array.
 Space Complexity: O(n)
  → Hash map stores frequencies of prefix sums.
*/



methodLabel("Problem 2: Count Number of Nice Subarrays", .hashMap)

func niceSubarraysHM(_ nums: [Int], _ k: Int) -> Int {
    var count: Int = 0
    var prefixSum: Int = 0
    // Initialize to handle subarrays starting at index 0
    // prefix sum 0 has occurred once, meaning if the current prefixSum ever equals k,
    // the subarray from index 0 to current index has exactly k odd numbers
    var prefixFreq: [Int: Int] = [0: 1]
    
    for num in nums {
        // Converts numbers to parity (odd=1, even=0) and keeps a running count of odd numbers
        prefixSum += num % 2
        
        if let freq = prefixFreq[prefixSum - k] {
            count += freq
        }
        
        prefixFreq[prefixSum, default: 0] += 1
    }
    
    
    print("Final count: \(count)")
    return count
}



func niceSubarraysHMDebug(_ nums: [Int], _ k: Int) -> Int {
    var count: Int = 0
    var prefixSum: Int = 0
    var prefixFreq: [Int: Int] = [0: 1]
    
    for (index,num) in nums.enumerated() {
        prefixSum += num % 2
        print("\nIndex \(index), num = \(num), prefixSum (odd count) = \(prefixSum)")
        
        if let freq = prefixFreq[prefixSum - k] {
            count += freq
            print(" → Found \(freq) subarray(s) ending at index \(index) with exactly \(k) odds, total count = \(count)")
        } else {
            print(" → No matching prefixSum found for prefixSum - k = \(prefixSum - k)")
        }
        
        prefixFreq[prefixSum, default: 0] += 1
        print("Updated prefixFreq map: \(prefixFreq)")
    }
    
    print("\nFinal count of nice subarrays: \(count)")
    return count
}


niceSubarraysHMDebug([1, 1, 2, 1, 1], 3)



// MARK: -  Problem 3: Minimum Operations to Reduce X to Zero
/*
 Goal:
     Determine the minimum number of operations to reduce `x` to zero by removing elements
     from either end of the array. Transform the problem into finding the longest contiguous
     subarray in the middle whose sum equals `totalSum - x`. Using a prefix sum and hash map,
     track cumulative sums to efficiently identify the longest valid subarray, so that the
     minimum operations correspond to elements outside this subarray.

 Example:
     Input: nums = [1, 1, 4, 2, 3], x = 5
     Output: 2


 Explanation:
     The total sum of the array is 11. We need a middle subarray summing to 6 (11 - 5).
     The longest such subarray is [1, 1, 4], of length 3.
     Removing elements outside this subarray ([2, 3]) would reduce x to 0.
     The minimum operations from the ends = array length - subarray length = 5 - 3 = 2.
*/


// MARK: Brute Force
/*
 Time Complexity: O(n²)
  → Two nested loops checking all contiguous subarrays to find the longest subarray summing to (totalSum - x).
 Space Complexity: O(1)
  → Only simple counters (currentSum, maxLength) are used; no extra data structures.
*/

methodLabel("Problem 3: Minimum Operations to Reduce X to Zero", .bruteForce)

func minOperationsToReduceXToZeroBF(_ nums: [Int], _ x: Int) -> Int {
    // Haven’t found any subarray whose sum equals target
    var maxLength: Int = -1
    var totalSum: Int = nums.reduce(0, +)
    var target: Int = (totalSum - x)
    
    for i in 0..<nums.count {
        var currentSum = 0
        for j in i..<nums.count {
            currentSum += nums[j]
            
            if currentSum == target {
                maxLength = max(maxLength, j - i + 1)
            }
        }
    }
    
    print("Final max length: \(nums.count - maxLength)")
    return maxLength == -1 ? -1 :  nums.count - maxLength
}

minOperationsToReduceXToZeroBF([1, 1, 4, 2, 3], 5)

// MARK: HashMap + Prefix Sum
/*
 Time Complexity: O(n)
  → Single pass through the array. Each prefix sum is checked and stored in the hash map once.
 Space Complexity: O(n)
  → Hash map stores the first occurrence of each prefix sum.
*/

methodLabel("Problem 3: Minimum Operations to Reduce X to Zero", .hashMap)

func minOperationsToReduceXToZeroHM(_ nums: [Int], _ x: Int) -> Int {
    var maxLength: Int = -1
    var prefixSum: Int = 0
    var prefixIndex: [Int: Int] = [0: -1]
    var totalSum: Int = nums.reduce(0, +)
    var target: Int = (totalSum - x)
    
    for (i, num) in nums.enumerated() {
        prefixSum += num
        
        if let prevIndex = prefixIndex[prefixSum - target] {
            maxLength = max(maxLength, i - prevIndex)
        }
        
        if prefixIndex[prefixSum] == nil {
            prefixIndex[prefixSum] = i
        }
    }
    
    print("Final max length: \(maxLength)")
    return maxLength == -1 ? -1 : nums.count - maxLength
}

func minOperationsToReduceXToZeroHMDebug(_ nums: [Int], _ x: Int) -> Int {
    let totalSum = nums.reduce(0, +)
    let target = totalSum - x
    var prefixSum = 0
    var maxLength = -1
    var prefixIndex: [Int: Int] = [0: -1] // prefixSum 0 occurs before the array starts
    
    for (i, num) in nums.enumerated() {
        prefixSum += num
        print("\nIndex \(i), num = \(num), prefixSum = \(prefixSum)")
        
        if let prevIndex = prefixIndex[prefixSum - target] {
            maxLength = max(maxLength, i - prevIndex)
            print(" → Found subarray summing to target ending at index \(i), length = \(i - prevIndex), maxLength = \(maxLength)")
        } else {
            print(" → No matching prefixSum for prefixSum - target = \(prefixSum - target)")
        }
        
        // Store first occurrence of each prefix sum
        if prefixIndex[prefixSum] == nil {
            prefixIndex[prefixSum] = i
            print(" → Stored prefixSum \(prefixSum) at index \(i) in prefixIndex map")
        }
        
        print(" → Current prefixIndex map: \(prefixIndex)")
    }
    
    let minOperations = nums.count - maxLength
    print("\nFinal max length of middle subarray: \(minOperations)")
    return maxLength == -1 ? -1 : minOperations
}

minOperationsToReduceXToZeroHMDebug([1, 1, 4, 2, 3], 5)
