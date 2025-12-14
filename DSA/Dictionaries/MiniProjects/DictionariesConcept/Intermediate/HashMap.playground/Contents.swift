
// ---------------------------------------------------------------
// Hash Map –  Group 5.1: Core Concepts & Problem-Solving Reference
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



// MARK: -  Problem 1: Subarray Sum Equals K

/*
 Goal:
 Count the number of continuous subarrays whose sum equals k
 Example:
 Input: nums = [1,1,1], k=2
 Output: 2
 Explanation: The subarrays [1,1] and [1,1] both sum to 2.
 */

// MARK: Brute Force
// Time Complexity: O(n²) → Nested loops to check all possible subarrays
// Space Complexity: O(1) → Just keeping track of the count, and current sum

methodLabel("Problem 1: Subarray Sum Equals K", .bruteForce)

func subarraySumEqualsKBF(_ nums: [Int], _ k: Int) -> Int {
    var count: Int = 0
    
    for i in 0..<nums.count {
        var currentSum = 0
        for j in i..<nums.count {
            currentSum += nums[j]
            print("Subarray: \(nums[i...j]), Current sum: \(currentSum), Count: \(count)")
            if currentSum == k {
                count += 1
                print(" → Valid sum equals \(k): \(count)")
            }
        }
        
    }
    print("Final count: \(count)")
    return count
}

subarraySumEqualsKBF([1,1,1], 2)


// MARK: HashMap
// Time Complexity:  O(n)  → Single pass through the array
// Space Complexity: O(n)  → Prefix sums stored in HashMap
methodLabel("Problem 1: Subarray Sum Equals K", .hashMap)

func subarraySumEqualsKPrefixHMDebug(_ nums: [Int], _ k: Int) -> Int {
    var count = 0
    var prefixSum = 0
    
    // 🔹 Base Case for Prefix Sum Frequency Map
    // We initialize prefix sum 0 with a frequency of 1 to represent
    // the "empty prefix" before the array starts.
    //
    // This allows subarrays that begin at index 0 to be counted correctly.
    // If at any point:
    //     prefixSum == k
    // then:
    //     prefixSum - k == 0
    // and the map tells us that prefix sum 0 has already occurred once,
    // meaning the subarray from index 0 to the current index sums to k.
    //
    // Without this base case, valid subarrays starting at index 0 would be missed.
    var sumFrequency: [Int: Int] = [0: 1]
    
    
    print("Target k = \(k)")
    print("Initial Map: \(sumFrequency)")
    
    for (index, num) in nums.enumerated() {
        prefixSum += num
        // Every time we see prefixSum - k, we have found all subarrays ending here that sum to k.
        let needed = prefixSum - k
        
        print("Index \(index), Num: \(num)")
        print("→ Current Prefix Sum: \(prefixSum)")
        print("→ Needed Prefix Sum: \(needed)")
        
        if let freq = sumFrequency[needed] {
            count += freq
            print("✔ Found \(freq) matching prefix sum(s)")
            print("✔ Count increased to \(count)")
        } else {
            print("✘ No matching prefix sum found")
        }
        
        sumFrequency[prefixSum, default: 0] += 1
        print("→ Updated Map: \(sumFrequency)")
    }
    
    print("Final Count: \(count)")
    return count
}


func subarraySumEqualsKPrefixHM(_ nums: [Int], _ k: Int) -> Int {
    var count = 0
    var prefixSum = 0
    
    var sumFrequency: [Int: Int] = [0: 1]
    
    for num in nums {
        prefixSum += num
        
        if let freq = sumFrequency[prefixSum - k] {
            count += freq
        }
        
        sumFrequency[prefixSum, default: 0] += 1
    }
    
    return count
}

subarraySumEqualsKPrefixHMDebug([1,1,1], 2)


// MARK: -  Problem 2: Longest Subarray With Sum K

/*
 Goal:
 Find the maximum length of a continuous subarray whose sum equals k
 Example:
 Input: [1,-1,5,-2,3], k=3
 Output: 4
 */

// MARK: Brute Force
// Time Complexity: O(n²) → Nested loops to check all possible subarrays
// Space Complexity: O(1) → Just keeping track of the max length, and current sum

methodLabel("Problem 2: Longest Subarray With Sum K", .bruteForce)

func longestKSumSubarrayBF(_ nums: [Int], _ k: Int) -> Int {
    var maxLength = 0
    
    for i in 0..<nums.count {
        var currentSum = 0
        for j in i..<nums.count {
            currentSum += nums[j]
            print("Subarray: \(nums[i...j]), Current sum: \(currentSum), current length: \(maxLength)")
            
            if currentSum == k {
                maxLength = max(maxLength, j - i + 1)
                print(" → Found a valid sum! Updating max length: \(maxLength)")
            }
        }
    }
    
    print("Final max length: \(maxLength)")
    return maxLength
}

longestKSumSubarrayBF([1,-1,5,-2,3], 3)


// MARK: HashMap
// Time Complexity:  O(n)  → Single pass through the array
// Space Complexity: O(n)  → Prefix sums stored in HashMap
methodLabel("Problem 2: Longest Subarray With Sum K", .hashMap)

