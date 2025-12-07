// ---------------------------------------------------------------
// Two Pointers – Group 4: True Single-Pass (Fast & Slow Pointer)
// ---------------------------------------------------------------
//
// 🎯 Purpose:
// This technique uses **two pointers moving at different speeds** (fast & slow)
// in a single linear pass to solve problems like:
// - Removing duplicates in-place
// - Partitioning arrays
// - Detecting cycles in linked structures
//
// 📈 When Sorting is Needed:
// - Sorting is usually **not required** for fast/slow pointer problems because
//   the logic is often based on positions, not value order.
// - Sorting is only needed if pointer decisions depend on **value comparison**.
//
// 🔥 Advantages of Fast & Slow Pointers:
// - O(n) linear time complexity
// - Each pointer moves forward without backtracking
// - Efficiently handles duplicates, partitions, or cycles
// - Can track relative distances, detect overlaps, or compress sequences
//
// ⚠️ Important Notes:
// - This is **not a sliding window** technique; window size is implicit or conceptual
// - True single-pass: each pointer moves at most n steps
// - Carefully define fast/slow movement rules for correctness
//
// ---------------------------------------------------------------


import Cocoa


// MARK: Print Statements Helper

enum MethodType: String {
    case bruteForce = "💡 BRUTE FORCE"
    case twoPointer = "⚡️ TWO POINTER"
}

func methodLabel(_ problem: String,  _ method: MethodType)  {
    return print("\(problem) \(method.rawValue)")
}



// MARK: -  Problem 1: Remove Element In-Place

/*
 Goal:
 Remove all instances of a given value `val` from an array `nums` in-place.
 Use a single-pass approach with a slow pointer to track the position
 for the next non-val element. Return the new length of the array after removal.
 Example:
 Input:  nums = [3, 2, 2, 3, 4], val = 3
 Output: length = 3, array = [2, 2, 4, ...]  // first 3 elements are non-val
 */

// MARK: Brute Force
// Time Complexity: O(n^2) → nested shifts for each val
// Space Complexity: O(1)   → in-place, no extra storage

methodLabel("Remove Element In-Place", .bruteForce)

func removeElementInPlaceBF(_ nums: inout [Int], _ val: Int) -> Int {
    var length = nums.count
    var i = 0
    
    print("Start array: \(nums), remove val=\(val)\n")
    
    while i < length {
        if nums[i] == val {
            print("→  Found \(val) at index \(i) → shifting left")
            
            // Shift elements left
            for j in i..<length-1 {
                print(" →  shifting nums[\(j+1)] (\(nums[j+1])) → nums[\(j)]")
                nums[j] = nums[j+1]
            }
            
            length -= 1
            print(" → Array after shift: \(nums), new length=\(length)\n")
        } else {
            print("nums[\(i)] = \(nums[i]) (keep) → move i forward\n")
            i += 1
        }
    }
    
    print("Final array: \(nums)")
    print("Returned length = \(length)\n")
    
    return length
}

var arrBF = [3, 2, 2, 3, 4]
removeElementInPlaceBF( &arrBF, 3)

// MARK: Two Pointer
// Time Complexity: O(n) → Single pass
// Space Complexity: O(1)  → In-place, no shifting needed

methodLabel("Remove Element In-Place", .twoPointer)

func removeElementInPlaceTP(_ nums: inout [Int], _ val: Int) -> Int {
    // Slow pointer(start): next position to write non-val
    var start = 0
    print("Start array: \(nums), remove val = \(val)\n")
    
    // Fast pointer(end): scanning
    for end in 0..<nums.count {
        if nums[end] != val {
            print(" → nums[\(end)] = \(nums[end]) is not \(val) → write to index \(start)")
            nums[start] = nums[end]
            start += 1
        } else {
            print(" → nums[\(end)] = \(val) → skip")
        }
        print("Current array state: \(nums[0..<nums.count]), slow pointer at index \(start)\n")
    }
    
    print("Final valid array: \(Array(nums[0..<start]))")
    print("Returned length = \(start)\n")
    
    return start
}


var arrTP = [3, 2, 2, 3, 4]
removeElementInPlaceTP( &arrTP, 3)


