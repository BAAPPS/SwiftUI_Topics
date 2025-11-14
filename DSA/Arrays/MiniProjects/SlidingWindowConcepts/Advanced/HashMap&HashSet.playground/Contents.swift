//  Sliding Window – Group 6: Advanced – HashMap & HashSet
// ---------------------------------------------------------------
//
// 🎯 Concept Focus:
// - Use **HashMap / Dictionary** for constant-time key-value lookup, counting, and tracking last seen positions.
// - Use **HashSet** to track unique elements efficiently.
//
// 💡 Key Idea:
// - **HashMap**: Map keys to values, counts, or indices to quickly answer queries like frequency, last occurrence, or sums.
// - **HashSet**: Track presence of elements, detect duplicates, or maintain a sliding set of unique values.
//
// 🧩 Pro Tips:
// 1. When counting occurrences in an array, use a dictionary: dict[num, default:0] += 1`
// 2. For uniqueness or “seen before” checks, HashSet is ideal: set.contains(num)` O(1)
// 3. Combine with sliding window for problems like longest substring with unique chars or subarrays with exactly K distinct elements.
//
// ⚡ Suitable Problems:
// - Two Sum variations
// - Longest substring without repeating characters
// - Subarray sums equal to target (prefix sum + hashmap)
// - Count distinct elements in a window
// - First unique / first repeating element in a stream
// - Anagram finding (use counts in HashMap)
// - Detect duplicates or almost duplicates
//
// 🔑 Why It Works:
// - **O(1) amortized** insert, remove, and lookup
// - Allows **frequency/count tracking** without scanning array repeatedly
// - Ideal for **variable-size windows** or streaming data
//
// 🧩 HashMap / HashSet Sliding Window Logic:
//
// 1. For fixed/variable window problems, track counts in a dictionary.
// 2. Increment count when adding new element to window.
// 3. Decrement count (and remove key if zero) when removing element from window.
// 4. Use set for “seen before” checks or uniqueness constraints.
// 5. Answer query (max length, count, sum, first unique, etc.) once window satisfies conditions.

import Cocoa

// MARK: Print Statements Helper

enum MethodType: String {
    case bruteForce = "💡 BRUTE FORCE"
    case slidingWindow = "⚡️ SLIDING WINDOW"
}

func methodLabel(_ problem: String,  _ method: MethodType)  {
    return print("\(problem) \(method.rawValue)")
}


// MARK: -  Problem 1: Longest Substring Without Repeating Characters

/* Goal:
 Given a string s, find the length of the longest substring without repeating characters.
 Example:
 Input: s = "abcabcbb"
 Output: 3
 Explanation: "abc" is the longest substring with unique characters.
 */


// MARK: Brute Force
// Time Complexity: O(n²) → nested loops to check all possible subarrays
// Space Complexity: O(n) → Using a Set to track seen characters, converting string to an array of chracters



methodLabel("Problem 1: Longest Substring Without Repeating Characters", .bruteForce)

func longestSubstringWithoutRepeatingCharactersBF(_ s: String) -> Int {
    var maxLength = Int.min
    var chars = Array(s)
    
    for i in 0..<chars.count {
        var seen: Set<Character> = []
        
        for j in i..<chars.count {
            let ch = chars[j]
            
            print("window: \(chars[i...j]), seen: \(seen), max length: \(maxLength)")
            
            if seen.contains(ch) {
                break
            }
            
            seen.insert(ch)
            maxLength = max(maxLength, j - i + 1)
        }
    }
    
    
    return maxLength
}

longestSubstringWithoutRepeatingCharactersBF("abcabcbb")

// MARK: Sliding Window
// Time Complexity: O(n) — each character is added and removed at most once.
// Space Complexity: O(n) — for the seen set.

methodLabel("Longest Substring Without Repeating Characters", .slidingWindow)

func longestSubstringWithoutRepeatingCharactersSW(_ s: String) -> Int {
    var maxLength = Int.min
    var chars = Array(s)
    
    var seen: Set<Character> = []
    
    var start = 0
    
    for end in 0..<chars.count {
        let ch = chars[end]
        
        while seen.contains(ch) {
            seen.remove(chars[start])
            start += 1
        }
        
        seen.insert(ch)
        maxLength = max(maxLength, end - start + 1)
        
        print("Window: \(Array(chars[start...end])), current char: \(ch), seen: \(seen), Max length: \(maxLength)")
        
    }
    
    return maxLength
}


