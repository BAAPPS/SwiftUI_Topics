// ---------------------------------------------------------------
// Hash Set – Group 6.1: Core Concepts & Problem-Solving Reference
// ---------------------------------------------------------------
//
// 🎯 Purpose of a Hash Set:
// A Hash Set stores **unique elements with O(1) average-time membership checks**.
// It is ideal for problems that rely on determining whether a value has been
// seen, preventing duplicates, or validating existence efficiently.
//
// 🧠 Why Hash Sets Are Effective:
// - Constant-time containment checks ("Have we seen this?")
// - Perfect for uniqueness enforcement
// - Eliminates repeated scans through the array
// - Enables early-exit logic (stop as soon as a rule is violated)
//
// 📘 Common Use Cases:
// - Detect duplicates in a single pass
// - Track visited numbers, characters, or states
// - Set operations: union, intersection, difference
// - Fast membership tests (e.g., checking complements or pairs)
// - Filtering unique elements from a stream
//
// 🔥 What Hash Sets Unlock:
// - Removes O(n²) nested loops
// - Guarantees uniqueness without extra checks
// - Enables one-pass algorithms
// - Provides instant existence testing during iteration
//
// ⚠️ Important Notes:
// - Order is **not preserved**; use OrderedSet if ordering matters
// - Only unique values are stored
// - Values must conform to **Hashable**
// - Higher memory usage than arrays
//
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



// MARK: - Problem 1: Longest Consecutive Sequence (Set version)

/*
 Goal:
    Given an unsorted array of integers, find the length of the longest consecutive elements sequence.
 Example:
    Input: [0,3,7,2,5,8,4,6,0,1]
    Output: 9
 
 */

// MARK: Brute Force
/* Time Complexity: O(nlogn) → Dominated by sorting
    Remove duplicates and sort;
        → Set(array) → O(n) to remove duplicates
        → .sorted() → O(n log n) for sorting
    Single Pass
        → Linear scan
 Space Complexity: O(n) → Set for unique elements / Sorted array
*/
methodLabel("Problem 1: Longest Consecutive Sequence (Set version)", .bruteForce)

func longestConsecutiveSequenceBF(_ array: [Int]) -> Int {
    let sortedArray = Array(Set(array)).sorted() // remove duplicates
    print("Sorted Unique Array: \(sortedArray)")
    var maxLength = 1
    var currentLength = 1
    
    
    for i in 1..<sortedArray.count {
        if sortedArray[i] == sortedArray[i - 1] + 1 {
            currentLength += 1
        } else {
            currentLength = 1
        }
        
        maxLength = max(maxLength, currentLength)
        print("i: \(i), currentNum: \(sortedArray[i]), prevNum: \(sortedArray[i-1]), currentLength: \(currentLength), maxLength: \(maxLength)")
    }
    
    print("Final max length: \(maxLength)")
    return maxLength
}

longestConsecutiveSequenceBF([0,3,7,2,5,8,4,6,0,1])


// MARK: Hash Set
// Time Complexity: O(n) → Set insert & contains are O(1) average
// Space Complexity: O(n) → Worst case if no duplicates

methodLabel("Problem 1: Longest Consecutive Sequence (Set version)", .hashSet)

func longestConsecutiveSequenceHS(_ array: [Int]) -> Int {
    guard !array.isEmpty else { return 0 }
    
    let uniqueSet = Set(array)
    print("Unique Set: \(uniqueSet)\n")
    
    var maxLength = 0
    
    for num in uniqueSet {
        // Only start a sequence if num-1 does not exist in the set
        if !uniqueSet.contains(num - 1) {
            var currentNum = num
            var currentLength = 1
            print("Sequence starting at \(num)")
            
            // Expand the sequence forward
            while uniqueSet.contains(currentNum + 1) {
                currentNum += 1
                currentLength += 1
                print(" → Found next consecutive: \(currentNum), currentLength: \(currentLength)")
            }
            
            maxLength = max(maxLength, currentLength)
            print(" → Sequence ended at \(currentNum), currentLength: \(currentLength), maxLength so far: \(maxLength)\n")
        }
    }
    
    print("Final max length: \(maxLength)")
    return maxLength
}

longestConsecutiveSequenceHS([0,3,7,2,5,8,4,6,0,1])



// MARK: - Problem 2: Missing Number

/*
 Goal:
    Given an array containing n distinct numbers in the range [0, n], find the one number that is missing.
 Example:
    Input: [3,0,1]
    Output: 2
    Explanation:
        - The array has numbers 0, 1, 3.
        - The full range is 0..3 → {0, 1, 2, 3}
        - Number 2 is missing → return 2
 */

// MARK: Brute Force

/*
 Time Complexity: O(n log n)
    - Remove duplicates using Set(array) → O(n)
    - Sort the array → O(n log n)
    - Single pass to check for gaps → O(n)
    → Dominated by sorting step → O(n log n)
 
 Space Complexity: O(n)
    - Storing unique elements in a Set → O(n)
    - Sorted array → O(n)
    → Total space → O(n)
*/

methodLabel("Problem 2: Missing Number", .bruteForce)

func missingNumberBF(_ array: [Int]) -> Int {
    let sortedArray = Array(Set(array)).sorted() // unique and sorted
    let n = array.count
    print("Original Array: \(array)")
    print("Sorted Unique Array: \(sortedArray)")
    
    // Check if 0 is missing
    if sortedArray.first != 0 {
        print("0 is missing")
        return 0
    }
    
    // Check for gaps in sorted array
    for i in 1..<sortedArray.count {
        print("Checking indices \(i-1) and \(i): \(sortedArray[i-1]), \(sortedArray[i])")
        if sortedArray[i] != sortedArray[i - 1] + 1 {
            let missing = sortedArray[i - 1] + 1
            print(" → Gap found, missing number is \(missing)")
            return missing
        }
    }
    
    // If no gaps, missing number is n
    print("No gaps found, missing number is \(n)")
    return n
}

