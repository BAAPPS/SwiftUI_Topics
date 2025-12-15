
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


// MARK: -  Problem 4: Most Frequent Subtree Sum (Tree + HashMap)

/*
 Goal:
 Compute the sum of every subtree in a binary tree. Find which sums appear most frequently.
 
 Example:
 
 5
 / \
 2  -3
 
 Compute subtree sums:
 
 - Node 2 → sum = 2
 
 -  Node -3 → sum = -3
 
 - Node 5 → sum = 5 + 2 + (-3) = 4
 
 Count frequencies:
 
 - { 2: 1, -3: 1, 4: 1 }
 
 Find max frequency:
 
 - Here all sums appear once, so output all of them: [2, -3, 4].
 
 Any problem where a node depends on its children → Post-order (left, right, root)
 
 */


class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}


// MARK: Brute Force
/*
 Time Complexity: O(n^2)
 → n = number of nodes in the tree
 → For brute force:
 1. Traverse each node → O(n)
 2. Compute subtree sum for each node (naively, recomputing sums of children each time) → O(n)
 → Total = O(n * n) = O(n^2)
 Space Complexity: O(n)
 → Store all subtree sums in an array → O(n)
 → Call stack for recursion → O(h), worst case O(n) for skewed tree
 */
methodLabel("Problem 4: Most Frequent Subtree Sum (Tree + HashMap)", .bruteForce)

func collectSubtreeSums(_ node: TreeNode?, _ sums: inout [Int]) -> Int {
    guard let node = node else { return 0 }
    
    let left = collectSubtreeSums(node.left, &sums)
    let right = collectSubtreeSums(node.right, &sums)
    
    let subtreeSum = left + right + node.val
    sums.append(subtreeSum)
    
    print("Node \(node.val) → Subtree Sum: \(subtreeSum)")
    return subtreeSum
}

func findFrequentTreeSumBF(_ root: TreeNode?) -> [Int] {
    var sums: [Int] = []
    collectSubtreeSums(root, &sums)
    
    print("All Subtree Sums Collected: \(sums)\n")
    
    var maxFreq = 0
    var result: [Int] = []
    
    for sum in sums {
        let freq = sums.filter { $0 == sum }.count
        print("Checking sum: \(sum) → frequency: \(freq), current maxFreq: \(maxFreq)")
        
        if freq > maxFreq {
            maxFreq = freq
            result = [sum]
            print(" → New max frequency! maxFreq updated to \(maxFreq), result: \(result)")
        } else if freq == maxFreq && !result.contains(sum) {
            result.append(sum)
            print(" → Frequency ties maxFreq, adding sum to result: \(result)")
        } else {
            print(" → Sum ignored, not max or tie")
        }
    }
    
    print("\nFinal Result: \(result)")
    return result
}

let root = TreeNode(
    2,
    TreeNode(-3, TreeNode(2), TreeNode(2)),  // left subtree
    TreeNode(4)                               // right subtree
)
findFrequentTreeSumBF(root)


// MARK: HashMap
/*
 Time Complexity: O(n)
 → n = number of nodes in the tree
 → Each node is visited exactly once (post-order traversal)
 → Updating the hash map for subtree sums is O(1) per node
 Space Complexity: O(n)
 → HashMap stores frequency for each unique subtree sum → O(n) in worst case
 → Recursion stack → O(h), worst case O(n) for skewed tree
 */
methodLabel("Problem 4: Most Frequent Subtree Sum (Tree + HashMap)", .hashMap)

func postOrder(_ node: TreeNode?, _ sumFrequency: inout [Int: Int]) -> Int {
    guard let node = node else { return 0 }
    let leftSum = postOrder(node.left, &sumFrequency) // left
    let rightSum = postOrder(node.right, &sumFrequency) // right
    let subtreeSum = leftSum + rightSum + node.val // root
    sumFrequency[subtreeSum, default: 0] += 1
    print("Node \(node.val) → Subtree Sum: \(subtreeSum)")
    print("Map: \(sumFrequency)\n")
    return subtreeSum
}

func findFrequentTreeSum(_ root: TreeNode?) -> [Int] {
    var sumFrequency: [Int: Int] = [:]
    postOrder(root, &sumFrequency)
    var maxFreq = sumFrequency.values.max() ?? 0
    
    
    return sumFrequency
        .filter { $0.value == maxFreq }
        .map { $0.key }
}