longestSubstringWithoutRepeatingCharactersSW("abcabcbb")


// MARK: -  Problem 2: Longest Substring with At Most K Distinct Characters

/* Goal:
 Given a string s and integer k, return the length of the longest substring containing at most k distinct characters.
 Example:
 Input: s = "eceba", k = 2
 Output: 3
 Explanation: "ece" has at most 2 distinct characters.
 
 */


// MARK: Brute Force
// Time Complexity: O(n²) → nested loops to check all possible subarrays
// Space Complexity: O(n) → Using a Set to track seen characters, converting string to an array of chracters

methodLabel("Problem 2: Longest Substring with At Most K Distinct Characters", .bruteForce)


func longestSubstringWithAtMostKDistinctCharactersBF(_ s: String, _ k: Int) -> Int {
    var maxLength = Int.min
    var chars = Array(s)
    
    for i in 0..<chars.count {
        var seen: Set<Character> = []
        for j in i..<chars.count {
            let ch = chars[j]
            
            seen.insert(ch)
            
            print("current window: \(chars[i...j]), current char: \(ch), seen: \(seen), max length: \(maxLength)")
            
            if seen.count > k {
                break
            }
            
            maxLength = max(maxLength, j - i + 1)
            
        }
        
    }
    return maxLength
}

longestSubstringWithAtMostKDistinctCharactersBF("eceba", 2)

// MARK: Sliding Window
// Time Complexity: O(n) — each character is added and removed at most once.
// Space Complexity: O(k) — at most k distinct characters stored in the charCount map.

methodLabel("Problem 2: Longest Substring with At Most K Distinct Characters", .slidingWindow)

func longestSubstringWithAtMostKDistinctCharactersSW(_ s: String, _ k: Int) -> Int {
    
    var maxLength = 0
    var i = 0
    var frequency: [Character: Int] = [:]
    let chars = Array(s)
    
    for j in 0..<chars.count {
        let ch = chars[j]
        frequency[ch, default: 0] += 1
        
        if frequency.count > k {
            frequency[chars[i]]! -= 1
            if frequency.count == 0 {
                frequency.removeValue(forKey: chars[i])
            }
            i += 1
        }
        
        maxLength = max(maxLength, j - i + 1)
        
        print("Window: \(Array(chars[i...j])), current char: \(ch), map: \(frequency), Max length: \(maxLength)")
        
        
    }
    return maxLength
}


longestSubstringWithAtMostKDistinctCharactersSW("eceba", 2)


// MARK: -  Problem 3: Minimum Window Substring

/* Goal:
 Given strings s and t, find the smallest substring of s that contains all characters of t. Return "" if no such window exists.
 Example:
 Input: s = "ADOBECODEBANC", t = "ABC"
 Output: "BANC"
 
 */


// MARK: Brute Force
// Time Complexity: O(n²) — nested loops to check all possible windows
// Space Complexity: O(n + |t|) — array conversion + hashmaps to track frequencies

methodLabel("Problem 3: Minimum Window Substring", .bruteForce)

func minimumSubstringWindowBF(_ s: String, _ t: String) -> String {
    guard !s.isEmpty, !t.isEmpty else { return "" }
    
    let charS = Array(s)
    let charT = Array(t)
    var result = ""
    var minLength = Int.max
    var mapT: [Character: Int] = [:]
    
    for i in 0..<charT.count {
        let ch = charT[i]
        mapT[ch, default: 0] += 1
    }
    print("T map: \(mapT)")
    
    for i in 0..<charS.count {
        var mapS: [Character: Int] = [:]
        var formed = 0
        let mapTCount = mapT.count
        
        for j in i..<charS.count {
            let ch = charS[j]
            mapS[ch, default: 0] += 1
            
            if let requiredCount = mapT[ch], mapS[ch] == requiredCount {
                formed += 1
            }
            
            print("window: \(charS[i...j]), mapS: \(mapS), mapT: \(mapT), result: \(result)")
            
            if formed == mapTCount {
                let windowLength = j - i + 1
                if windowLength < minLength {
                    minLength = windowLength
                    result = String(charS[i...j])
                }
                break // move to next starting i
            }
        }
    }
    
    return result
}


