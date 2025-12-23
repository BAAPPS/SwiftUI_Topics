// ---------------------------------------------------------------
// Hash Set – Group 5.3: Advanced Core Concepts & Problem-Solving Reference
// ---------------------------------------------------------------
// 🎯 Purpose of a Hash Set:
// A Hash Set stores **unique values** with O(1) average-time
// lookup, insertion, and deletion.
// It transforms repeated existence checks into **direct membership testing**.
//
// 🧠 Core Power Insight:
// Hash Sets convert **presence tracking** into constant-time decisions.
// Instead of scanning an array to check if an element exists,
// you ask the set — instantly.
//
// ---------------------------------------------------------------
// 🔑 What Hash Sets Track (Mentally):
// ---------------------------------------------------------------
// • Membership       → seen / unseen, exists / missing
// • Duplicates       → detecting repeats, enforcing uniqueness
// • Relationships    → complements, conflicts, intersections
// • Groups           → distinct categories, unique identifiers
//
// ---------------------------------------------------------------
// 📘 Canonical Problem Patterns:
// ---------------------------------------------------------------
// • Duplicate Detection
//   - First duplicate
//   - Contains duplicate
//   - Happy Number / cycle detection
//
// • Membership Checks
//   - Two Sum (check complement in set)
//   - Subarray with unique elements
//   - Distinct counts
//
// • Intersections / Unions
//   - Intersection of arrays
//   - Common elements between sets
//   - Unique merges
//
// • Sliding Window / State Tracking
//   - Longest substring / subarray with unique chars
//   - Distinct elements in a window
//   - Balancing problems (seen vs unseen)
//
// ---------------------------------------------------------------
// 🚀 What Hash Sets Unlock:
// ---------------------------------------------------------------
// • O(1) existence checks
// • Eliminate duplicates efficiently
// • Enable single-pass solutions
// • Enable quick set operations:
//     - Union, Intersection, Difference
// • Serve as a backbone for:
//     - Sliding Window
//     - Prefix / State tracking
//     - Frequency conversion (when combined with counters)
//
// ---------------------------------------------------------------
// ⚠️ Advanced Notes & Gotchas:
// ---------------------------------------------------------------
// • Elements must conform to Hashable
// • Order is NOT guaranteed
// • Space grows with unique elements
// • Average O(1), worst-case O(n) (rare in practice)
// • Choose HashSet when:
//     - You only need to know **existence**, not count
//     - You want to enforce uniqueness efficiently
//
// ---------------------------------------------------------------
// 🧩 Interview Mental Trigger:
// ---------------------------------------------------------------
// If you are:
// • Checking presence repeatedly
// • Detecting duplicates
// • Comparing membership across collections
//
// → You are probably missing a Hash Set.
// ---------------------------------------------------------------


import Cocoa


// MARK: Print Statements Helper

enum MethodType: String {
    case bruteForce = "💡 BRUTE FORCE"
    case hashSet = "⚡️ HASH SET"
}

func methodLabel(_ problem: String,  _ method: MethodType)  {
    return print("\(problem) \(method.rawValue)")
}



// MARK: -  Problem 1: Longest Cycle in Graph

/*
 Goal:
 Determine the length of the longest cycle in a directed graph by using
 a **visited set** to avoid reprocessing nodes and a **recursion stack set**
 to detect cycles during DFS traversal. When a cycle is detected, compute
 its length based on the recursion path.
 
 Example:
 Input: graph edges = [[1,2],[2,3],[3,1],[4,5]]
 Output: 3
 
 Explanation:
 Nodes 1 → 2 → 3 → 1 form a cycle of length 3, which is the longest cycle in the graph.
 */


// MARK: Brute Force
/*
 Time Complexity: O(V * (V + E))
  → For each node, we perform a DFS exploring all reachable paths.
    - V = number of vertices (nodes)
    - E = number of edges
  → In the worst case, each DFS can traverse all edges.
 Space Complexity: O(V)
  → Recursion stack + path array + visited set for DFS.
*/

methodLabel("Problem 1: Longest Cycle in Graph", .bruteForce)

func longestCycleBF(_ graph: [[Int]]) -> Int {
    var maxCycleLength = -1
    let n = graph.count
    
    // Helper DFS function
    func dfs(_ node: Int, _ path: inout [Int], _ visited: inout Set<Int>) {
        if let firstIndex = path.firstIndex(of: node) {
            // Cycle detected: length from first occurrence to current
            let cycleLength = path.count - firstIndex
            maxCycleLength = max(maxCycleLength, cycleLength)
            return
        }
        
        if visited.contains(node) {
            return
        }
        
        visited.insert(node)
        path.append(node)
        
        for neighbor in graph[node] {
            dfs(neighbor, &path, &visited)
        }
        
        path.removeLast()
    }
    
    for i in 0..<n {
        var visited = Set<Int>()
        var path = [Int]()
        dfs(i, &path, &visited)
    }
    
    print("Max cycle length: \(maxCycleLength)")
    return maxCycleLength
}

