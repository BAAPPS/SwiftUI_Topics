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


// MARK: - Problem 4: Unique Email Addresses

/*
 Goal:
 Given a list of email addresses, determine how many unique emails actually receive mail after normalization.
 → Ignore everything after '+' in the local name.
 → Ignore '.' characters in the local name.
 → The domain name remains unchanged.
 → Use a HashSet to store normalized emails and count unique entries.
 Example:
 Input: ["a@leetcode.com","a+1@leetcode.com"]
 Output: 1
 */

// Helper
func normalize(_ email: String) -> String {
    let parts = email.split(separator: "@")
    
    let local = String(parts[0])
        .split(separator: "+")[0]
    let cleanedLocal = String(local).replacingOccurrences(of: ".", with: "")
    
    let domain = String(parts[1])
    
    let finalizedEmail = cleanedLocal + "@" + domain
    
    print("local: \(local), cleaned local: \(cleanedLocal), domain: \(domain)")
    print(" → Email finalized: \(finalizedEmail)")
    
    return finalizedEmail
}

// MARK: Brute Force

/*
 Time Complexity: O(n²)
 → n = number of email addresses
 → Each email is normalized in O(k) time (k = length of email)
 → For each normalized email, we use `.contains()` on an array,
 which scans up to O(n) elements
 → Overall time complexity: O(n²)
 Space Complexity: O(n)
 → Stores up to n normalized email addresses
 → Each stored email has bounded length
 */
methodLabel("Problem 4: Unique Email Addresses", .bruteForce)


func uniqueEmailAddressBF(_ emails: [String]) -> Int {
    var normalized: [String] = []
    
    for email in emails {
        let normalizing = normalize(email)
        print(" → Normalizing email: \(normalizing)")
        
        if !normalized.contains(normalizing){
            normalized.append(normalizing)
            print("Email normalized: \(normalized)")
        } else {
            print("Email already normalize, Skipping...")
        }
        
    }
    
    print("Final count of unique \(normalized.count > 1 ? "emails" : "email"): \(normalized.count)")
    return normalized.count
}

uniqueEmailAddressBF(["a@leetcode.com","a+1@leetcode.com"])

// MARK: Hash Set

/*
 Time Complexity: O(n)
 → n = number of emails
 → Each email is normalized in O(k)
 → HashSet insert & lookup are O(1) average
 → Overall: O(n)
 
 Space Complexity: O(n)
 → HashSet stores up to n unique normalized emails
 */


methodLabel("Problem 4: Unique Email Addresses", .hashSet)

func uniqueEmailAddressHS(_ emails: [String]) -> Int {
    var seenEmails = Set<String>()
    
    for email in emails {
        let normalizedEmail = normalize(email)
        print(" → Email normalized: \(normalizedEmail)")
        seenEmails.insert(normalizedEmail)
    }
    
    print("Final count of unique \(seenEmails.count > 1 ? "emails" : "email"): \(seenEmails.count)")
    return seenEmails.count
}


uniqueEmailAddressHS(["a@leetcode.com","a+1@leetcode.com", "a.1@leetcode.com"])


// MARK: - Problem 5: Valid Sudoku

/*
 Goal:
 Verify whether a partially filled 9×9 Sudoku board is valid by ensuring that no digit (1–9) repeats within any row, column,
 or 3×3 sub-grid, using HashSets to track constraints efficiently.
 Example:
 Input: 9×9 board
 Output: true/false
 */


// MARK: Brute Force

/*
 Time Complexity: O(9 * 9 * 3) → O(1)
 → The board is always 9×9, so the triple nested loops for
 rows, columns, and 3×3 blocks are constant.
 → Conceptually:
 - Check all 9 rows: O(9*9)
 - Check all 9 columns: O(9*9)
 - Check all 9 blocks: O(9*9)
 → Total: O(243) → O(1) constant time for a fixed board
 
 Space Complexity: O(9) → O(1)
 → For each row, column, or block, we use a Set to track seen digits
 → Maximum size of Set = 9
 → Overall extra space is constant
 */
methodLabel("Problem 5: Valid Sudoku", .bruteForce)


