//  Two Pointers – Group 1: Pure Basics
//  ---------------------------------------------------------------
//
//  🎯 Concept Focus:
//  Foundational left/right pointer movement. No sorting or data structures.
//  Pure O(n) scans replacing O(n²) brute force.
//
//  💡 Key Idea:
//  Two pointers walk toward each other (or forward together) to compare,
//  swap, or conditionally move.
//
//  🧩 Pro Tip:
//  Perfect for palindrome checks, reversing arrays, merging, and simple scans.


import Cocoa


// MARK: Print Statements Helper

enum MethodType: String {
    case bruteForce = "💡 BRUTE FORCE"
    case twoPointer = "⚡️ TWO POINTER"
}

func methodLabel(_ problem: String,  _ method: MethodType)  {
    return print("\(problem) \(method.rawValue)")
}


// MARK: -   Problem 1: Reverse an Array

/* Goal:
 Reverse the entire array in place
 Example:
 Input:  [1, 2, 3, 4, 5]
 Output: [5, 4, 3, 2, 1]
 
 */

var arr = [1, 2, 3, 4, 5]

// MARK: Brute Force
// Time Complexity: O(n²) → nested loop shifting elements
// Space Complexity: O(1) → in-place, but slow

methodLabel("Problem 1: Reverse an Array", .bruteForce)

func reverseArrayBF(_ nums: inout [Int]) {
    print("Original array: \(nums)")
    for i in 0..<nums.count {
        // Move nums[i] to the front by shifting all elements to the right
        let temp = nums[i]
        for j in stride(from: i, to: 0, by: -1) {
            nums[j] = nums[j - 1]
        }
        nums[0] = temp
        print("After moving index \(i) to front: \(nums)")
    }
}

reverseArrayBF(&arr)


var arr2 = [1, 2, 3, 4, 5]

// MARK: Two Pointer
// Time Complexity: O(n) — one loop
// Space Complexity: O(1)

methodLabel("Problem 1: Reverse an Array", .twoPointer)

func reverseArrayTP(_ nums: inout [Int]) {
    var start = 0
    var end = nums.count - 1
    
    print("Original array: \(nums)")
    
    while start < end {
        print("Swapping index \(start) (\(nums[start])) with index \(end) (\(nums[end]))")
        
        // Swap using a temporary variable
        //        let temp = nums[start]
        //        nums[start] = nums[end]
        //        nums[end] = temp
        
        // Swap using swapAt()
        nums.swapAt(start, end)
        
        print("Array after swap: \(nums)")
        
        start += 1
        end -= 1
    }
    
    print("Reversed array: \(nums)")
}

reverseArrayTP(&arr2)


// MARK: - Problem 2: Check if a String is Palindrome

/* Goal:
 Check if a string reads the same forward/backward.
 Example:
 Input:  "racecar"
 Output: true
 
 */


// MARK: Brute Force
// Time Complexity: O(n)
// Space Complexity: O(n)

methodLabel("Problem 2: Check if a String is Palindrome", .bruteForce)


func isPalindromeBF(_ input: String) -> Bool {
    let lowercasedInput = input.lowercased()
    let reversed = String(lowercasedInput.reversed())
    print("lower cased input: \(lowercasedInput), reversed input: \(reversed)")
    print("Plaindrome foud: \(lowercasedInput == reversed)")
    return input.lowercased() == reversed
}

isPalindromeBF("racecar")



// MARK: Two Pointer
// Time Complexity: O(n)
// Space Complexity: O(n) → Converting String to Array

methodLabel("Problem 2: Check if a String is Palindrome", .twoPointer)


func isPalindromeTP(_ input: String) -> Bool {
    let chars = Array(input.lowercased())
    var start = 0
    var end = chars.count - 1
    
    print("Checking if \"\(input)\" is a palindrome...")
    
    while start < end {
        print("Comparing index \(start) (\(chars[start])) with index \(end) (\(chars[end]))")
        if chars[start] != chars[end] {
            print("Mismatch found! Not a palindrome.")
            return false
        }
        start += 1
        end -= 1
    }
    
    print("All characters matched. It is a palindrome!")
    return true
}


