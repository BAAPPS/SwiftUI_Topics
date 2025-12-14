
// ---------------------------------------------------------------
// Hash Map –  Group 5: Core Concepts & Problem-Solving Reference
// ---------------------------------------------------------------
//
// 🎯 Purpose of a Hash Map:
// A Hash Map provides **O(1) average-time lookups, inserts, and deletions**,
// making it ideal for frequency counting, membership checks, indexing,
// grouping, and detecting patterns in a single pass.
//
// 🧠 Why Hash Maps Are Powerful:
// - Direct access by key (no searching through the array)
// - Perfect for tracking counts, positions, states, or complements
// - Enables solving many O(n²) brute-force problems in **O(n)**
//
// 📘 Common Use Cases:
// - Frequency maps (counting elements or characters)
// - Tracking seen values to detect duplicates
// - Storing index positions (first/last seen, distance checks)
// - Complement lookups (Two Sum pattern)
// - Grouping values (anagrams, buckets, prefix sums)
//
// 🔥 What Hash Maps Unlock:
// - Real-time checks during iteration
// - Single-pass logic with constant-time access
// - Avoids nested loops
// - Enables advanced patterns like prefix sums, sliding windows, and hashing
//
// ⚠️ Important Notes:
// - Keys must be hashable (Int, String, structs with Hashable)
// - Beware of collisions in theory, though Swift handles them internally
// - Memory usage grows with input size
// - Order of keys is **not guaranteed** (use OrderedDictionary if needed)
//
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



// MARK: -  Problem 1: Count Frequency of Elements

/*
 Goal:
 Given an array nums, build a frequency map that counts occurrences of each number.
 
 Example:
 Input: [1,2,2,3,3,3]
 Output: {1:1, 2:2, 3:3}
 
 */

// MARK: Brute Force
// Time Complexity:  O(n²)  → For each element, scan entire array
// Space Complexity: O(n)   → Stores frequency for each unique element


methodLabel("Problem 1: Count Frequency of Elements", .bruteForce)

func countFrequencyBF(_ array: [Int]) -> [Int: Int] {
    guard !array.isEmpty else { return [:] }
    
    var frequencyMap: [Int: Int] = [:]
    
    for i in 0..<array.count {
        let current = array[i]
        var count = 0
        
        for j in 0..<array.count {
            if array[j] == current {
                count += 1
            }
        }
        
        frequencyMap[current] = count
        print("Element: \(current), Count: \(count), map: \(frequencyMap)")
    }
    
    print("Final HashMap: \(frequencyMap)")
    return frequencyMap
}

countFrequencyBF([1,2,2,3,3,3])


// MARK: HashMap
// Time Complexity:  O(n)  → Single scan through array
// Space Complexity: O(n)  → Elements stored in hash map

methodLabel("Problem 1: Count Frequency of Elements", .hashMap)

func countNumberOfElements(_ array: [Int]) -> [Int: Int] {
    guard !array.isEmpty else { return [:] }
    
    var frequencyMap: [Int: Int] = [:]
    
    for num in array {
        frequencyMap[num, default: 0] += 1
        print("current num: \(num), adding to map: \(frequencyMap)")
    }
    
    print("Final HashMap: \(frequencyMap)")
    return frequencyMap
    
}


countNumberOfElements([1,2,2,3,3,3])


// MARK: - Problem 2: Find First Non-Repeating Character

/*
 Goal:
 Given a string s, return the index of the first character
 that appears only once.
 
 Example:
 Input: "leetcode"
 Output: 0  // 'l' appears once
 */

// MARK: Brute Force
// Time Complexity:  O(n²)  → For each character, scan entire string
// Space Complexity: O(1)   → Using counters only (chars array is O(n) input)

methodLabel("Problem 2: Find First Non-Repeating Character", .bruteForce)

func firstNonRepeatingCharacterBF(_ str: String) -> Int {
    let chars = Array(str)
    
    for (i, currentChar) in chars.enumerated() {
        var count = 0
        
        for ch in chars {
            if ch == currentChar {
                count += 1
            }
        }
        
        if count == 1 {
            print("First non-repeating char: \(currentChar), index: \(i)")
            return i
        }
    }
    
    return -1
}