/*
 Start at node 0 → go to node 1 → go to node 2 → go to node 0 again.
 Node 0 is already in the recursion stack → cycle detected!
 The cycle is 0 → 1 → 2 → 0 → length = 3.
 */
let graph = [[1],[2],[0],[4],[]]
longestCycleBF(graph)

// MARK: Hash Set
/*
 Time Complexity: O(V * (V + E))
  → For each node (V nodes), we perform a DFS.
  → In the worst case, the DFS explores all reachable nodes and edges:
     - Each DFS visit touches all edges in the connected component: O(E)
     - So for all nodes: O(V * (V + E))

 Space Complexity: O(V)
  → We store visited nodes in a set: O(V)
  → Recursion stack can go as deep as the number of nodes: O(V)
  → Path array stores nodes along the current DFS path: O(V)
  
 Notes:
     V = number of vertices (nodes)
     E = number of edges
     Using a hash set allows O(1) membership checks for visited nodes and recursion stack
*/

methodLabel("Problem 1: Longest Cycle in Graph", .hashSet)

func longestCycleHS(_ graph: [[Int]]) -> Int {
    let n = graph.count
    var maxCycleLength = -1
    var visited = Set<Int>()
    
    func dfs(_ node: Int, _ recStack: inout Set<Int>, _ path: inout [Int]) {
        if recStack.contains(node) {
            if let firstIndex = path.firstIndex(of: node) {
                let cycleLength  = path.count - firstIndex
                maxCycleLength = max(maxCycleLength, cycleLength)
            }
            return
        }
        
        if visited.contains(node){
            return
        }
        
        visited.insert(node)
        recStack.insert(node)
        path.append(node)
        
        for neighbor in graph[node]{
            dfs(neighbor, &recStack, &path)
        }
        path.removeLast()
        recStack.remove(node)
        
        for i in 0..<n{
            var recStack = Set<Int>()
            var path = [Int]()
            dfs(i, &recStack, &path)
        }
    }
    
    
    return maxCycleLength
}

func longestCycleDebug(_ graph: [[Int]]) -> Int {
    let n = graph.count
    var visited = Set<Int>()
    var maxCycleLength = -1
    
    // DFS helper with recursion stack to track current path
    func dfs(_ node: Int, _ recStack: inout Set<Int>, _ path: inout [Int]) {
        print("\nVisiting node \(node)")
        
        if recStack.contains(node) {
            if let firstIndex = path.firstIndex(of: node) {
                let cycleLength = path.count - firstIndex
                maxCycleLength = max(maxCycleLength, cycleLength)
                print("✅ Cycle detected! Node \(node) revisited. Cycle length = \(cycleLength), maxCycleLength = \(maxCycleLength)")
            }
            return
        }
        
        if visited.contains(node) {
            print(" → Node \(node) already fully visited. Skipping.")
            return
        }
        
        visited.insert(node)
        recStack.insert(node)
        path.append(node)
        print(" → Added node \(node) to path and recursion stack. Current path: \(path)")
        
        for neighbor in graph[node] {
            dfs(neighbor, &recStack, &path)
        }
        
        path.removeLast()
        recStack.remove(node)
        print(" → Backtracking node \(node). Path: \(path), RecStack: \(recStack)")
    }
    
    for i in 0..<n {
        if !visited.contains(i) {
            print("\nStarting DFS from node \(i)")
            var recStack = Set<Int>()
            var path = [Int]()
            dfs(i, &recStack, &path)
        }
    }
    
    print("\nFinal max cycle length: \(maxCycleLength)")
    return maxCycleLength
}

longestCycleDebug(graph)



// MARK: -  Problem 2: Smallest Missing Positive

/*
 Goal:
    Find the smallest positive integer that does not appear in the array by checking which numbers are missing in the sequence starting from 1.

 Example:
     Input: [1, 2, 0]
     Output: 3
 Explanation:
    1 and 2 are present, so the smallest missing positive integer is 3.
*/


// MARK: Brute Force
/*
 Time Complexity: O(n²)
  → For each candidate positive integer (up to n+1), we scan the array to check if it exists.
  → contains() check is O(n), repeated up to n times → O(n²)
 Space Complexity: O(1)
  → Only a few counters are used (i, smallestMissing), no extra data structures.
  
 Notes:
 - The smallest missing positive is at most n+1 for an array of length n.
 - This approach is simple but not optimal for large arrays.
*/


methodLabel("Problem 2: Smallest Missing Positive", .bruteForce)

func smallestMissingPositive(_ nums: [Int]) -> Int {
    var n = nums.count
    var i = 1
    
    while true {
        print("Smallest missing positive:", i)
        if !nums.contains(i){
            return i
        }
        
        i+=1
    }
}

smallestMissingPositive([1, 2, 0])


