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