minimumSubstringWindowBF("ADOBECODEBANC" , "ABC")


// MARK: Sliding Window
// Time Complexity: O(n²) → nested loops to check all possible subarrays
// Space Complexity: O(n) → Using a Set to track seen characters, converting string to an array of chracters

methodLabel("Problem 3: Minimum Window Substring", .slidingWindow)

func minimumSubstringWindowSW(_ s: String, _ t: String) -> String {
    guard !s.isEmpty, !t.isEmpty else { return "" }
    
    let charS = Array(s)
    let charT = Array(t)
    
    var mapT: [Character: Int] = [:]
    var windowCounts: [Character: Int] = [:]
    var result = ""
    var minLength = Int.max
    
    for ch in charT {
        mapT[ch, default: 0] += 1
    }
    
    var formed = 0
    let required = mapT.count
    var left = 0
    
    for right in 0..<charS.count {
        let ch = charS[right]
        windowCounts[ch, default: 0] += 1
        
        if let requiredCount = mapT[ch], windowCounts[ch] == requiredCount {
            formed += 1
        }
        
        print("Window right: \(right), char: \(ch), windowCounts: \(windowCounts), formed: \(formed)")
        
        // Try to shrink the window from the left while it is valid
        while formed == required {
            let windowLength = right - left + 1
            if windowLength < minLength {
                minLength = windowLength
                result = String(charS[left...right])
            }
            
            let leftChar = charS[left]
            windowCounts[leftChar]! -= 1
            if let requiredCount = mapT[leftChar], windowCounts[leftChar]! < requiredCount {
                formed -= 1
            }
            
            print("Shrink window -> left: \(left), char removed: \(leftChar), windowCounts: \(windowCounts), formed: \(formed), current result: \(result)")
            
            left += 1
        }
    }
    
    return result
}

// Example
let res = minimumSubstringWindowSW("ADOBECODEBANC", "ABC")
print("Final result: \(res)")



// MARK: - Problem 4: Check Inclusion (Permutation in String)

/* Goal:
 Given two strings s1 and s2, return true if s2 contains a permutation of s1.
 Example:
 Input: s1 = "ab", s2 = "eidbaooo"
 Output: true
 Explanation: "ba" is a permutation of "ab" present in s2.
 
 */


// MARK: Brute Force
//Time Complexity: O(n * m) → n = length of s2, m = length of s1
//Space Complexity: O(m) → maps store up to s1.count characters

methodLabel("Problem 4: Check Inclusion (Permutation in String)", .bruteForce)


func checkInclusionBF(_ s1: String, _ s2: String) -> Bool {
    if s1.count > s2.count { return false }
    
    let charS1 = Array(s1)
    let charS2 = Array(s2)
    
    // Build frequency map for s1
    var s1Map: [Character: Int] = [:]
    for ch in charS1 {
        s1Map[ch, default: 0] += 1
    }
    
    // Check each window in s2
    for i in 0...(charS2.count - charS1.count) {
        var s2Map: [Character: Int] = [:]
        for j in i..<(i + charS1.count) {
            let ch = charS2[j]
            s2Map[ch, default: 0] += 1
        }
        
        print("window: \(charS2[i..<(i + charS1.count)]), s1 map: \(s1Map), s2 map: \(s2Map), match: \(s1Map == s2Map)")
        
        if s1Map == s2Map {
            return true
        }
    }
    
    return false
}

checkInclusionBF("ab", "eidbaooo") // true


// MARK: Sliding Window
//Time Complexity: O(m) — we visit each character once, updating the window map incrementally.
//Space Complexity: O(1) auxiliary — maps store at most 26 letters (if lowercase English letters), otherwise O(n) in general.

methodLabel("Problem 4: Check Inclusion (Permutation in String)", .slidingWindow)