// MARK: -  Problem 2: Move Zeroes
/*
 Goal:
 Move all zeros to the end while maintaining relative order of non-zero elements.
 Fast pointer scans, slow pointer tracks placement for next non-zero.
 Example:
 Input: [0,0,1,0,3,12]
 Output: [1,3,12,0,0,0]
 */

// MARK:  Brute Force
// Time Complexity: O(n^2) → Nested loops; each zero may check all following elements
// Space Complexity: O(1)  → In-place swaps, no extra storage

methodLabel(" Problem 2: Move Zeroes", .bruteForce)


func moveZerosBF(_ nums: inout [Int]){
    let n = nums.count
    print("Original array: \(nums)")
    
    for i in 0..<n {
        if nums[i] == 0 {
            for j in i+1..<n {
                if nums[j] != 0 {
                    print("Swapping zero at index \(i) with non-zero \(nums[j]) at index \(j)")
                    nums.swapAt(i, j)
                    print("Array after swap: \(nums)\n")
                    break
                }
            }
        }
    }
    
    print("Final array: \(nums)")
}

var moveZeroArryBF = [0,0,1,0,3,12]

moveZerosBF(&moveZeroArryBF)


// MARK:  Two Pointer
// Time Complexity: O(n) → Single pass through the array
// Space Complexity: O(1) → In-place swaps, no extra storage

methodLabel(" Problem 2: Move Zeroes", .twoPointer)

func moveZerosTP(_ nums: inout [Int]){
    var start = 0 // slow pointer: next position to place non-zero
    print("Start array: \(nums)\n")
    
    for end in 0..<nums.count { // fast pointer: scanning
        if nums[end] != 0 {
            print("nums[\(end)] = \(nums[end]) is non-zero → swap with index \(start)")
            let temp = nums[start]
            nums[start] = nums[end]
            nums[end] = temp
            start += 1
        } else {
            print("nums[\(end)] = 0 → skip")
        }
        print("Current array state: \(nums[0..<nums.count]), slow pointer at index \(start)\n")
    }
    
    print("Final array: \(nums)")
}


var moveZeroArryTP = [0,0,1,0,3,12]

moveZerosTP(&moveZeroArryTP)


// MARK: - Problem 3: Remove Duplicates from Sorted Array II
/*
 Goal:
 In a sorted array, allow at most **two occurrences** of each element.
 Use a single-pass approach with a slow pointer to track the next valid position
 and a fast pointer to scan the array.
 
 Keep elements in-place; elements beyond the new length are irrelevant.
 
 Example:
 Input:  [1,1,1,2,2,3]
 Output: length = 5  // array = [1,1,2,2,3,...]  // first 5 elements are valid
 */


// MARK: Brute Force
// Time Complexity: O(n^2) → In worst case, every removal requires shifting O(n) elements
// Space Complexity: O(1)  → In-place modification, no extra storage

methodLabel("Problem 3: Remove Duplicates from Sorted Array II", .bruteForce)


func removeDuplicatesII_BF(_ nums: inout [Int]) -> Int {
    var length = nums.count
    var i = 0
    
    print("Start array: \(nums), length: \(length)\n")
    
    while i < length {
        var count = 1
        
        // Count duplicates
        while i + count < length && nums[i] == nums[i + count] {
            count += 1
        }
        
        if count > 2 {
            let extra = count - 2
            print("Found more than 2 duplicates of \(nums[i]) starting at index \(i), removing \(extra) extras")
            
            // Shift elements left to remove extras
            for j in (i + 2)..<length {
                nums[j - extra] = nums[j]
            }
            
            length -= extra
            print("Array after removal: \(Array(nums[0..<length]))\n")
        }
        
        // Move i to the next group
        i += min(2, count)
    }
    
    print("Final array: \(Array(nums[0..<length]))")
    return length
}

var numsBF = [1,1,1,2,2,3]
let newLength = removeDuplicatesII_BF(&numsBF)
print("New length: \(newLength)")


// MARK: Two Pointer
// Time Complexity: O(n) → Single pass through the array
// Space Complexity: O(1)   → In-place modification, no extra storage

methodLabel("Problem 3: Remove Duplicates from Sorted Array II", .twoPointer)

