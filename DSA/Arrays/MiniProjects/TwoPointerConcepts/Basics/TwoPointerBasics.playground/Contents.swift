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