isPalindromeTP("racecar")

// MARK: Two Pointer (Starting From Middle)
// Time Complexity: O(n) → You compare each character at most once while expanding from the middle (n / 2 + n / 2 ≈ n → O(n))
// Space Complexity: O(n) → Converting String to Array

func expandAroundCenter(_ chars: [Character], _ left: Int, _ right: Int) -> Bool {
    var l = left
    var r = right
    
    while l >= 0 && r < chars.count {
        print("Comparing index \(l) (\(chars[l])) with index \(r) (\(chars[r]))")
        if chars[l] != chars[r] {
            return false
        }
        l -= 1
        r += 1
    }
    
    return true
}


func isPalindromeMiddle(_ input: String) -> Bool {
    let chars = Array(input.lowercased())
    let n = chars.count
    
  
    if n % 2 == 1 {
        // Odd length center only
        return expandAroundCenter(chars, n/2, n/2)
    } else {
        // Even length center only
        return expandAroundCenter(chars, n/2 - 1, n/2)
    }
}

isPalindromeMiddle("racecar")


// MARK: - Problem 3: Merge Two Sorted Arrays

/* Goal:
    Merge two sorted arrays into one sorted list.
 Example:
    Input: nums1 = [1,3,5], nums2 = [2,4,6]
    Output: [1,2,3,4,5,6]
 
 */


// MARK: Brute Force
// Time Complexity: O((n+m)log(n+m))
// Space Complexity: O(n + m)

methodLabel("Problem 3: Merge Two Sorted Arrays", .bruteForce)


func mergeTwoSortedArrayBF(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var result = nums1 + nums2
    
    print("Before sorting: \(result)")
    
    result.sort()
    
    print("After sorting: \(result)")
    
    return result
}


mergeTwoSortedArrayBF([1,3,5], [2,4,6])


// MARK:  Two Pointer
// Time Complexity: O((n+m)
// Space Complexity: O(n + m)

methodLabel("Problem 3: Merge Two Sorted Arrays", .twoPointer)


func mergeTwoSortedArrayTP(_ a: [Int], _ b: [Int]) -> [Int] {
    var i = 0
    var j = 0
    var result: [Int] = []

    // Compare both arrays
    while i < a.count && j < b.count {
        print("Comparing A[\(i)] = \(a[i]) with B[\(j)] = \(b[j])")

        if a[i] <= b[j] {
            print("→ Appending \(a[i]) from A")
            result.append(a[i])
            i += 1
        } else {
            print("→ Appending \(b[j]) from B")
            result.append(b[j])
            j += 1
        }

        print("Current Result:", result)
        print("---")
    }

    // Append remaining elements from A
    while i < a.count {
        print("A has leftover element \(a[i]) → Appending")
        result.append(a[i])
        i += 1
        print("Current Result:", result)
    }

    // Append remaining elements from B
    while j < b.count {
        print("B has leftover element \(b[j]) → Appending")
        result.append(b[j])
        j += 1
        print("Current Result:", result)
    }

    print("Final Merged Result:", result)

    return result
}


mergeTwoSortedArrayTP([1,3,5], [2,4,6])



// MARK: - Problem 4: Remove Duplicates from Sorted Array

/* Goal:
    Compress duplicates in-place and return the length of the unique portion
 Example:
    Input:  [1,1,2,2,3]
    Output: length = 3, array = [1,2,3,...]
 
 */


// MARK: Brute Force
// Time Complexity: O(n)
// Space Complexity: O(n)

methodLabel("Problem 4: Remove Duplicates from Sorted Array", .bruteForce)


