//  Sliding Window – Group 4: Mixed Subarray and Substring Problems
//  ---------------------------------------------------------------
//
//  Concept Focus:
//  Strengthen your understanding of dynamic window resizing on both
//  numeric arrays and strings. Focus on when to expand or shrink
//  the window to satisfy a target condition.
//
//  Key Idea:
//  Maintain a running state (sum, count, frequency map, etc.) and adjust
//  the window in O(1) or O(log n) time as it slides across the data.
//
//  Pro Tip:
//  Before coding, always decide what the window represents and what
//  triggers its expansion or contraction.

import Cocoa

// MARK: Print Statements Helper

enum MethodType: String {
    case bruteForce = "💡 BRUTE FORCE"
    case slidingWindow = "⚡️ SLIDING WINDOW"
}

func methodLabel(problem: String,  method: MethodType)  {
    return print("\(problem) \(method.rawValue)")
}

// MARK: -  Integer Problems

// MARK: - Smallest Subarray with Sum ≥ Target

/*
 Goal:
    Given an array of positive integers and a target sum, find the length
    of the smallest contiguous subarray whose sum is greater than or equal
    to the target. If no such subarray exists, return 0.
 
 Example:
    Input: target = 7, nums = [2, 3, 1, 2, 4, 3]
    Output: 2
    Explanation: [4, 3] is the smallest subarray with sum ≥ 7.
*/

// MARK: Brute Force
// Time Complexity: O(n²) → nested loops to check all possible subarrays
// Space Complexity: O(1) → only tracking current sum and min length

methodLabel(problem: "Smallest Subarray with Sum ≥ Target", method: .bruteForce)

func smallestSubarraySumGreaterOrEqualTargetBF(_ nums: [Int], _ target: Int) -> Int {
    print("Target: \(target)")
    var minLength = Int.max
    
    for i in 0..<nums.count {
        var currentSum = 0
        
        for j in i..<nums.count {
            currentSum += nums[j]
            
            print("Current subarray: \(Array(nums[i...j])), Current sum: \(currentSum), Min length: \(minLength == Int.max ? "∞" : String(minLength))")
                      
            if currentSum >= target {
                minLength = min(minLength, j - i + 1)
                break  // no need to continue, we found smallest starting at i
            }
          
        }
    }
    
    return minLength == Int.max ? 0 : minLength
   
}
smallestSubarraySumGreaterOrEqualTargetBF([2, 3, 1, 2, 4, 3], 7)

// MARK: Sliding Window
// Time Complexity: O(n) → each element is added and removed at most once
// Space Complexity: O(1) → only tracking current sum and min length

methodLabel(problem: "\nSmallest Subarray with Sum ≥ Target", method: .slidingWindow)

func smallestSubarraySumGreaterOrEqualTargetSW(_ nums: [Int], _ target: Int) -> Int {
    var minLength = Int.max
    
    var start = 0
    var currentSum = 0
    
    for end in 0..<nums.count {
        currentSum += nums[end]
        
        while currentSum >= target {
            minLength = min(minLength, end - start + 1)
            print("Window: \(Array(nums[start...end])), Sum: \(currentSum), Min length: \(minLength == Int.max ? "∞" : String(minLength))")
            currentSum -= nums[start]
            start += 1
        }
    }
    
    return minLength == Int.max ? 0 : minLength
}

smallestSubarraySumGreaterOrEqualTargetSW([2, 3, 1, 2, 4, 3], 7)


// MARK: -  Longest Subarray With Sum ≤ K

/*
 Goal:
    Given an array of positive integers and an integer k, find the length
    of the longest contiguous subarray whose sum is less than or equal to k.
 
 Example:
    Input: nums = [1, 2, 1, 0, 1, 1, 0], k = 4
    Output: 5
    Explanation: [1, 2, 1, 0, 0] (or similar) fits the condition.

*/

// MARK: Brute Force
// Time Complexity: O(n²) → nested loops to check all possible subarrays
// Space Complexity: O(1) → only tracking current sum and max length

methodLabel(problem: "Longest Subarray With Sum ≤ K", method: .bruteForce)

func longestSubarraySumOfKBF(_ nums: [Int], _ k: Int) -> Int {
    var maxLength = 0
    
    for i in 0..<nums.count {
        var currentSum = 0
        
        for j in i..<nums.count {
            currentSum += nums[j]
            
            print("Current subarray: \(Array(nums[i...j])), Current sum: \(currentSum), Max length: \(maxLength)")
            
            if currentSum <= k {
                maxLength = max(maxLength, j - i + 1)
            } else {
                break // stop expanding this subarray since sum exceeded k
            }
            
        }
        
    }
    
    return maxLength
    
}