func longestKSumSubarrayPrefixHMDebug(_ nums: [Int], _ k: Int) -> Int {
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
    //  This allows subarrays starting at index 0 to be counted correctly.
    var sumIndices: [Int: Int] = [0: -1]
    
    for (i, num) in nums.enumerated() {
        prefixSum += num
        
        print("Index \(i), Num: \(num)")
        print("→ Current Prefix Sum: \(prefixSum)")
        print("→ Needed Prefix Sum: \(prefixSum - k)")
        
        // If there exists an earlier prefix sum such that: prefixSum - previousPrefixSum == k,
        // then the subarray between those indices sums to k.
        if let prevIndex = sumIndices[prefixSum - k] {
            let length = i - prevIndex
            print("✔ Found needed prefix sum at index \(prevIndex)")
            print("✔ Subarray length = \(i) - (\(prevIndex)) = \(length)")
            print("✔ Updating maxLength: \(maxLength) → \(max(maxLength, length))")
            maxLength = max(maxLength, length)
        } else {
            print("✘ No matching prefix sum found")
        }
        
        // Checks if this prefix sum has already been recorded
        // If not, store the first occurrence of each prefix sum -> to remember the earliest index at which each prefix sum occurs (longest subarray)
        // If it has been recorded before, we do nothing — we keep the earlier index.
        if sumIndices[prefixSum] == nil {
            sumIndices[prefixSum] = i
            print("→ Storing earliest index for prefix sum \(prefixSum): \(i)")
        } else {
            print("→ Prefix sum \(prefixSum) already exists at index \(sumIndices[prefixSum]!) (keeping earliest)")
        }
        
        print("→ Current Map: \(sumIndices)")
    }
    print("Final max Length: \(maxLength)")
    return maxLength
}

func longestKSumSubarrayPrefixHM(_ nums: [Int], _ k: Int) -> Int {
    var maxLength = 0
    var prefixSum = 0
    
    var sumIndices: [Int: Int] = [0: -1]
    
    for (i, num) in nums.enumerated() {
        prefixSum += num
        
        if let prevIndex = sumIndices[prefixSum - k] {
            maxLength = max(maxLength, i - prevIndex)
        }
        
        if sumIndices[prefixSum] == nil {
            sumIndices[prefixSum] = i
        }
    }
    
    return maxLength
}


longestKSumSubarrayPrefixHMDebug([1,-1,5,-2,3], 3)


// MARK: -  Problem 3: Replace Words with Dictionary (Trie-like using HashMap)

/*
 Goal:
 Given a list of root words (dictionary) and a sentence, replace each word
 in the sentence with the shortest root from the dictionary that is a prefix of that word.
 Example:
 Input: dict = ["cat","bat","rat"], sentence="the cattle was rattled"
 Output: "the cat was rat"
 */

// MARK: Brute Force
/*
 Time Complexity: Time Complexity: O(n * m * l)
 → n = number of words in sentence
 →  m = number of roots in dictionary
 →  l = average length of roots / words (for starts(with:))
 Space Complexity: O(n) → Storing words array
 */
methodLabel("Problem 3: Replace Words with Dictionary (Trie-like using HashMap)", .bruteForce)

func replaceWordsWithDictionaryBF(_ dict: [String], _ sentence: String) -> String {
    var words = sentence.split(separator: " ").map { String($0) }
    print("Original Words: \(words)")
    
    for (i, word) in words.enumerated() {
        var shortestRoot = word
        print("\nChecking word '\(word)':")
        
        for root in dict {
            if word.starts(with: root) {
                print(" → Found matching root: '\(root)'")
                
                if root.count < shortestRoot.count {
                    print(" ✔ Root '\(root)' is shorter than current shortest '\(shortestRoot)'")
                    shortestRoot = root
                } else {
                    print(" ✘ Root '\(root)' is not shorter than current shortest '\(shortestRoot)'")
                }
            }
        }
        
        words[i] = shortestRoot
        print(" → Replaced '\(word)' with '\(shortestRoot)'")
    }
    
    let finalSentence = words.joined(separator: " ")
    print("\nFinal Sentence: \(finalSentence)")
    return finalSentence
}

replaceWordsWithDictionaryBF(["cat","bat","rat", "c"],"the cattle was rattled")


// MARK: Hash Map
/*
 Time Complexity: Time Complexity: O(n * m * l)
    → n = number of words in sentence
    →  m = number of roots in dictionary
    →  l = average length of roots / words (for starts(with:))
 Space Complexity: O(n)
    → Words array stores all words in the sentence → O(n)
    → Root dictionary stores at most one entry per word → O(n)
    → No additional large data structures
 */
methodLabel("Problem 3: Replace Words with Dictionary (Trie-like using HashMap)", .hashMap)

func replaceWordsWithDictionaryHM(_ dict: [String], _ sentence: String) -> String {
    
    var rootDictionary: [String: String] = [:]
    var words = sentence.split(separator: " ").map { String($0) }
    print("Original Words: \(words)")
    
    // Step 1: Precompute shortest root for each word
    for word in words {
        var shortestRoot: String? = nil
        print("\nChecking word '\(word)':")
        
        for root in dict {
            if word.starts(with: root) {
                print(" → Found matching root: '\(root)'")
                
                if shortestRoot == nil || root.count < shortestRoot!.count {
                    print(" ✔ Root '\(root)' is shorter than current shortest \(shortestRoot ?? "nil")")
                    shortestRoot = root
                } else {
                    print(" ✘ Root '\(root)' is not shorter than current shortest \(shortestRoot!)")
                }
            }
        }
        
        if let root = shortestRoot {
            rootDictionary[word] = root
            print(" → Storing in rootDictionary: '\(word)' -> '\(root)'")
        } else {
            print(" → No matching root found for '\(word)'")
        }
    }
    
    // Step 2: Replace words using the map
    for (i, word) in words.enumerated() {
        if let root = rootDictionary[word] {
            print("\nReplacing word '\(word)' with root '\(root)'")
            words[i] = root
        } else {
            print("\nNo replacement needed for word '\(word)'")
        }
    }
    
    let finalSentence = words.joined(separator: " ")
    print("\nFinal Sentence: \(finalSentence)")
    return finalSentence
}

replaceWordsWithDictionaryHM(["cat","bat","rat","c"],"the cattle was rattled")