func isValidSudokuBF(_ board: [[Character]]) -> Bool {
    // Check rows
    for i in 0..<9 {
        var seen = Set<Character>()
        for j in 0..<9 {
            let val = board[i][j]
            if val != "." {
                if seen.contains(val) {
                    print("❌ Duplicate '\(val)' found in row \(i) at column \(j)")
                    return false
                }
                seen.insert(val)
            }
        }
        print("✔ Row \(i) valid: \(seen)")
    }
    
    // Check columns
    for j in 0..<9 {
        var seen = Set<Character>()
        for i in 0..<9 {
            let val = board[i][j]
            if val != "." {
                if seen.contains(val) {
                    print("❌ Duplicate '\(val)' found in column \(j) at row \(i)")
                    return false
                }
                seen.insert(val)
            }
        }
        print("✔ Column \(j) valid: \(seen)")
    }
    
    // Check 3x3 blocks
    for blockRow in 0..<3 {
        for blockCol in 0..<3 {
            var seen = Set<Character>()
            for i in 0..<3 {
                for j in 0..<3 {
                    let val = board[blockRow*3 + i][blockCol*3 + j]
                    if val != "." {
                        if seen.contains(val) {
                            print("❌ Duplicate '\(val)' found in block (\(blockRow),\(blockCol)) at cell (\(i),\(j))")
                            return false
                        }
                        seen.insert(val)
                    }
                }
            }
            print("✔ Block (\(blockRow),\(blockCol)) valid: \(seen)")
        }
    }
    
    print("✅ Board is valid")
    return true
}

// Example usage for standard 9x9 board:
let board9x9: [[Character]] = [
    ["5","3",".",".","7",".",".",".","."],
    ["6",".",".","1","9","5",".",".","."],
    [".","9","8",".",".",".",".","6","."],
    ["8",".",".",".","6",".",".",".","3"],
    ["4",".",".","8",".","3",".",".","1"],
    ["7",".",".",".","2",".",".",".","6"],
    [".","6",".",".",".",".","2","8","."],
    [".",".",".","4","1","9",".",".","5"],
    [".",".",".",".","8",".",".","7","9"]
]

isValidSudokuBF(board9x9)


// MARK: Hash Set
/*
 Time Complexity: O(9 * 9 * 3) → O(1)
 → The board is always 9×9, so the nested loops over rows, columns, and 3×3 blocks are constant.
 → Conceptually:
 - Check all 9 rows: O(9*9)
 - Check all 9 columns: O(9*9)
 - Check all 9 blocks: O(9*9)
 → Total: O(243) → O(1) constant time for a fixed board
 
 Space Complexity: O(9) → O(1)
 → Each row, column, or block uses a Set to track seen digits (max size 9)
 → Overall extra space is constant
 */
methodLabel("Problem 5: Valid Sudoku", .hashSet)

/*
 Mapping a cell to its 3x3 sub-block
 
 In a 9x9 Sudoku board, there are 9 sub-blocks (3x3 each), indexed 0–8:
 
 0 | 1 | 2
 ---------
 3 | 4 | 5
 ---------
 6 | 7 | 8
 
 For any cell at (i, j):
 - blockRow = i / 3  → gives 0, 1, or 2
 - blockCol = j / 3  → gives 0, 1, or 2
 - blockIndex = blockRow * 3 + blockCol
 
 Example:
 - Cell (4,5):
 blockRow = 4 / 3 = 1
 blockCol = 5 / 3 = 1
 blockIndex = 1*3 + 1 = 4
 → Cell belongs to middle 3x3 block
 
 Use blockIndex to track digits seen in each block with a Set
 */

func getBlockIndex(i: Int, j: Int, n: Int) -> Int {
    let blockSize = Int(sqrt(Double(n)))
    return (i / blockSize) * blockSize + (j / blockSize)
}

func isValidSudokuHS(_ board: [[Character]]) -> Bool {
    let n = board.count     // For dynamic block index calculation
    let blockSize = Int(sqrt(Double(n)))  // For dynamic block index calculation
    
    var rows = Array(repeating: Set<Character>(), count: 9)
    var cols = Array(repeating: Set<Character>(), count: 9)
    var blocks = Array(repeating: Set<Character>(), count: 9)
    
    for i in 0..<9 {
        for j in 0..<9 {
            let val = board[i][j]
            if val == "." { continue }
            
            // blockIndex = (i / 3) * 3 + (j / 3) → maps any cell (i,j) to its 3x3 sub-block 0–8
            // let blockIndex = (i / 3) * 3 + (j / 3)
            
            // Block index calculation
            // Previously fixed for 9x9 boards: (i / 3) * 3 + (j / 3)
            // Now generalized: getBlockIndex(i:j:n:) dynamically computes the block index
            // for any n×n board with square sub-blocks
            let blockIndex = getBlockIndex(i: i, j: j, n: n)
            
            
            print("Checking cell [\(i),\(j)] = \(val)")
            
            if rows[i].contains(val) {
                print(" ❌ Duplicate in row \(i)")
                return false
            }
            
            if cols[j].contains(val) {
                print(" ❌ Duplicate in column \(j)")
                return false
            }
            
            
            if blocks[blockIndex].contains(val){
                print(" ❌ Duplicate in block \(blockIndex)")
                return false
            }
            
            rows[i].insert(val)
            cols[j].insert(val)
            blocks[blockIndex].insert(val)
            
            print(" ✔ Inserted in row, col, block sets")
        }
    }
    print("Board is valid ✅")
    return true
}