longestSubarraySumOfKBF([1, 2, 1, 0, 1, 1, 0], 4)

// MARK: Sliding Window
// Time Complexity: O(n) → each element is added and removed at most once
// Space Complexity: O(1) → only tracking current sum and min length

methodLabel(problem: "Longest Subarray With Sum ≤ K", method: .slidingWindow)


func longestSubarraySumOfKSW(_ nums: [Int], _ k: Int) -> Int {
    var maxLength = 0
    
    var start = 0
    var currentSum = 0
    
    for end in 0..<nums.count {
        currentSum += nums[end]
        
        // Shrink the window while sum exceeds k
        while currentSum > k && start <= end {
            currentSum -= nums[start]
            start += 1
        }
        // After shrinking, the window sum is ≤ k, so we can safely update maxLength
        maxLength = max(maxLength, end - start + 1)
        print("Window: \(Array(nums[start...end])), Sum: \(currentSum), Max length: \(maxLength)")
    }
    
    return maxLength
}


longestSubarraySumOfKSW([1, 2, 1, 0, 1, 1, 0], 4)


// MARK: - Longest Subarray with Sum = Target

/*
 Goal:
    Given an array of integers and a target sum, find the length of the
    longest contiguous subarray whose sum equals the target.
 
 Example:
    Input: nums = [1, -1, 5, -2, 3], target = 3
    Output: 4
    Explanation: The subarray [1, -1, 5, -2] sums to 3.

*/

// MARK: Brute Force
// Time Complexity: O(n²) → nested loops to check all possible subarrays
// Space Complexity: O(1) → only tracking current sum and max length

methodLabel(problem: "Longest Subarray with Sum = Target", method: .bruteForce)


func longestSubarraySumOfTargetBF(_ nums:[Int], _ target: Int) -> Int {
    var maxLength = 0
    
    for i in 0..<nums.count {
        var currentSum = 0
        
        for j in i..<nums.count {
            currentSum += nums[j]

            print("Current subarray: \(Array(nums[i...j])), Current sum: \(currentSum), Max length: \(maxLength)")
            
            if currentSum == target {
                maxLength = max(maxLength, j - i + 1)
            }
        }
    }
    
    return maxLength
}

longestSubarraySumOfTargetBF([1, -1, 5, -2, 3], 3)

// MARK: Sliding Window
// Time Complexity: O(n) → each element is added and removed at most once
// Space Complexity: O(n)


methodLabel(problem: "Longest Subarray with Sum = Target", method: .slidingWindow)

func longestSubarraySumOfTargetSW(_ nums: [Int], _ target: Int) -> Int {
    var prefixSum = 0
    var maxLength = 0
    var sumIndices: [Int: Int] = [:]  // prefixSum -> first index
    
    for (i, num) in nums.enumerated() {
        prefixSum += num
        
        // Case 1: subarray from start sums to target
        if prefixSum == target {
            maxLength = max(maxLength, i + 1)
        }
        
        // Case 2: subarray somewhere in middle sums to target
        if let prevIndex = sumIndices[prefixSum - target] {
            maxLength = max(maxLength, i - prevIndex)
        }
        
        // Store first occurrence of prefixSum
        if sumIndices[prefixSum] == nil {
            sumIndices[prefixSum] = i
        }
        
        print("Index: \(i), Num: \(num), PrefixSum: \(prefixSum), MaxLength: \(maxLength), Map: \(sumIndices)")
    }
    
    return maxLength
}

longestSubarraySumOfTargetSW([1, -1, 5, -2, 3], 3)

// MARK: -  Count of Subarrays with Sum = Target

/*
 Goal:
    Count all contiguous subarrays that sum exactly to a given target.
 

 Example:
    Input: nums = [1, 1, 1], target = 2
    Output: 2
    Explanation: The subarrays [1,1] appear twice.

*/

// MARK: Brute Force
// Time Complexity: O(n²) → nested loops to check all possible subarrays
// Space Complexity: O(1) → only tracking current sum and count

methodLabel(problem: "Count of Subarrays with Sum = Target", method: .bruteForce)

func countSubarraysSumOfTargetBF(_ nums: [Int], _ target: Int) -> Int {
    var count = 0
    
    for i in 0..<nums.count{
        var currentSum = 0
        for j in i..<nums.count {
            currentSum += nums[j]
            
            print("Current subarray: \(Array(nums[i...j])), Current sum: \(currentSum), count: \(count)")
            
            if currentSum == target {
                count += 1
            }
        }
    }
    return count
}