firstNonRepeatingCharacterBF("leetcode")



// MARK: HashMap
// Time Complexity: O(n)  → Two linear scans (frequency map + first unique)
// Space Complexity: O(n) → Characters stored in hash map

methodLabel("Problem 2: Find First Non-Repeating Character", .hashMap)

func firstNonRepeatingCharacterHM(_ str: String) -> Int {
    var chars:[Character] = Array(str)
    var charFrequency: [Character: Int] = [:]
    
    for char in chars {
        charFrequency[char, default: 0] += 1
        print("current char: \(char), added to map: \(charFrequency)")
    }
    
    for (index, char) in chars.enumerated() {
        if charFrequency[char] == 1 {
            print("First non-repeating char: \(char), index: \(index)")
            return index
        }
    }
    
    return -1
}


firstNonRepeatingCharacterHM("leetcode")



// MARK: - Problem 3: Two Sum

/*
 Goal:
 Return two indices such that nums[i] + nums[j] = target using a Hash Map to store complements.
 
 Example:
 Input: nums = [2,7,11,15], target = 9
 Output: [0,1]
 
 */

// MARK: Brute Force
// Time Complexity:  O(n²) → For each character, scan entire string
// Space Complexity: O(1)

methodLabel("Problem 3: Two Sum", .bruteForce)

func twoSumBF(_ nums: [Int], _ target: Int) -> (Int, Int)? {
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            if nums[i] + nums[j] == target {
                print("result: (\(i), \(j))")
                return (i, j)
            }
        }
    }
    
    return nil
}


twoSumBF([2,7,11,7,15], 9)


// MARK: Hash Map
// Time Complexity:  O(n)  → One pass through the array
// Space Complexity: O(n)  → At worst, store every number in the map

methodLabel("Problem 3: Two Sum", .hashMap)

func twoSumHM(_ nums: [Int], _ target: Int) -> (Int, Int)? {
    var difference: [Int: Int] = [:]   // number → first index seen
    
    for (index, num) in nums.enumerated() {
        let requiredNum = target - num
        
        if let otherIndex = difference[requiredNum] {
            print("Found earliest pair: (\(otherIndex), \(index))")
            return (otherIndex, index)
        }
        
        // Only store the first occurrence of the number
        if difference[num] == nil {
            difference[num] = index
            print("Storing \(num) at index \(index) in map")
        }
    }
    
    print("No valid pair found")
    return nil
}

twoSumHM([7,11,7,15, 2], 9)




// MARK: - Problem 4: Are Anagrams

/*
 Goal:
 Check if two strings are anagrams using a frequency map.
 
 Example:
 Input: "anagram", "nagaram"
 Output: true
 */



// MARK: Brute Force
// Time Complexity:  O(n²)  → For each character in str1, we may scan the whole str2 array (which shrinks slowly).
// Space Complexity: O(1)   → Extra array of same size as input is needed to remove matched characters from str2Chars

methodLabel("Problem 4: Are Anagrams", .bruteForce)

func areAnagramsBF(_ str1: String, _ str2: String) -> Bool {
    // Strings of different lengths cannot be anagrams
    guard str1.count == str2.count else {
        print("Different lengths: \(str1.count) vs \(str2.count)")
        return false
    }
    
    // Convert str2 to array for mutable removal
    var str2Chars = Array(str2)
    print("Initial str1: \(str1)")
    print("Initial str2Chars: \(str2Chars)\n")
    
    for char1 in str1 {
        var found = false
        print("Looking for char '\(char1)' in str2Chars: \(str2Chars)")
        
        for i in 0..<str2Chars.count {
            if str2Chars[i] == char1 {
                print(" → Found '\(char1)' at index \(i), removing from str2Chars")
                str2Chars.remove(at: i)
                found = true
                break
            }
        }
        
        if !found {
            print("Character '\(char1)' not found, strings are NOT anagrams")
            return false
        }
        
        print("Remaining str2Chars after removal: \(str2Chars)\n")
    }
    
    print("All characters matched! Strings are anagrams.")
    return true
}