func checkInclusionSW(_ s1: String, _ s2: String) -> Bool {
    let n = s1.count
    let m = s2.count
    if n > m { return false }
    
    let charS1 = Array(s1)
    let charS2 = Array(s2)
    
    // Frequency map for s1
    var s1Map: [Character: Int] = [:]
    for ch in charS1 {
        s1Map[ch, default: 0] += 1
    }
    
    // Sliding window map
    var windowMap: [Character: Int] = [:]
    
    for i in 0..<m {
        let ch = charS2[i]
        windowMap[ch, default: 0] += 1
        
        // Shrink the window if its size exceeds s1.count
        if i >= n {
            let leftChar = charS2[i - n]
            windowMap[leftChar]! -= 1
            if windowMap[leftChar] == 0 {
                windowMap.removeValue(forKey: leftChar)
            }
        }
        
        // Check if current window matches s1Map
        if windowMap == s1Map {
            print("Matching window: \(charS2[(i - n + 1)...i]), windowMap: \(windowMap)")
            return true
        }
    }
    
    return false
}

checkInclusionSW("ab", "eidbaooo") // true


// MARK: - Problem 5: Count Occurrences of Anagrams

/* Goal:
 Given a text and a pattern, count the number of substrings of text that are anagrams of the pattern.
 Example:
 Input: text = "forxxorfxdofr", pattern = "for"
 Output: 3
 Explanation: "for", "orf", and "ofr" are anagrams.
 */


// MARK: Brute Force
//Time Complexity: O(n * k) because for each starting point you build a window of size k; Worst-case → O(n²)
//Space Complexity: O(1) or O(k) for the window map; Pattern map is also O(k)


methodLabel("Problem 5: Count Occurrences of Anagrams", .bruteForce)


func countAnagramsBF(_ text: String, _ pattern: String) -> Int {
    var count = 0
    var patternMap: [Character: Int] = [:]
    let textArray = Array(text)
    let patternArray = Array(pattern)
    let k = patternArray.count
    
    if textArray.count < k { return 0 }
    
    for char in pattern {
        patternMap[char, default: 0] += 1
    }
    
    // Only valid windows
    for i in 0...(textArray.count - k) {
        var windowMap: [Character: Int] = [:]
        // Fixed-size window
        for j in i..<(i + k) {
            let ch = textArray[j]
            windowMap[ch, default: 0] += 1
        }
        
        print("window: \(textArray[i..<i+k]), patternMap: \(patternMap), windowMap: \(windowMap), count: \(count)")
        
        
        if windowMap == patternMap {
            count += 1
        }
    }
    return count
}

countAnagramsBF("forxxorfxdofr", "for")


// MARK: Sliding Winodw
//Time Complexity: O(n) — each character added once, removed once
// Space Complexity: O(k) — map sizes depend on pattern length


methodLabel("Problem 5: Count Occurrences of Anagrams", .slidingWindow)


func countAnagramsSW(_ text: String, _ pattern: String) -> Int {
    var count = 0
    var patternMap: [Character: Int] = [:]
    var textMap: [Character: Int] = [:]
    var start = 0
    let textArray = Array(text)
    let patternArray = Array(pattern)
    let k = patternArray.count
    
    if textArray.count < k { return 0 }
    
    for char in pattern {
        patternMap[char, default: 0] += 1
    }
    
    
    for end in 0..<textArray.count  {
        let ch = textArray[end]
        textMap[ch, default: 0] += 1
        
        print("Added \(ch) → textMap:", textMap)
        
        
        // If window size > k, shrink it
        if end - start + 1 > k {
            let leavingCh = textArray[start]
            textMap[leavingCh]! -= 1
            
            print("Removed \(leavingCh) → textMap:", textMap)
            
            if textMap[leavingCh] == 0 {
                textMap.removeValue(forKey: leavingCh)
            }
            
            start += 1
        }
        
        // When window size == k → compare
        if end - start + 1 == k {
            let window = String(textArray[start...end])
            
            print("Window [\(start)-\(end)] → \"\(window)\"")
            print("Compare: textMap == patternMap ?", textMap == patternMap)
            
            if textMap == patternMap {
                count += 1
                print("→ MATCH FOUND! Count now:", count)
            }
        }
    }
    return count
}