countSubarraysSumOfTargetBF([1, 1, 1], 2)

// MARK: Sliding Window
// Time Complexity: O(n) → each element is added and removed at most once
// Space Complexity: O(n) → using hash map (sumFrequency) to store counts of prefix sums.

methodLabel(problem: "Count of Subarrays with Sum = Target", method: .slidingWindow)

func countSubarraysSumOfTargetSW(_ nums: [Int], _ target: Int) -> Int {
    var count = 0
    var prefixSum = 0
    var sumFrequency: [Int: Int] = [0:1] // // prefix sum 0 has one occurrence
    
    for (i, num) in nums.enumerated() {
        prefixSum += num
        
        // Check if there's a prefix sum that forms a valid subarray
        if let freq = sumFrequency[prefixSum - target] {
            count += freq
        }
        
        sumFrequency[prefixSum, default: 0] += 1
        
       
        print("Index: \(i), Num: \(num), PrefixSum: \(prefixSum), count: \(count), Map: \(sumFrequency)")
    }
    
    return count
}

countSubarraysSumOfTargetSW([1, 2, 1, 2, 1], 3)


// MARK: - Longest Subarray with Sum Divisible by K

/*
 Goal:
    Given an array of integers and integer k, find the length of the
    longest contiguous subarray where the sum is divisible by k
 
 Example:
    Input: nums = [2, 7, 6, 1, 4, 5], k = 3
    Output: 4
    Explanation: Subarray [7,6,1,4] sums to 18, divisible by 3.


*/


// MARK: Brute Force
// Time Complexity: O(n²) → nested loops to check all possible subarrays
// Space Complexity: O(1) → only tracking current sum and max length

methodLabel(problem: "Longest Subarray with Sum Divisible by K", method: .bruteForce)

func longestSubarraySumDivisibleByKBF(_ nums: [Int], _ k: Int) -> Int {
    var maxLength = 0
    
    for i in 0..<nums.count {
        var currentSum = 0
        
        for j in i..<nums.count {
            currentSum += nums[j]
            
            print("Current subarray: \(Array(nums[i...j])), Current sum: \(currentSum), max length: \(maxLength), divisible by \(k): \(currentSum % k == 0)")
            
            if currentSum % k == 0 {
                maxLength = max(maxLength, j - i + 1)
            }
        }
    }
    
    return maxLength
}

longestSubarraySumDivisibleByKBF([2, 7, 6, 1, 4, 5], 3)


// MARK: Sliding Window
// Time Complexity: O(n) → each element is added and removed at most once
// Space Complexity: O(min(n, k)) → storing at most k distinct remainders (0 to k-1)

methodLabel(problem: "Longest Subarray with Sum Divisible by K", method: .slidingWindow)

func longestSubarraySumDivisibleByKSW(_ nums: [Int], _ k: Int) -> Int {
    var maxLength = 0
    var prefixSum = 0
    
    // Map to store the first occurrence of each remainder of prefix sum modulo k.
    // Base case: remainder 0 at index -1, which allows subarrays starting from index 0.
    var sumIndices: [Int: Int] = [0: -1]
    
    for (i, num) in nums.enumerated() {
        prefixSum += num
        
        // Normalize remainder to handle negative numbers
        // ((prefixSum % k) + k) % k ensures remainder is always in 0...(k-1)
        let remainder = ((prefixSum % k) + k) % k
        
        // If this remainder has been seen before, the subarray between previous index + 1 and current index
        // has a sum divisible by k. Update maxLength accordingly.
        if let prevIndex = sumIndices[remainder] {
            maxLength = max(maxLength, i - prevIndex)
        }
        
        // Only store the first occurrence of each remainder.
        // This ensures we get the longest possible subarray for that remainder.
        if sumIndices[remainder] == nil {
            sumIndices[remainder] = i
        }
        
        print("Index: \(i), Num: \(num), PrefixSum: \(prefixSum), Max length: \(maxLength), Map: \(sumIndices)")
    }
    
    return maxLength
}

longestSubarraySumDivisibleByKSW([2, 7, 6, 1, 4, 5], 3)


// MARK: - Longest Subarray with Sum Less Than Target

/*
 Goal:
    Find the longest contiguous subarray whose sum is strictly less than a given target value.
 
 Example:
    Input: nums = [1, 2, 3, 4, 5], target = 11
    Output: 4
    Explanation: [1, 2, 3, 4] sums to 10, which is < 11.

*/


