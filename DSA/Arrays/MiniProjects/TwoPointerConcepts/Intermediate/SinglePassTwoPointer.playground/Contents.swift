// ---------------------------------------------------------------
// Two Pointers – Group 4: True Single-Pass Two Pointer Technique
// ---------------------------------------------------------------
//
// 🎯 Purpose:
// This technique uses **two pointers moving in a single linear pass** to solve problems.
// Pointers can move from opposite ends (left/right) or at different speeds (slow/fast),
// but **each pointer moves in one direction without backtracking**.
//
// 📈 When Sorting is Needed:
// - Sorting is required **only if pointer movement relies on value ordering**
//   (e.g., finding pairs with a target sum or minimizing/maximizing differences).
// - Without sorting, moving left/right may not reliably improve results.
//
// 🔥 Advantages of Single-Pass Two Pointers:
// - O(n) linear time (no nested loops needed)
// - Each pointer adjustment brings you closer to the goal
// - Can skip impossible cases efficiently
// - Works on both value-ordered arrays (sorted) or index-based logic (unsorted)
//
// ⚠️ Important Notes:
// - This **is not a sliding window** technique; there is no variable-size window adjustment.
// - Always determine whether **sorting is required** based on problem constraints.
// - True single-pass: **each pointer moves at most n steps**, guaranteeing linear complexity.
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



// MARK: - Problem 1: Reverse an Array In-Place

/* Goal:
 Reverse the array using left/right pointers moving inward in a single pass.
 Example:
 Input: [1,2,3,4,5]
 Output: [5,4,3,2,1]
 */


// MARK: - Brute Force
// Time Complexity: O(n^2) → Nested loops; each element requires shifting
// Space Complexity: O(1)  → In-place element shifting (no extra storage)

methodLabel("Problem 1: Reverse an Array In-Place", .bruteForce)

func reverseArrayBF(_ nums: inout [Int]){
    print("Original array: \(nums)")
    for i in 0..<nums.count {
        let temp = nums[i]
        for j in stride(from: i, to: 0, by: -1) {
            nums[j] = nums[j-1]
        }
        nums[0] = temp
        print("After moving index \(i) to front: \(nums)")
    }
}

var numsBF = [1,2,3,4,5]
reverseArrayBF(&numsBF)


// MARK: Two Pointer (Single Pass)
// Time Complexity: O(n)  → Single traversal from both ends
// Space Complexity: O(1) → In-place swap operations

methodLabel("Problem 1: Reverse an Array In-Place", .twoPointer)


func reverseArrayTP(_ nums: inout [Int]){
    var start = 0
    var end = nums.count - 1
    
    while start < end {
        print("Swapping index \(start) (\(nums[start])) with index \(end) (\(nums[end]))")
        var temp = nums[start]
        nums[start] = nums[end]
        nums[end] = temp
        
        //        nums.swapAt(start, end)
        
        print("Array after swap: \(nums)")
        
        start += 1
        end -= 1
        
    }
    print("Reversed array: \(nums)")
}


var nums = [1,2,3,4,5]

reverseArrayTP(&nums)



// MARK: - Problem 2: Container With Most Water

/*
 Goal:
 Find the maximum amount of water that can be contained between any
 two vertical lines. The area is determined by the shorter line × the
 distance between the lines.
 Example:
 Input:  [1,8,6,2,5,4,8,3,7]
 Output: 49
 */


// MARK: Brute Force
// Time Complexity: O(n^2) → Check all pairs (i, j)
// Space Complexity: O(1)  → No extra storage

methodLabel("Problem 2: Container With Most Water", .bruteForce)


func containerWithMostWaterBF(_ nums: [Int]) -> Int {
    var maxArea: Int = 0
    
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            let height = min(nums[i], nums[j])
            let width = j - i
            let area = height * width
            print("Comparing indices \(i) (\(nums[i])) and \(j) (\(nums[j])) → height=\(height), width=\(width), area=\(area)")
            maxArea = max(maxArea, area)
        }
    }
    
    print("Max area = \(maxArea)")
    return maxArea
}


containerWithMostWaterBF([1,8,6,2,5,4,8,3,7])


// MARK: Two Pointer
// Time Complexity: O(n)  → Each pointer moves at most n steps, single traversal
// Space Complexity: O(1) → In-place computation, no extra storage


methodLabel("Problem 2: Container With Most Water", .twoPointer)


func containerWithMostWaterTP(_ nums: [Int]) -> Int {
    var maxArea: Int = 0
    var start = 0
    var end = nums.count - 1
    
    
    while start < end {
        let height = min(nums[start], nums[end])
        let width = end - start
        let area = height * width
        maxArea = max(maxArea, area)
        print("Comparing indices \(start) (\(nums[start])) and \(end) (\(nums[end])) → height=\(height), width=\(width), area=\(area)")
        
        // Move the shorter line, only way to potentially get a taller “shorter line” and increase area
        if nums[start] < nums[end] {
            start += 1
        } else {
            end -= 1
        }
    }
    
    print("Max area = \(maxArea)")
    return maxArea
}