func removeDuplicatesFromSortedArrayBF(_ nums: inout [Int]) -> Int {
    print("Original array:", nums)
    
    var unique: [Int] = []

    print("\n--- First Pass: Collect Unique Elements ---")
    for i in 0..<nums.count {
        print("\nChecking index \(i): value = \(nums[i])")

        if i == 0 || nums[i] != nums[i - 1] {
            print("→ Unique value found! Appending \(nums[i]) to unique array.")
            unique.append(nums[i])
            print("  unique now =", unique)
        } else {
            print("→ Duplicate of \(nums[i - 1]). Skipping.")
        }
    }

    print("\n--- Second Pass: Copy Unique Back Into nums ---")
    for i in 0..<unique.count {
        print("Copying unique[\(i)] = \(unique[i]) → nums[\(i)]")
        nums[i] = unique[i]
        print("  nums now =", nums)
    }

    print("\nFinal unique count:", unique.count)
    print("Final nums (first \(unique.count) elems):", Array(nums.prefix(unique.count)))

    return unique.count
}


var array3 = [1,1,2,2,3]

removeDuplicatesFromSortedArrayBF(&array3)

// MARK: In Place Brute Force
// Time Complexity: O(n^2)  → Every time a duplicate is found, we have to shift all the elements to the left  → Sum of shifts ≈ n + (n-1) + (n-2) + … ≈ O(n²)
// Space Complexity: O(1)  → Only using (i, length, j) variables

func removeDuplicatesInPlaceBF(_ nums: inout [Int]) -> Int {
    print("Original array:", nums)
    
    var length = nums.count
    var i = 1 // start from index 1
    
    while i < length {
        print("\nChecking index \(i): value = \(nums[i]), previous = \(nums[i - 1])")
        
        if nums[i] == nums[i - 1] {
            print("→ Duplicate found! Shifting elements left...")
            
            // Shift left
            for j in i..<length - 1 {
                nums[j] = nums[j + 1]
                print("  After shifting, nums[\(j)] = \(nums[j])")
            }
            
            length -= 1
            print("Updated length:", length)
            // Do not increment i, need to check new value at index i
        } else {
            print("→ Unique element. Move to next index.")
            i += 1
        }
    }
    
    print("\nFinal compressed array (first \(length) elements):", Array(nums.prefix(length)))
    return length
}

var arr3 = [1,1,2,2,3]
removeDuplicatesInPlaceBF(&arr3)



// MARK: Two Pointer
// Time Complexity: O(n)   → Using i as read pointer to scan the entire array
// Space Complexity: O(1)  →  Only using write pointer to overwrites the array in place with unique values

methodLabel("Problem 4: Remove Duplicates from Sorted Array", .twoPointer)


func removeDuplicatesFromSortedArrayTP(_ nums: inout [Int]) -> Int {
    print("Original array:", nums)
    var write = 0

    for i in 0..<nums.count {
        print("\nChecking index \(i): value = \(nums[i])")

        if i == 0 || nums[i] != nums[i - 1] {
            print("→ New unique element found!")

            print("  Writing nums[\(write)] = \(nums[i])")
            nums[write] = nums[i]

            write += 1
            print("  Updated write pointer → \(write)")
        } else {
            print("→ Duplicate of \(nums[i - 1]). Skipping.")
        }
    }

    print("\nFinal compressed array (first \(write) elements):", Array(nums.prefix(write)))
    return write
}

var array4 = [1,1,2,2,3]

removeDuplicatesFromSortedArrayTP(&array4)


// MARK: - Problem 5: Square and Sort a Sorted Array

/* Goal:
    Use two pointers on left/right, square values, fill output from largest → smallest.
 Example:
    Input:  [-4, -1, 0, 3, 10]
    Output: [0,1,9,16,100]
 
 */


// MARK: Brute Force
// Time Complexity: O(n)
// Space Complexity: O(n)

methodLabel("Problem 5: Square and Sort a Sorted Array", .bruteForce)

func squareAndSortArrayBF(_ input: [Int]) -> [Int] {
    var result: [Int] = []
    
    for i in 0..<input.count {
        let squared = input[i] * input[i]
        print("number squared: \(squared), appending to result: \(result)")
        result.append(squared)
    }
    
    result.sort()
    
    print("FInal result: \(result)")
    
    return result
}