countAnagramsSW("forxxorfxdofr", "for")


// MARK: - Problem 6: Longest Substring with Exactly K Distinct Characters

/* Goal:
 Given a string s and integer k, return the length of the longest substring containing exactly k distinct characters.
 Example:
 Input: s = "aaabbcc", k = 2
 Output: 5
 Explanation: "aaabb" has exactly 2 distinct characters.
 
 */


// MARK: Brute Force
//Time Complexity: O(n²) — For each starting index i of the substring, we potentially scan up to n characters to build a window and check distinct characters.
//Space Complexity: O(k) — Each window uses a set or map to track distinct characters.

methodLabel("Problem 6: Longest Substring with Exactly K Distinct Characters", .bruteForce)


func longestKDistinctCharactersBF(_ s: String, _ k: Int) -> Int {
    var maxLength = 0
    let chars = Array(s)
    
    for i in 0..<chars.count {
        var map: [Character: Int] = [:]
        
        for j in i..<chars.count {
            let ch = chars[j]
            
            print("Window: \(chars[i...j]), Map: \(map)")
            map[ch, default: 0] += 1
            
            let distinct = map.keys.count
            
            
            if map.count == k {
                let length = j - i + 1
                maxLength = max(maxLength, length)
                print("✓ VALID (exactly \(k) distinct) → new max: \(maxLength)")
            }
            
            if distinct > k {
                print("✗ TOO MANY distinct → break")
                break
            }
            
        }
    }
    
    return maxLength
}

longestKDistinctCharactersBF("aaabbcc", 2)

// MARK: Sliding Winodw
// Time Complexity: O(n) — Each character is added and removed at most once from the map while sliding the window.
// Space Complexity: O(k) — The map stores at most k + 1 distinct characters at any time (while the window may temporarily grow)
// In worst case, the hash map grows to O(k).
                                                                            
methodLabel("Problem 6: Longest Substring with Exactly K Distinct Characters", .slidingWindow)


func longestKDistinctCharactersSW(_ s: String, _ k: Int) -> Int {
    
    var maxLength = 0
    var map: [Character: Int] = [:]
    var start = 0
    let chars = Array(s)
    
    for end in 0..<chars.count {
        let ch = chars[end]
        map[ch, default: 0] +=  1
        
        print("Added \(ch) → map:", map)
        
        /*
         Will cause a fatal error: Index out of range
         Sliding window is dynamic — every shrink changes the map
         Freezing values = drifting window = pointer error = crash.
         */
//        let distinct = map.count

        // shrink until valid
        while map.count > k{
            let leavingCh = chars[start]
            map[leavingCh, default: 0] -= 1
            print("Removed \(leavingCh) → map:", map)
            if map[leavingCh] == 0 {
                map.removeValue(forKey: leavingCh)
            }
            start += 1
        }
        
        // Now window must have <= k distinct
        if map.count == k {
            let length = end - start + 1
            maxLength = max(maxLength, length)
            print("✓ VALID → maxLength =", maxLength)
        }
    }
    
    
    
    return maxLength
}

longestKDistinctCharactersSW("aaabbcc", 2)


// MARK: -  Problem 7: Sliding Window Unique Characters

/* Goal:
    Given a string s, find the length of the longest substring containing all unique characters. Use a HashSet to track uniqueness within the sliding window.
 Example:
    Input: s = "pwwkew"
    Output: 3
    Explanation: "wke" is the longest substring with all unique characters.

 
 */


// MARK: Brute Force
//Time Complexity: O(n²) — For each starting index i, you may scan up to n characters until a duplicate is found
//Space Complexity: O(k) — Using a Set to track characters in the current window

methodLabel("Problem 7: Sliding Window Unique Characters", .bruteForce)

func longestSubstringUniqueCharactersBF(_ s: String) -> Int {
    var maxLength = 0
    let chars = Array(s)
    
    for i in 0..<chars.count {
        var seen: Set<Character> = []
        
        for j in i..<chars.count {
            let ch = chars[j]
    
            print("window: \(chars[i...j]), map: \(seen), max length: \(maxLength)")
            
            if seen.contains(ch) {
                break
            }
            seen.insert(ch)
            maxLength = max(maxLength, j - i + 1)
            
        }
        
    }
    return maxLength

}