missingNumberBF([3,0,1])

// MARK: Hash Set
/*
 Time Complexity: O(n)
    - Creating the set → O(n) to insert all elements
    - Traversing the range 0...n → O(n) lookups, each O(1) on average
    → Total: O(n)
 
 Space Complexity: O(n)
    - Storing all array elements in a set → O(n)
    - No other large structures used
*/

methodLabel("Problem 2: Missing Number", .hashSet)

func missingNumberHS(_ array: [Int]) -> Int {
    let uniqueSet = Set(array)
    print("Original Array: \(array)")
    print("Unique Set: \(uniqueSet)\n")
    
    let n = array.count  // the range is 0...n
    
    for i in 0...n {
        print("Checking if \(i) is in the set...")
        if !uniqueSet.contains(i) {
            print(" → \(i) is missing!")
            return i
        } else {
            print(" → \(i) is present")
        }
    }
    
    // Should never reach here
    return n
}

missingNumberHS([3,0,1])


// MARK: - Problem 3: Duplicate File in System

/*
 Goal:
    Given a list of file listings with content, identify all groups of files that have identical content.
 Example:
    Input: ["root/a 1.txt(abcd) 2.txt(efgh)", "root/c 3.txt(abcd)", "root/c 4.txt(efgh)", "root/d 4.txt(efgh)"]
    Output: [["root/a/1.txt","root/c/3.txt"], ["root/a/2.txt","root/c/4.txt","root/d/4.txt"]]
    Explanation:
        - Files with identical content are grouped together.
        - Use the content as the key to track duplicates efficiently.
 */

// MARK: Brute Force

/*
 Time Complexity: O(n²) → because we are comparing every file against every other file
 Space Complexity: O(n) → to store the resulting groups
*/

methodLabel("Problem 3: Duplicate File in System", .bruteForce)

func findDuplicateFilesBF(_ paths: [String]) -> [[String]] {
    // Parse files into a list of (fullPath, content)
    var files: [(path: String, content: String)] = []
    
    for pathInfo in paths {
        let parts = pathInfo.split(separator: " ")
        let dir = String(parts[0])
        
        for file in parts.dropFirst() {
            // file example: "1.txt(abcd)"
            if let openParen = file.firstIndex(of: "("),
               let closeParen = file.firstIndex(of: ")") {
                let filename = file[..<openParen]
                let content = file[file.index(after: openParen)..<closeParen]
                let fullPath = dir + "/" + filename
                files.append((String(fullPath), String(content)))
            }
        }
    }
    
    print("All files with content:")
    for f in files {
        print(" → \(f.path): \(f.content)")
    }
    
    // Brute-force: Compare each file with every other file
    var visited = Set<Int>() // avoid duplicate grouping
    var result: [[String]] = []
    
    for i in 0..<files.count {
        if visited.contains(i) { continue }
        var group: [String] = [files[i].path]
        for j in i+1..<files.count {
            if files[i].content == files[j].content {
                group.append(files[j].path)
                visited.insert(j)
            }
        }
        if group.count > 1 {
            result.append(group)
        }
    }
    
    print("\nDuplicate Groups Found:")
    for group in result {
        print(group)
    }
    
    return result
}

findDuplicateFilesBF([
    "root/a 1.txt(abcd) 2.txt(efgh)",
    "root/c 3.txt(abcd)",
    "root/c 4.txt(efgh)",
    "root/d 4.txt(efgh)"
])


// MARK: Hash Set

/*
 Time Complexity: O(n) average (Set insert/contains)
 Space Complexity: O(n) (Sets + allFiles array)
*/

methodLabel("Problem 3: Duplicate File in System", .hashSet)

func findDuplicateFilesHS(_ paths: [String]) -> [[String]] {
    var seenContents = Set<String>()
    var duplicateContents = Set<String>()
    var allFiles: [(fullPath: String, content: String)] = []
    
    // Step 1: Parse files and detect duplicate content
    for pathInfo in paths {
        let parts = pathInfo.split(separator: " ")
        let dir = String(parts[0])
        
        for file in parts.dropFirst() {
            if let openParen = file.firstIndex(of: "("),
               let closeParen = file.firstIndex(of: ")") {
                let filename = file[..<openParen]
                let content = file[file.index(after: openParen)..<closeParen]
                let fullPath = dir + "/" + filename
                
                allFiles.append((fullPath, String(content)))
                
                if seenContents.contains(String(content)) {
                    duplicateContents.insert(String(content))
                } else {
                    seenContents.insert(String(content))
                }
                
                print("Processed: \(fullPath) → Content: \(content)")
                print("Seen Contents: \(seenContents)")
                print("Duplicate Contents: \(duplicateContents)\n")
            }
        }
    }
    
    // Step 2: Collect duplicate file paths grouped by content
    var result: [[String]] = []
    for content in duplicateContents {
        let group = allFiles.filter { $0.content == content }.map { $0.fullPath }
        result.append(group)
    }
    
    print("Duplicate Groups Found:")
    for group in result {
        print(group)
    }
    
    return result
}

findDuplicateFilesHS([
    "root/a 1.txt(abcd) 2.txt(efgh)",
    "root/c 3.txt(abcd)",
    "root/c 4.txt(efgh)",
    "root/d 4.txt(efgh)"
])