func removeDuplicatesII_TP(_ nums: inout [Int]) -> Int {
    let n = nums.count
    if n <= 2 { return n } // First two elements are always valid
    
    var slow = 2 // position to place the next valid element
    
    print("Start array: \(nums)\n")
    
    for fast in 2..<n {
        // Compare current element with the element two positions before slow
        if nums[fast] != nums[slow - 2] {
            print("nums[\(fast)] = \(nums[fast]) is valid → placing at index \(slow)")
            nums[slow] = nums[fast]
            slow += 1
        } else {
            print("nums[\(fast)] = \(nums[fast]) is extra duplicate → skip")
        }
        print("Current array state: \(Array(nums[0..<slow])) + remaining: \(Array(nums[slow..<n]))\n")
    }
    
    print("Final array (first \(slow) elements are valid): \(Array(nums[0..<slow]))")
    return slow
}

var numsTP = [1,1,1,2,2,3]
let newLengthTP = removeDuplicatesII_TP(&numsTP)
print("New length: \(newLengthTP)")



// MARK: - Problem 4: Partition Array by Parity
/*
 Goal:
 Move all even numbers to the left, odd numbers to the right.
 Example:
 Input: [3,1,2,4]
 Output: [2,4,3,1]  // order within partitions not important
 */

// MARK:  Brute Force
// Time Complexity: O(n^2) → Worst case, for each odd element we may scan almost the entire remaining array
// Space Complexity: O(1) → In-place swaps, no extra storage

methodLabel("Problem 4: Partition Array by Parity", .bruteForce)

func partitionArrayByParity(_ nums: inout [Int]) {
    let n = nums.count
    
    print("Start array: \(nums)\n")
    
    for i in 0..<n {
        if nums[i] % 2 != 0 { // odd number found
            print("Found odd at index \(i) → \(nums[i])")
            for j in (i+1)..<n {
                if nums[j] % 2 == 0 { // even number to swap with
                    print(" → Swapping with even at index \(j) → \(nums[j])")
                    nums.swapAt(i, j)
                    print("Array after swap: \(nums)\n")
                    break
                }
            }
        } else {
            print("Index \(i) → \(nums[i]) is even, no action")
        }
    }
    
    print("Final array: \(nums)")
}

var  partitionArray = [3,1,2,4]

partitionArrayByParity(&partitionArray)


// MARK: Two Pointer
// Time Complexity: O(n) → Single pass through the array
// Space Complexity: O(1)   → In-place swaps, no extra storage

methodLabel("Problem 4: Partition Array by Parity", .twoPointer)

func partitionArrayByParityTP(_ nums: inout [Int]) {
    var start = 0
    
    print("Start array: \(nums)\n")
    
    for end in 0..<nums.count {
        if nums[end] % 2 == 0 {
            print("Even found at index \(end) → \(nums[end]), swapping with index \(start) → \(nums[start])")
            let temp =  nums[start]
            nums[start] = nums[end]
            nums[end] = temp
            start += 1
            print("Array after swap: \(nums)\n")
        } else {
            print("Odd found at index \(end) → \(nums[end]), no action")
        }
    }
    
    print("Final array: \(nums)")
}

var  partitionArrayTP = [3,1,2,4]

partitionArrayByParityTP(&partitionArrayTP)

// MARK: -  Problem 5: Remove All Adjacent Duplicates
/*
 Goal:
    Given a string, remove all adjacent duplicates using slow/fast pointer on character array.
    Slow pointer tracks the last valid character position.
 Example:
    Input: "abbaca"
    Output: "ca"  // remove "bb" then "aa"

 */

// MARK:  Brute Force
// Time Complexity: O(n^2) → Worst case, for each odd element we may scan almost the entire remaining array
// Space Complexity: O(1) → In-place swaps, no extra storage

methodLabel("Problem 5: Remove All Adjacent Duplicates", .bruteForce)