// MARK: Brute Force
// Time Complexity: O(n²) → nested loops to check all possible subarrays
// Space Complexity: O(1) → only tracking current sum and max length

methodLabel(problem: "Longest Subarray with Sum Less Than Target", method: .bruteForce)

func longestSubarraySumLessThanTargetBF(_ nums: [Int], _ target: Int) -> Int {
    var maxLength = 0
    
    for i in 0..<nums.count{
        var currentSum = 0
        for j in i..<nums.count {
            currentSum += nums[j]
            
            print("current window: \(Array(nums[i...j])), current sum: \(currentSum), max length: \(maxLength)")
            
            if currentSum < target{
                maxLength = max(maxLength, j - i + 1)
            }
            
        }
    }
    
    return maxLength
}

longestSubarraySumLessThanTargetBF([1, 2, 3, 4, 5], 11)


// MARK: Sliding Window
//Time Complexity: O(n) → each element is added once and removed at most once
//Space Complexity: O(1) → only tracking currentSum, start, and maxLength

methodLabel(problem: "Longest Subarray with Sum Less Than Target", method: .slidingWindow)


func longestSubarraySumLessThanTargetSW(_ nums: [Int], _ target: Int) -> Int {
    var maxLength = Int.min
    var currentSum = 0
    var start = 0
    
    for end in 0..<nums.count {
        currentSum += nums[end]
        
        // Shrink window if current sum is greater or equal to given target
        while currentSum >= target {
            currentSum -= nums[start]
            start += 1
        }
        // After shrinking, the window sum is < target, so we can safely update maxLength
        maxLength = max(maxLength, end - start + 1)
        
        print("Window: \(Array(nums[start...end])), Sum: \(currentSum), Max length: \(maxLength == Int.min ? "∞" : String(maxLength))")
        
    }
    return maxLength == Int.min ? 0 : maxLength
    
}


longestSubarraySumLessThanTargetSW([1, 2, 3, 4, 5], 11)


// MARK: - String Problems

// MARK: -  Longest Substring Without Repeating Characters

/*
 Goal:
    Given a string s, find the length of the longest substring without any repeating characters.
  
 Example:
    Input: s = "abcabcbb"
    Output: 3
    Explanation: "abc" is the longest substring with unique characters.

*/

// MARK: Brute Force
// Time Complexity: O(n²) → nested loops to check all possible subarrays
// Space Complexity: O(n) → Using a Set to track seen characters, converting string to an array of chracters


methodLabel(problem: "Longest Substring Without Repeating Characters", method: .bruteForce)

func longestDistinctSubstringBF(_ s: String) -> Int {
    var maxLength = 0
    let chars = Array(s)
    
    for i in 0..<chars.count {
        var seen: Set<Character> = []
        for j in i..<chars.count {
            let ch = chars[j]
            
            print("current window: \(Array(chars[i...j])), current char: \(ch), seen: \(seen), max length: \(maxLength)")
            
            if seen.contains(ch) {
                break
            }
            seen.insert(ch)
            maxLength = max(maxLength,  j - i + 1)
        }
    }
    
    
    return maxLength
}

longestDistinctSubstringBF("abcabcbb")

// MARK: Sliding Window
// Time Complexity: O(n) — each character is added and removed at most once.
// Space Complexity: O(n) — for the seen set.
methodLabel(problem: "Longest Substring Without Repeating Characters", method: .slidingWindow)

func longestDistinctSubstringSW(_ s: String) -> Int {
    var maxLength = 0
    var seen: Set<Character> = []
    var start  = 0
    var chars = Array(s)
    
    for end in 0..<chars.count {
        let ch = chars[end]
        
        // Shrink window from the left until the current character is unique
        while seen.contains(ch) {
            seen.remove(chars[start])
            start += 1
        }
        // Insert current character and update max length of substring
        seen.insert(ch)
        maxLength = max(maxLength, end - start + 1)

        print("Window: \(Array(chars[start...end])), current char: \(ch), seen: \(seen), Max length: \(maxLength)")
    }
    
    
    return maxLength
}

longestDistinctSubstringBF("abcabcbb")


// MARK: - Longest Substring with At Most K Distinct Characters

/*
 Goal:
    Given a string s and integer k, return the length of the longest substring that contains at most k distinct characters.
 Example:
    Input: s = "eceba", k = 2
    Output: 3
    Explanation: "ece" is the longest substring with 2 distinct characters.
*/