squareAndSortArrayBF( [-4, -1, 0, 3, 10])



// MARK: Two Pointer
// Time Complexity: O(n)  → process each element exactly once: every iteration either moves left or right.
// Space Complexity: O(n) → create a result array of the same size as input

methodLabel("Problem 5: Square and Sort a Sorted Array", .twoPointer)

func squareAndSortArrayTP(_ input: [Int]) -> [Int] {
    var result = Array(repeating: 0, count: input.count)
    
    var left = 0
    var right = input.count - 1
    var position = input.count - 1  // Fill from the end
    
    print("Original array:", input)
    
    // left <= right to handle the middle element in odd-length arrays.
    while left <= right {
        let leftSquare = input[left] * input[left]
        let rightSquare = input[right] * input[right]
        
        print("Comparing squares: left(\(left))^2 = \(leftSquare) vs right(\(right))^2 = \(rightSquare)")
        
        if leftSquare > rightSquare {
            print("→ Placing \(leftSquare) at result[\(position)]")
            result[position] = leftSquare
            left += 1
        } else {
            print("→ Placing \(rightSquare) at result[\(position)]")
            result[position] = rightSquare
            right -= 1
        }
        
        position -= 1
        print("Current result array:", result)
        print("Pointers → left: \(left), right: \(right), next pos: \(position)")
    }
    
    print("Final sorted squares:", result)
    return result
}


squareAndSortArrayTP( [-4, -1, 0, 3, 10])




// MARK: - Problem 6: Move Zeroes

/* Goal:
    Move all zeros to the end while keeping order of non-zero elements.
 Example:
    Input:  [0,1,0,3,12]
    Output: [1,3,12,0,0]
 
 */


// MARK: Brute Force
// Time Complexity: O(n)
// Space Complexity: O(n)

methodLabel("Problem 6: Move Zeroes", .bruteForce)


func moveZerosBF(_ nums: [Int]) -> [Int] {
    var result = Array(repeating: 0, count: nums.count)
    var zerosPos = 0
    
    print("Original array: \(nums)")
 
    for i in 0..<nums.count {
        let current = nums[i]
        print("Checking index \(i): value = \(current)")
        
        if current != 0 {
            print("→ Non-zero found. Placing \(current) at result[\(zerosPos)]")
            result[zerosPos] = current
            zerosPos += 1
        } else {
            print("→ Zero found. Skipping for now.")
        }
        
        print("Current result array: \(result)")
        print("Next zerosPos: \(zerosPos)")
    }
    
    print("Final array after moving zeros:", result)
    
    return result
}

moveZerosBF([0,1,0,3,12])



// MARK: Two Pointer
// Time Complexity: O(n)
// Space Complexity: O(1) → in-place, only a few pointers used

methodLabel("Problem 6: Move Zeroes", .twoPointer)

func moveZerosTP(_ nums: inout [Int]) -> [Int] {
    var zerosPos = 0
    
    print("Original array:", nums)
    print("---- Moving non-zero elements forward ----")
    
    for i in 0..<nums.count {
        let current = nums[i]
        print("Checking index \(i): value = \(current)")
        
        if current != 0 {
            print("→ Non-zero found. Placing \(current) at nums[\(zerosPos)]")
            nums[zerosPos] = current
            zerosPos += 1
        } else {
            print("→ Zero found. Skip for now.")
        }
        
        print("Current array:", nums)
        print("Next zerosPos:", zerosPos)
    }
    
    print("---- Filling remaining positions with zeros ----")
    for i in zerosPos..<nums.count {
        nums[i] = 0
        print("Setting nums[\(i)] = 0, Current array:", nums)
    }
    
    print("Final array after moving zeros:", nums)
    return nums
}


var arr4 = [0,1,0,3,12]

moveZerosTP(&arr4)