func removeAllAdjacentDuplicatesBF(_ str: String) -> String {
    var chars = Array(str)
    print("Start array: \(chars)\n")
    
    var i = 0
    while i < chars.count - 1 {
        if chars[i] == chars[i + 1] {
            print("Found adjacent duplicates: \(chars[i]) at indices \(i) and \(i+1)")
            // Remove the duplicates
            chars.remove(at: i + 1)
            chars.remove(at: i)
            print("Array after removal: \(chars)\n")
            // Move back one step to check for new adjacent duplicates
            if i > 0 { i -= 1 }
        } else {
            i += 1
        }
    }
    
    let result = String(chars)
    print("Final result: \(result)")
    return result
}

removeAllAdjacentDuplicatesBF("abbaca")




// MARK:  Two Pointer
// Time Complexity: O(n) → Single traversal of the array
// Space Complexity: O(1) → In-place modification, no extra storage

methodLabel("Problem 5: Remove All Adjacent Duplicates", .twoPointer)

func removeAllAdjacentDuplicatesTP(_ str: String) -> String {
    var chars = Array(str)
    print("Start array: \(chars)\n")
    
    var slow = -1  // points to the top of the “stack” of valid characters
    
    for fast in 0..<chars.count {
        if slow >= 0 && chars[fast] == chars[slow] {
            print("Found duplicate: \(chars[fast]) at index \(fast), removing top of stack at index \(slow)")
            // Found an adjacent duplicate:
            // - The top of our "stack" (chars[slow]) matches the current character (chars[fast]).
            // - We "pop" the top of the stack by decrementing slow, effectively removing the previous duplicate.
            // - We do NOT place the current character yet; it will be handled in subsequent iterations.
            slow -= 1
        } else {
            slow += 1
            chars[slow] = chars[fast]
            print("Placing \(chars[fast]) at index \(slow), current array: \(chars[0...slow])")
            //  Current character is not a duplicate of top of stack:
            // - Increment slow to "push" this character onto our stack of valid characters.
            // - This maintains all non-adjacent characters in the array up to index slow.
        }
    }
    
    let result = String(chars[0...slow])
    print("\nFinal result: \(result)")
    return result
}

removeAllAdjacentDuplicatesTP("abbaca")


// MARK: - Problem 6: Squared Sorted Array
/*
 Goal:
    Given a sorted array (can have negatives), return a new array of squares in sorted order.
    Fast pointers from both ends, slow pointer for filling result from back.
 Example:
    Input: [-4,-1,0,3,10]
    Output: [0,1,9,16,100]

 */

// MARK:  Brute Force
//Time Complexity: O(n log n) → sorting after squaring
//Space Complexity: O(n) → storing squared numbers in a new array

methodLabel("Problem 6: Squared Sorted Array", .bruteForce)

func sortedArraySquaredBF(_ nums: [Int]) -> [Int] {
    var result: [Int] = []
    
    for num in nums {
        result.append(num * num)
    }
    
    result.sort()
    return result
}

sortedArraySquaredBF( [-4,-1,0,3,10])


// MARK: Two Pointer Single Pass
// Time Complexity: O(n) → Single traversal of the array
// Space Complexity: O(n) → Result array to store squared numbers


methodLabel("Problem 6: Squared Sorted Array", .twoPointer)

// This is a single-pass approach using two pointers from both ends.
// It does not rely on the classical slow/fast pointer technique for in-place modifications,
// because squaring in-place can cause overwriting and potential overflow issues.
// Hence, we use a separate result array to safely store the squared values.
func sortedArraySquaredTPSingle(_ nums: [Int]) -> [Int] {
    var result = Array(repeating: 0, count: nums.count)
    var left = 0
    var right = nums.count - 1
    var pos = nums.count - 1
    
    print("Start array: \(nums)")
    
    while left <= right {
        let leftSq = nums[left] * nums[left]
        let rightSq = nums[right] * nums[right]
        
        if leftSq > rightSq {
            result[pos] = leftSq
            print("Placing \(leftSq) from left index \(left) at result index \(pos)")
            left += 1
        } else {
            result[pos] = rightSq
            print("Placing \(rightSq) from right index \(right) at result index \(pos)")
            right -= 1
        }
        
        pos -= 1
        print("Current result: \(result)")
    }
    
    print("Final sorted squares: \(result)")
    return result
}

sortedArraySquaredTPSingle([-4,-1,0,3,10])