// MARK: Brute Force
// Time Complexity: O(n²) → nested loops to check all possible subarrays
// Space Complexity: O(n) → Using a Set to track seen characters, converting string to an array of chracters


methodLabel(problem: "Longest Substring with At Most K Distinct Characters", method: .bruteForce)

func longestKDistinctCharactersBF(_ s: String, _ k: Int) -> Int {
    var maxLength = 0
    var chars = Array(s)
    
    for i in 0..<chars.count{
        var seen: Set<Character> = []
        
        for j in i..<chars.count {
            let ch = chars[j]
            seen.insert(ch)
            
            print("current window: \(Array(chars[i...j])), current char: \(ch), seen: \(seen), max length: \(maxLength), current length > k: \( j - i + 1 > k) ")

            // If more than k distinct characters, stop expanding
            if seen.count > k {
                break
            }
            maxLength = max(maxLength, j - i + 1)
        }
    }
    
    
    return maxLength
    
    
}

longestKDistinctCharactersBF("eceba", 2)

// MARK: Sliding Window
// Time Complexity: O(n) — each character is added and removed at most once.
// Space Complexity: O(k) — at most k distinct characters stored in the charCount map.

methodLabel(problem: "Longest Substring with At Most K Distinct Characters", method: .slidingWindow)


func longestKDistinctCharactersSW(_ s: String, _ k: Int) -> Int {
    var maxLength = 0
    var charCount: [Character: Int] = [:]
    var start = 0
    let chars = Array(s)
    
    for end in 0..<chars.count {
        let ch = chars[end]
        charCount[ch, default: 0] += 1
        
        if charCount.count > k {
            charCount[chars[start]]! -= 1
            if charCount[chars[start]] == 0 {
                charCount.removeValue(forKey: chars[start])
            }
            start += 1
        }
        
        maxLength = max(maxLength, end - start + 1)
        
        print("Window: \(Array(chars[start...end])), current char: \(ch), map: \(charCount), Max length: \(maxLength)")
    }
    
    return maxLength
}

longestKDistinctCharactersSW("eceba", 2)


// MARK: -  Longest Substring with Exactly K Distinct Characters

/*
 Goal:
    Given a string s and integer k, return the length of the longest substring containing exactly k distinct characters.
 
 Example:
    Input: s = "aaabbcc", k = 2
    Output: 5
    Explanation: "aaabb" has exactly 2 distinct characters.
*/

// MARK: Brute Force
// Time Complexity: O(n²) → nested loops to check all possible subarrays
// Space Complexity: O(n) → Using a map to track characters frequencies, converting string to an array of chracters

methodLabel(problem: "Longest Substring with Exactly K Distinct Characters", method: .bruteForce)


func  longestExactKDistinctCharactersBF(_ s: String, _ k: Int) -> Int {
    var maxLength  = 0
    
    let chars = Array(s)
    
    for i in 0..<chars.count {
        var charCount: [Character: Int] = [:]
        
        for j in i..<chars.count {
            let ch = chars[j]
            charCount[ch, default: 0] += 1
            
            print("current window: \(Array(chars[i...j])), current char: \(ch), map: \(charCount), max length: \(maxLength)")
            
            if charCount.count > k{
                break
            }
            
            if charCount.count == k {
                maxLength = max(maxLength, j - i + 1)
            }
            
        }
        
    }
    
    return maxLength
}

longestExactKDistinctCharactersBF("aaabbcc", 2)



// MARK: Sliding Window
// Time Complexity: O(n) — each character is processed at most twice (added and removed).
// Space Complexity: O(k) — at most k distinct characters stored in the map.

methodLabel(problem: "Longest Substring with Exactly K Distinct Characters", method: .slidingWindow)


func  longestExactKDistinctCharactersSW(_ s: String, _ k: Int) -> Int {
    var maxLength = 0
    var chars = Array(s)
    var windowStart = 0
    var charCount: [Character: Int] = [:]
    
    for windowEnd in 0..<chars.count {
        let ch = chars[windowEnd]
        charCount[ch, default:0] += 1
        
        if charCount.count > k {
            charCount[chars[windowStart]]! -= 1
            
            if charCount[chars[windowStart]] == 0 {
                charCount.removeValue(forKey: chars[windowStart])
            }
        }
        
        if charCount.count == k {
            maxLength = max(maxLength, windowEnd - windowStart + 1)
        }
        
        print("Window: \(Array(chars[windowStart...windowEnd])), current char: \(ch), map: \(charCount), Max length: \(maxLength)")
        
    }
    
    return maxLength
}

longestExactKDistinctCharactersSW("aaabbcc", 2)