areAnagramsBF("anagram", "nagaram")


// MARK: Hash Map
// Time Complexity: O(n) → one linear scan to build map + one linear scan to match str2
// Space Complexity: O(n) → single frequency map

methodLabel("Problem 4: Are Anagrams", .hashMap)


func areAnagramsHM(_ str1: String, _ str2: String) -> Bool {
    guard str1.count == str2.count else {
        print("Strings have different lengths: \(str1.count) vs \(str2.count)")
        return false
    }
    
    var freq: [Character: Int] = [:]
    
    for char in str1 {
        freq[char, default: 0] += 1
    }
    print("Initial frequency map from str1:", freq, "\n")
    
    // Scan str2 and decrement counts
    for char in str2 {
        if let count = freq[char], count > 0 {
            freq[char]! -= 1
            print("Matched char '\(char)', decrement count: \(freq[char]!)")
        } else {
            print("Char '\(char)' not found or count exhausted, strings NOT anagrams")
            return false
        }
    }
    
    // All counts should now be zero
    print("All counts matched, strings are anagrams:", freq)
    return true
    
}



areAnagramsHM("anagram", "nagaram")

// MARK: - Problem 5: Group Anagrams

/*
 Goal:
    Group strings that have identical letter frequency.

 
 
 Example:
    Input: ["eat","tea","tan","ate"]
    Output: [["eat","tea","ate"], ["tan"]]
 
 */

// MARK: Brute Force
// Time Complexity: O(n^2 * k log k) → For each of the n words, we compare with remaining n words. Sorting each word takes O(k log k), where k is the length of the word.
// Space Complexity: O(n * k) → To store the groups and visited words. Each word of length k is stored in the grouped arrays.


methodLabel("Problem 5: Group Anagrams", .bruteForce)


func groupAnagramsBF(_ array: [String]) -> [[String]] {
    var grouped: [[String]] = []
    var visited = Array(repeating: false, count: array.count)
    
    for i in 0..<array.count {
        if visited[i] { continue }
        var group = [array[i]]
        visited[i] = true
        let sortedI = String(array[i].sorted())
        
        print("\n Starting new group with '\(array[i])' (sorted: \(sortedI))")
        
        for j in (i+1)..<array.count {
            if visited[j] { continue }
            let sortedJ = String(array[j].sorted())
            
            print(" → Comparing '\(array[j])' (sorted: \(sortedJ)) with '\(array[i])' (sorted: \(sortedI))")
            
            if sortedI == sortedJ {
                group.append(array[j])
                visited[j] = true
                print(" → Match found! Adding '\(array[j])' to current group")
            } else {
                print(" → Not a match")
            }
        }
        
        grouped.append(group)
        print("Finished group: \(group)")
    }
    
    print("\nAll groups formed: \(grouped)")
    return grouped
}

groupAnagramsBF(["eat","tea","tan","ate"])



// MARK: Hash Map
// Time Complexity: O(n * k log k) → For each of the n words, sort the word of length k
// Space Complexity: O(n * k) → To store all words in the dictionary (keys + grouped values)

methodLabel("Problem 5: Group Anagrams", .hashMap)

func groupAnagramsHM(_ array: [String]) -> [[String]] {
    var map: [String: [String]] = [:]
    
    for word in array {
        let sortedWord = String(word.sorted())
        print("\nCurrent word: '\(word)' → sorted: '\(sortedWord)'")
        
        if map[sortedWord] != nil {
            map[sortedWord]?.append(word)
            print(" → Added '\(word)' to existing group: \(map[sortedWord]!)")
        } else {
            map[sortedWord] = [word]
            print(" → Created new group for key '\(sortedWord)': \(map[sortedWord]!)")
        }
    }
    
    let grouped = Array(map.values)
    print("\nAll groups formed: \(grouped)")
    return grouped
}


groupAnagramsHM(["eat","tea","tan","ate"])