let root1 = TreeNode(5, TreeNode(2), TreeNode(-3))

findFrequentTreeSum(root1)



// MARK: -  Problem 5: Find Duplicate Subtrees (Serialize + HashMap)

/*
 Goal:
 Identify all subtrees in a binary tree that appear more than once.
 
 Serialize each subtree into a string (or tuple) representing its structure and values.
 
 Use a HashMap to track the frequency of each serialization.
 
 Return the root nodes of all duplicate subtrees.
 Example:
 Input:
 1
 / \
 2   3
 /   / \
 4  2   4
 /
 4
 
 Subtree serializations:
 - "4" → appears 3 times
 - "2,4" → appears 2 times
 
 Output: [TreeNode(4), TreeNode(2)]
 
 Any problem where a node depends on its children → Post-order (left, right, root)
 */


// MARK: Brute Force
/*
 Time Complexity: O(n^2)
 → n = number of nodes in the tree
 → For brute force:
 1. Traverse each node → O(n)
 2. For each node, serialize its subtree by recursively visiting all its children → O(n)
 → Total = O(n * n) = O(n^2)
 
 Space Complexity: O(n)
 → Store all subtree serializations in an array → O(n)
 → Recursion call stack → O(h), where h = height of the tree
 → Worst case O(n) for skewed tree, O(log n) for balanced tree
 */
methodLabel("Problem 5: Find Duplicate Subtrees (Serialize + HashMap)", .bruteForce)

let root2 = TreeNode(
    1,
    TreeNode(
        2,
        TreeNode(4), // left child of 2
        nil          // right child of 2
    ),
    TreeNode(
        3,
        TreeNode(
            2,
            TreeNode(4), // left child of 2
            nil          // right child of 2
        ),
        TreeNode(4)      // right child of 3
    )
)

func collectSubtreeSerializationsBF(_ node: TreeNode?, _ serials: inout [String], _ nodes: inout [TreeNode] ) -> String {
    guard let node = node else { return "#" } // Use "#" to represent nil
    
    // Post-order: left, right, root
    let leftSerial = collectSubtreeSerializationsBF(node.left, &serials, &nodes)
    let rightSerial = collectSubtreeSerializationsBF(node.right, &serials, &nodes)
    
    let subtreeSerial = "\(node.val),\(leftSerial),\(rightSerial)"
    
    // Add subtree to the array
    serials.append(subtreeSerial)
    nodes.append(node)
    
    print("Node \(node.val) → Subtree Serial: \(subtreeSerial)")
    
    
    return subtreeSerial
    
    
}


func findDuplicateSubtreesBF(_ node: TreeNode?) -> [TreeNode] {
    var serials: [String] = []
    var nodes: [TreeNode] = []
    
    // Collect all subtree serializations
    _ = collectSubtreeSerializationsBF(node, &serials, &nodes)
    
    var duplicates: [TreeNode] = []
    
    for (i, serial) in serials.enumerated() {
        let count = serials.filter { $0 == serial }.count
        if count > 1 && !duplicates.contains(where: { $0 === nodes[i]}) {
            duplicates.append(nodes[i])
            print("Duplicate Found: Node \(nodes[i].val), Serial: \(serial)")
        }
    }
    
    
    return duplicates
}

let duplicates = findDuplicateSubtreesBF(root2)
print("Duplicate subtree roots:")
for node in duplicates {
    print(node.val)
}

// MARK: HashMap
/*
 Time Complexity: O(n)
 → n = number of nodes in the tree
 → Each node is visited exactly once during post-order traversal
 → Serializing a subtree and updating the HashMap is O(1) average per node
 
 Space Complexity: O(n)
 → HashMap stores frequency of each unique subtree serialization → O(n) in worst case
 → Recursion stack → O(h), where h = tree height
 → Worst case O(n) for skewed tree, O(log n) for balanced tree
 */
methodLabel("Problem 5: Find Duplicate Subtrees (Serialize + HashMap)", .hashMap)