longestSubstringUniqueCharactersBF("pwwkew")

// MARK: Sliding Window
//Time Complexity: O(n) — Each character is inserted and removed at most once.
//Space Complexity: O(k) — Size of the Set = length of the current unique substring.


methodLabel("Problem 7: Sliding Window Unique Characters", .slidingWindow)


func longestSubstringUniqueCharactersSW(_ s: String) -> Int {
    
    var maxLength = 0
    var seen: Set<Character> = []
    var start  = 0
    let chars = Array(s)
    
    for end in 0..<chars.count {
        let ch = chars[end]
        
        while seen.contains(ch) {
            print("Duplicate \(ch) found, removing \(chars[start])")
            seen.remove(chars[start])
            start += 1
        }
        seen.insert(ch)
        maxLength = max(maxLength, end - start + 1)
        print("Window: \(chars[start...end]), Set: \(seen), Max length: \(maxLength)")
    }
    
    return maxLength
    
}

longestSubstringUniqueCharactersSW("pwwkew")


// MARK: -  Problem 8: Longest Subarray with At Most K Distinct Elements (Array version)

/* Goal:
    Given an integer array nums and integer k, return the length of the longest contiguous subarray containing at most k distinct elements.
 Example:
    Input: nums = [1,2,1,2,3], k = 2
    Output: 4
    Explanation: Subarray [1,2,1,2] contains at most 2 distinct elements.
 */


// MARK: Brute Force
/* Time Complexity: O(n²)
    — The outer loop is O(n) and the inner loop can run up to O(n) for each i;
    - Worst case: every element is unique, so inner loop runs fully for each i.
   Space Complexity:  O(k)
    — The map holds at most k distinct elements at any time;
    - Worst case (all unique), O(n) for the map
*/
methodLabel("Problem 8: Longest Subarray with At Most K Distinct Elements (Array version)", .bruteForce)

func longestAtMostKDistinctElementsBF(_ nums: [Int], _ k: Int) -> Int {
    guard !nums.isEmpty, k > 0  else {return 0}
    var maxLength = 0
    
    for i in 0..<nums.count {
        var map:[Int:Int] = [:]
        
        for j in i..<nums.count {
            let current = nums[j]
            map[current, default: 0] += 1
            
            print("window: \(nums[i...j]), max length: \(maxLength), map: \(map)")
            
            if map.count <= k {
                maxLength = max(maxLength, j - i + 1)
            } else {
                break
            }
            
        }
    }
    
    return maxLength
}

longestAtMostKDistinctElementsBF([1,2,1,2,3], 2)


// MARK: Sliding Window
/*
 Time Complexity: O(n)
    - Each element is added to the map once (when end moves)
    - Each element is removed from the map once (when start moves)
 Space Complexity: O(k)
    - The window map only contains at most k distinct elements
    - When it grows to k+1, you shrink until back to k
    - Worst-case HashMap size = k
 */

methodLabel("Problem 8: Longest Subarray with At Most K Distinct Elements (Array version)", .slidingWindow)


func longestAtMostKDistinctElementsSW(_ nums: [Int], _ k: Int) -> Int {
    var maxLength = 0
    var map: [Int: Int] = [:]
    var start = 0
    
    for end in 0..<nums.count {
        let current = nums[end]
        map[current, default: 0] += 1
        
        print("Added \(current) → map:", map)
        
        // shrink window until valid
        while map.count > k {
            let leaving = nums[start]
            map[leaving]! -= 1
            
            print("Too many distinct → removing \(leaving) from start index \(start)")
            print("Updated map after decrement:", map)
            
            if map[leaving] == 0 {
                map.removeValue(forKey: leaving)
                print("   Removed \(leaving) completely (count was 0)")
            }
            
            start += 1
        }
        
        // window is now valid
        let windowLength = end - start + 1
        maxLength = max(maxLength, windowLength)
        
        print("VALID window \(nums[start...end]) → length = \(windowLength), max = \(maxLength)")
    }
    
    return maxLength
}


longestAtMostKDistinctElementsSW([1,2,1,2,3], 2)