// MARK: Hash Set
/*
 Time Complexity: O(n)
  → Building the hash set takes O(n)
  → Checking numbers from 1 upwards takes at most n+1 steps → O(n)
  → Overall: O(n)

 Space Complexity: O(n)
  → Hash set stores all numbers from the array → O(n)
  
 Notes:
 - The smallest missing positive is always in the range 1 to n+1 for an array of length n.
 - This approach is simple, efficient, and uses extra space for fast lookup.
*/


methodLabel("Problem 2: Smallest Missing Positive", .hashSet)

func smallestMissingPositiveHS(_ nums: [Int]) -> Int {
    var n = nums.count
    var seen = Set(nums)
    print("Seen set: \(seen)")
    var i = 1
    
    while true {
        print("current i: \(i)")
        if !seen.contains(i) {
            print("Smallest missing positive:", i)
            return i
        }
        
        i += 1
    }
}

smallestMissingPositiveHS([1, 2, 0])


// MARK: -  Problem 3: Word Ladder

/*
 Goal:
      Transform the start word into the end word by changing **one letter at a time**,
      ensuring each intermediate word exists in the given dictionary,
      and determine the **minimum number of transformations** required.

 Example:
      Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
      Output: 5
 Explanation:
      A shortest transformation sequence is: "hit" → "hot" → "dot" → "dog" → "cog"
      Each intermediate word is in the dictionary, and only one letter changes at a time.
*/

// MARK: Brute Force
/*
 Time Complexity: O((26^L)^N)
  → L = length of each word
  → N = number of words in the dictionary
  → For each word, we try changing each of L positions with 26 letters
  → Recursively explores all possible sequences → exponential

 Space Complexity: O(N * L)
  → Recursion stack can go as deep as N words
  → Each word takes O(L) space for the array/string operations
  → Visited set stores words in the current path → O(N)
  
 Notes:
 - Extremely inefficient for large inputs
 - BFS is the preferred approach for shortest path in Word Ladder
*/


methodLabel("Problem 3: Word Ladder", .bruteForce)

func wordLadderBF(_ current: String, _ endWord: String, _ wordSet: Set<String>, _ visited: Set<String>, _ pathLength: Int) -> Int {
    
    if current == endWord {
        return pathLength
    }
    
    var minLength: Int  = Int.max
    var visited = visited
    visited.insert(current)
    let letters = Array("abcdefghijklmnopqrstuvwxyz")
    var wordArray = Array(current)
    
    for i in 0..<wordArray.count {
        let originalChar = wordArray[i]
        for c in letters {
            wordArray[i] = c
            let nextWord = String(wordArray)
            
            if wordSet.contains(nextWord), !visited.contains(nextWord) {
                let newLength = wordLadderBF(nextWord, endWord, wordSet, visited, pathLength + 1)
                minLength = min(minLength, newLength)
            }
            wordArray[i] = originalChar
        }
    }
    return minLength
}

// Wrapper
func ladderLengthBF(beginWord: String, endWord: String, wordList: [String]) -> Int {
    let wordSet = Set(wordList)
    let result = wordLadderBF(beginWord, endWord, wordSet, [], 1)
    return result == Int.max ? 0 : result
}


// MARK: HashSet + BFS Approach
/*
 Time Complexity: O(N * L * 26)
  → N = number of words in the dictionary
  → L = length of each word
  → For each word dequeued, we try changing each letter to all 26 letters
 Space Complexity: O(N + L)
  → Queue stores words for BFS, and visited set contains words already processed
*/


methodLabel("Problem 3: Word Ladder", .hashSet)

func wordLadderLength(beginWord: String, endWord: String, wordList: [String]) -> Int {
    let wordSet = Set(wordList)
    if !wordSet.contains(endWord) {
        return 0
    }
    
    var queue: [(String, Int)] = [(beginWord, 1)]
    var visited: Set<String> = [beginWord]
    
    print("Starting BFS from '\(beginWord)' to reach '\(endWord)'")
     
    while !queue.isEmpty {
        let (currentWord, level) = queue.removeFirst()
        print("\nDequeued: '\(currentWord)', level: \(level)")
        
        if currentWord == endWord {
            print("Reached endWord! Shortest path length: \(level)")
            return level
        }
        
        var wordArray = Array(currentWord)
        
        for i in 0..<wordArray.count {
            let originalChar = wordArray[i]
            
            for c in "abcdefghijklmnopqrstuvwxyz" {
                wordArray[i] = c
                let nextWord = String(wordArray)
                
                if wordSet.contains(nextWord), !visited.contains(nextWord) {
                    queue.append((nextWord, level + 1))
                    visited.insert(nextWord)
                    print(" → Enqueue '\(nextWord)', next level: \(level + 1)")
                }
            }
            
            wordArray[i] = originalChar  // Restore original character
        }
        
    }
    
    print("End word not reachable from begin word.")
    return 0
}

let beginWord = "hit"
let endWord = "cog"
let wordList = ["hot","dot","dog","lot","log","cog"]

wordLadderLength(beginWord: beginWord, endWord: endWord, wordList: wordList)