isValidSudokuHS(board9x9)



// MARK: - Problem 6: Word Search

/*
 Goal:
 Determine if a given word can be constructed by sequentially adjacent letters in a 2D board.
 → Letters must be horizontally or vertically neighboring.
 → Each cell can be used at most once per word.
 
 Example:
 Input:
 board = [
 ["A","B","C","E"],
 ["S","F","C","S"],
 ["A","D","E","E"]
 ],
 word = "ABCCED"
 
 Output:  true
 
 */


// MARK: - Word Search (Brute Force / DFS + Backtracking)

/*
 Time Complexity: O(M * N * 4^L)
     → M x N = number of cells in the board
     → L = length of the word
     → 4^L = exploring 4 directions at each step

 Space Complexity: O(L)
    → Visited path and recursion stack can go up to length of the word
 */
methodLabel("Problem 6: Word Search", .bruteForce)

func exist(_ board: [[Character]], _ word: String) -> Bool {
    let rows = board.count
    let cols = board[0].count
    
    var visited = Set<[Int]>()
    
    let directions: [(Int, Int)] = [(1,0), (-1,0), (0,1), (0,-1)] // down, up, right, left

    func backtrack(_ row: Int, _ col: Int, _ index: Int) -> Bool {
        if index == word.count { return true }
        if row < 0 || col < 0 || row >= rows || col >= cols || visited.contains([row, col]) { return false }
        
        let currentChar = word[word.index(word.startIndex, offsetBy: index)]
        if board[row][col] != currentChar { return false }
        
        visited.insert([row, col])
        
        for (dr, dc) in directions {
            if backtrack(row + dr, col + dc, index + 1) {
                return true
            }
        }
        
        visited.remove([row, col])
        return false
    }
    
    for row in 0..<rows {
        for col in 0..<cols {
            if backtrack(row, col, 0) {
                return true
            }
        }
    }
    
    return false
}

func existsDebug(_ board: [[Character]], _ word: String) -> Bool {
    let rows = board.count
    let cols = board[0].count
    
    var visitedSet = Set<[Int]>()   // For O(1) membership check
    var path: [[Int]] = []          // To track actual order of traversal
    
    let directions: [(Int, Int)] = [(1,0), (-1,0), (0,1), (0,-1)] // down, up, right, left

    func backtrack(_ row: Int, _ col: Int, _ index: Int) -> Bool {
        if index == word.count {
            print("✅ Word found along path: \(path.map { "(\($0[0]),\($0[1]))" }.joined(separator: " -> "))")
            return true
        }
        
        // Boundary and visited check
        if row < 0 || col < 0 || row >= rows || col >= cols || visitedSet.contains([row, col]) {
            return false
        }
        
        let currentChar = word[word.index(word.startIndex, offsetBy: index)]
        if board[row][col] != currentChar { return false }
        
        // Mark current cell
        visitedSet.insert([row, col])
        path.append([row, col])
        print("→ Visiting (\(row),\(col)) for '\(currentChar)', path: \(path.map { "(\($0[0]),\($0[1]))" }.joined(separator: " -> "))")
        
        // Explore all 4 directions
        for (dr, dc) in directions {
            if backtrack(row + dr, col + dc, index + 1) {
                return true
            }
        }
        
        // Backtrack
        print("← Backtracking from (\(row),\(col))")
        visitedSet.remove([row, col])
        path.removeLast()
        return false
    }
    
    for row in 0..<rows {
        for col in 0..<cols {
            if backtrack(row, col, 0) {
                return true
            }
        }
    }
    
    print("❌ Word not found")
    return false
}

// Example usage
let board: [[Character]] = [
    ["A","B","C","E"],
    ["S","F","C","S"],
    ["A","D","E","E"]
]

existsDebug(board, "ABCCED")