containerWithMostWaterTP([1,8,6,2,5,4,8,3,7])



// MARK: - Problem 3: Move Zeroes

/*
 Goal:
 Reorder an array so that all zeros are moved to the end while
 maintaining the relative order of non-zero elements. Perform this
 operation in-place without using extra space.
 Example:
 Input:  [0,1,0,3,12]
 Output: [1,3,12,0,0]
 */


// MARK:  Brute Force
// Time Complexity: O(n^2) → Nested loops; each zero may check all following elements
// Space Complexity: O(1)   → In-place swaps, no extra storage

methodLabel("Problem 3: Move Zeroes", .bruteForce)

func moveZerosBF(_ nums: inout [Int]) {
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

var moveZerosBF = [1, 2, 0, 4, 0, 3]

moveZerosBF(&moveZerosBF)

// MARK: Two Pointer
// Time Complexity: O(n) → Single traversal of the array
// Space Complexity: O(1) → In-place swaps, no extra storage

methodLabel("Problem 3: Move Zeroes", .twoPointer)

func moveZerosTP(_ nums: inout [Int]) {
    var nonZeroIndex = 0
    
    for i in 0..<nums.count {
        if nums[i] != 0 {
            if i != nonZeroIndex { // Only swap if needed
                print("Swapping nums[\(i)] (\(nums[i])) with nums[\(nonZeroIndex)] (\(nums[nonZeroIndex]))")
                //  nums.swapAt(i, nonZeroIndex)
                let temp = nums[i]
                nums[i] = nums[nonZeroIndex]
                nums[nonZeroIndex] = temp
                print("Array after swap: \(nums)\n")
            }
            nonZeroIndex += 1
        } else {
            print("Found zero at index \(i), waiting to swap...")
        }
    }
    print("Final array: \(nums)")
}

var moveZerosTP = [1, 2, 0, 4, 0, 3]

moveZerosTP(&moveZerosTP)


// MARK: - Problem 4: Remove Duplicates from Sorted Array

/*
 Goal:
    Remove duplicates from a sorted array in-place. Return the new length of the array.
 Example:
    Input:  [1,1,2,2,3]
    Output: length = 3, array = [1,2,3,...]
*/



// MARK: Brute Force
// Time Complexity: O(n^2) → For each element, check all previous elements for duplicates
// Space Complexity: O(1)  → In-place; no extra storage

methodLabel("Problem 4: Remove Duplicates from Sorted Array", .bruteForce)


func removeDuplicatesBF(_ nums: inout [Int]) -> Int {
    if nums.isEmpty { return 0 }
    
    var length = 1 // first element is always unique
    print("Start array: \(nums)")
    print("Initial length: \(length)\n")
    
    for i in 1..<nums.count {
        var isDuplicate = false
        
        // Check all previous unique elements
        for j in 0..<length {
            if nums[i] == nums[j] {
                isDuplicate = true
                print("Duplicate found: nums[\(i)] = \(nums[i]) matches nums[\(j)] = \(nums[j])")
                break
            }
        }
        
        if !isDuplicate {
            print("Unique element found: nums[\(i)] = \(nums[i]), shifting to index \(length)")
            nums[length] = nums[i] // shift unique element forward
            length += 1
            print(" → Array after shift: \(nums)")
        }
    }
    
    print("Final array: \(nums)")
    print("New length: \(length)")
    return length
}

var arr = [1,1,2,2,3]
let newLength = removeDuplicatesBF(&arr)
// Duplicates “beyond length” don’t matter — the first length elements are all unique
print("Result array: \(Array(arr[0..<newLength]))")


// MARK: Two Pointer
// Time Complexity: O(n) → Single traversal of the array
// Space Complexity: O(1) → In-place; no extra storage

methodLabel("Problem 4: Remove Duplicates from Sorted Array", .twoPointer)

func removeDuplicatesTP(_ nums: inout [Int]) -> Int {
    if nums.isEmpty { return 0 }
    
    var length = 1 // slow pointer, position to place next unique element
    print("Start array: \(nums)")
    print("Initial length (slow pointer): \(length)\n")
    
    for i in 1..<nums.count { // fast pointer
        print("Fast pointer i = \(i), nums[i] = \(nums[i]), last unique nums[length-1] = \(nums[length - 1])")
        if nums[i] != nums[length - 1] { // compare with last unique
            print("Unique element found! Shifting nums[i] (\(nums[i])) to index length (\(length))")
            nums[length] = nums[i]     // shift unique element forward
            length += 1
            print("  → Array after shift: \(nums)\n")
        } else {
            print("  → Duplicate found, skipping nums[i] (\(nums[i]))\n")
        }
    }
    
    print("Final array with unique elements at the front: \(nums)")
    print("New length (number of unique elements): \(length)\n")
    
    return length
}

// Example usage
var arrTP = [1, 1, 2, 2, 3]
let newLengthTP = removeDuplicatesTP(&arrTP)
print("Unique elements: \(Array(arrTP[0..<newLengthTP]))")


// MARK: - Problem 5: Partition Array by Sign

/*
 Goal:
    Partition an unsorted array so that all negative numbers appear
    before all positive numbers. Use two pointers (left/right) moving
    inward in a single pass. Relative order within negative or positive
    partitions does not need to be preserved.
 Example:
    Input:  [3, -2, -1, 5, -4, 6]
    Output: [-2, -1, -4, 3, 5, 6]
*/


// MARK: Brute Force
// Time Complexity: O(n^2) → For each positive element, we may scan all remaining elements to find a negative
// Space Complexity: O(1) → In-place swaps, no extra storage

methodLabel("Problem 5: Partition Array by Sign", .bruteForce)

func partitionArrayBySignBF(_ nums: inout [Int]) {
    print("Start array: \(nums)\n")
    
    for i in 0..<nums.count {
        if nums[i] > 0 {
            print("Positive found at index \(i): nums[\(i)] = \(nums[i])")
            
            // find next negative element to swap
            for j in i+1..<nums.count {
                if nums[j] < 0 {
                    print("  → Swapping with negative nums[\(j)] = \(nums[j])")
                    nums.swapAt(i, j)
                    print("  → Array after swap: \(nums)\n")
                    break // only swap with first negative found
                } else {
                    print("  → Skipping nums[\(j)] = \(nums[j]) (not negative)")
                }
            }
        } else {
            print("Negative found at index \(i): nums[\(i)] = \(nums[i]), no action needed\n")
        }
    }
    
    print("Final array: \(nums)")
}

var partitionArray = [3, -2, -1, 2, 5, -4, 6]

partitionArrayBySignBF(&partitionArray)



// MARK:  Two Pointer
// Time Complexity: O(n) → Single pass through the array
// Space Complexity: O(1) → In-place swaps, no extra storage

methodLabel("Problem 5: Partition Array by Sign", .twoPointer)

func partitionArrayBySignTP(_ nums: inout [Int]) {
    print("Start array: \(nums)\n")
    var left = 0 // slow pointer for negatives
    
    for i in 0..<nums.count { // fast pointer
        print("Checking nums[\(i)] = \(nums[i])")
        if nums[i] < 0 {
            print(" → Negative found, swapping with nums[\(left)] = \(nums[left])")
            // nums.swapAt(i, left)
            let temp = nums[i]
            nums[i] = nums[left]
            nums[left] = temp
            left += 1
            print(" → Array after swap: \(nums)\n")
        } else {
            print(" → Positive found, no action needed\n")
        }
    }
    
    print("Final partitioned array: \(nums)")
}

var partitionArrTP = [3, 4, -2, -1, 5, -4, 6]
partitionArrayBySignTP(&partitionArrTP)




// MARK: -  Problem 6: Pair Sum Equals Target in Sorted Array

/*
 Goal:
    Determine if a pair of numbers exists in a **sorted array** whose sum equals a given target.
    Use two pointers (left/right) starting from the ends of the array and move inward
    to efficiently find the pair in a single pass.
 Example:
    Input:  nums = [1, 2, 3, 4, 6], target = 6
    Output: [2, 4]  // pair that sums to target
*/

// MARK: Brute Force
// Time Complexity: O(n^2) → Nested loops check all possible pairs
// Space Complexity: O(1) → Only loop variables; no extra storage


methodLabel("Problem 6: Pair Sum Equals Target in Sorted Array", .bruteForce)

func pairSumEqualsTargetBF(_ nums: [Int], _ target: Int) -> (Int, Int)? {
    let n = nums.count
    
    for i in 0..<n {
        for j in i+1..<n {
            let sum = nums[i] + nums[j]
            print("Checking nums[\(i)] = \(nums[i]) + nums[\(j)] = \(nums[j]) → sum = \(sum)")
            
            if sum == target {
                print(" → Found pair: (\(nums[i]), \(nums[j])) that sums to target \(target)")
                return (nums[i], nums[j])
            }
        }
    }
    
    print("No valid pair found that sums to target \(target)")
    return nil
}

pairSumEqualsTargetBF([1, 2, 3, 4, 6], 6)



// MARK: Two Pointer
// Time Complexity: O(n) → Single pass
// Space Complexity: O(1) → Only pointer variables

methodLabel("Problem 6: Pair Sum Equals Target in Sorted Array", .twoPointer)

func pairSumEqualsTargetTP(_ nums:[Int], _ target: Int) -> (Int, Int)? {
    var left = 0
    var right = nums.count - 1
    
    while left < right {
        let sum = nums[left] + nums[right]
        
        print("Checking nums[\(left)] = \(nums[left]) + nums[\(right)] = \(nums[right]) → sum = \(sum)")
        
        if sum == target {
            print("Found pair: (\(nums[left]), \(nums[right]))")
            return (nums[left], nums[right])
        } else if sum < target {
            left += 1
        } else {
            right -= 1
        }
    }
    
    print("No valid pair found")
    return nil
}

pairSumEqualsTargetBF([1, 2, 3, 4, 6], 6)