func findDuplicateSubtreesHM(_ root: TreeNode?) -> [TreeNode] {
    var frequencyMap: [String: Int] = [:]
    var duplicates: [TreeNode] = []
    
    func serialize(_ node: TreeNode?) -> String {
        guard let node = node else { return "#"}  // Null marker for missing children
        
        // Post-order: left, right, root
        let leftSerial = serialize(node.left)
        let rightSerial = serialize(node.right)
        let subtreeSerial = "\(node.val),\(leftSerial),\(rightSerial)"
        
        frequencyMap[subtreeSerial, default: 0] += 1
        
        // If this is the second time we see this subtree, add root to duplicates
        if frequencyMap[subtreeSerial] == 2 {
            duplicates.append(node)
            print("Duplicate Found: Node \(node.val), Serial: \(subtreeSerial)")
        }
        
        
        // Debug output
        print("Node \(node.val) → Serial: \(subtreeSerial), Frequency: \(frequencyMap[subtreeSerial]!)")
        
        return subtreeSerial
        
    }
    
    _ = serialize(root)
    
    return duplicates
    
}

let duplicatesHM = findDuplicateSubtreesHM(root2)
print("Duplicate subtree roots:")
for node in duplicatesHM {
    print(node.val)
}


// MARK: -  Problem 6: Longest Palindrome by Character Frequency

/*
 Goal:
 Given a string, determine the length of the longest palindrome that can be built using its characters.
 Count the frequency of each character.
 For characters with even counts, all can be used.
 For characters with odd counts, use the largest even part of each and possibly one odd character in the center.
 Example:
 Input: "abccccdd"
 Output: 7
 Explanation: "ccdbdcc" or  "ccdadcc"
 */

// MARK: Brute Force
/*
 Time Complexity: O(n^2)
 → n = length of the string
 → For brute force approach:
 1. Consider every possible substring using two loops → O(n^2)
 2. Count frequency of characters in each substring → O(n) per substring in worst case
 → Total = O(n^3) if counting separately for each substring
 
 Space Complexity: O(n)
 → Frequency array or dictionary for each substring → O(n)
 → Call stack is negligible (iterative loops)
 
 ⚠ Why it’s not viable:
 - Brute-force requires checking **all substrings**, which grows cubically with string length.
 - For moderate/large strings, this approach becomes extremely slow.
 - The optimal approach is **single-pass frequency counting**, which is O(n) time and O(1) space (for fixed alphabet).
 */

methodLabel("Problem 6: Longest Palindrome by Character Frequency", .bruteForce)

// MARK: HashMap
/*
 Time Complexity: O(n)
    → n = length of the input string
    → Single pass to count frequency of each character → O(n)
    → Single pass over frequency dictionary to compute max palindrome length → O(1) per character (constant alphabet size)
    → Total = O(n)

 Space Complexity: O(1) (or O(k))
    → HashMap / dictionary stores frequency of characters → O(k), where k = size of alphabet
    → For English letters, k = 26 → constant → O(1)
    → Otherwise, worst case O(n) if all characters are unique
 */
methodLabel("Problem 6: Longest Palindrome by Character Frequency", .hashMap)

func longestPalindromeByCharacterFrequencyHM(_ str: String) -> Int {
    var maxLength = 0
    var hasOddCount = false
    
    // Convert string to array for easier indexing
    let arr = Array(str)
    
    var frequencyMap: [Character: Int] = [:]
    
    for char in arr{
        frequencyMap[char, default: 0] += 1
    }
    
    // Compute max palindrome length
    for (char, count) in frequencyMap {
        if count % 2  == 0 {
            maxLength += count
            print("Char '\(char)' count \(count) → even → add all: maxLength = \(maxLength)")
        }
        else {
            // If a character has an odd count, we can only use the largest even portion
            // for the mirrored halves of the palindrome.
            // We mark `hasOddCount = true` to potentially place **one odd character in the center** later.
            maxLength += count - 1
            hasOddCount = true
            print("Char '\(char)' count \(count) → odd → add \(count - 1): maxLength = \(maxLength)")
        }
    }
    
    //  Add 1 if there was at least one odd character
    if hasOddCount {
        maxLength += 1
        print("At least one odd count → add 1 for center: maxLength = \(maxLength)")
    }
    
    print("\nFinal Longest Palindrome Length: \(maxLength)")
    return maxLength
}

let input = "abccccdd"
longestPalindromeByCharacterFrequencyHM(input)
