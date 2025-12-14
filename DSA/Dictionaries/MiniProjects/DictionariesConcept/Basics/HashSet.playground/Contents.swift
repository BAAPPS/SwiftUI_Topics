// ---------------------------------------------------------------
// Hash Set – Group 6: Core Concepts & Problem-Solving Reference
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



// MARK: - Problem 1: Contains Duplicate

/*
 Goal:
 Return true if any element appears twice.
 
 
 Example:
 Input: [1,2,3,1]
 Output: true
 
 */

// MARK: Brute Force
// Time Complexity: O(n²) → Two nested loops checking all pairs
// Space Complexity: O(1) → No extra data structures used

methodLabel("Problem 1: Contains Duplicate", .bruteForce)


func containsDuplicateBF(_ nums: [Int]) -> Bool {
    for i in 0..<nums.count{
        for j in i+1..<nums.count{
            print("current number: \(nums[i]), next number: \(nums[j])")
            if nums[i] == nums[j]{
                print(" → Duplicate found! \(nums[i]) = \(nums[j])")
                return true
            }
        }
    }
    
    return false
}

containsDuplicateBF([1,2,3,1])

// MARK: Hash Set
// Time Complexity: O(n) → Set insert & contains are O(1) average
// Space Complexity: O(n) → Worst case if no duplicates



methodLabel("Problem 1: Contains Duplicate", .hashSet)


func containsDuplicateHS(_ nums: [Int]) -> Bool {
    var seen: Set<Int> = []
    
    for num in nums {
        print("Checking number: \(num)")
        
        if seen.contains(num) {
            print(" → Duplicate found! \(num) is already in the set \(seen)")
            return true
        }
        
        seen.insert(num)
        print("Inserted \(num), current set: \(seen)")
    }
    
    print("No duplicates found")
    return false
}


containsDuplicateHS([1,2,3,1])


// MARK: - Problem 2: Remove Duplicates from Array

/*
 Goal:
 Remove duplicates from the array while preserving the original order of elements.
 
 Example:
 Input:  [1,2,2,3,3,4]
 Output: [1,2,3,4]
 */


// MARK: Brute Force
// Time Complexity: O(n²) → For each number, .contains() scans the current array
// Space Complexity: O(n)  → To store the list of unique elements

methodLabel("Problem 2: Remove Duplicates from Array", .bruteForce)


func removeDuplicatesBF(_ nums: [Int]) -> [Int] {
    var uniqueNums: [Int] = []
    
    for num in nums {
        print("current number: \(num)")
        if !uniqueNums.contains(num) {
            uniqueNums.append(num)
            print("number not yet seen \(num), adding to array: \(uniqueNums)")
        }
    }
    print("Final array: \(uniqueNums)")
    return uniqueNums
}

removeDuplicatesBF( [1,2,2,3,3,4])

// MARK: Hash Set
// Time Complexity: O(n) → Each insert & contains check is O(1) average
// Space Complexity: O(n) → Hash set + result array can store up to n unique values

methodLabel("Problem 2: Remove Duplicates from Array", .hashSet)

func removeDuplicatesHS(_ nums: [Int]) -> [Int] {
    var seen: Set<Int> = []
    var result: [Int] = []
    
    for num in nums {
        print("Checking number: \(num)")
        
        if seen.contains(num) {
            print(" → Duplicate found! \(num) already seen.")
            continue
        }
        
        seen.insert(num)
        result.append(num)
        print("Inserted \(num), result now: \(result)")
    }
    
    print("Final ordered result: \(result)")
    return result
}


removeDuplicatesHS( [1,2,2,3,3,4])



// MARK: - Problem 3: Check If Two Strings Share a Character

/*
 Goal:
 Determine whether two strings share at least one common character
 
 Example:
 Input: "abc", "xya"
 Output: true
 Explanation: Both strings contain the character 'a'.
 */


// MARK: Brute Force
// Time Complexity: O(n * m) → Compare each character in str1 with every character in str2
// Space Complexity: O(1) → Only variables used for iteration

methodLabel("Problem 3: Check If Two Strings Share a Character", .bruteForce)


func characterSharedBF(_ str1: String, _ str2: String) -> Bool {
    for char1 in str1 {
        print("str1 char: \(char1)")
        for char2 in str2 {
            print("str2 char: \(char2)")
            if char1 == char2 {
                print(" → Same character found!")
                return true
            }
        }
    }
    
    return false
}


characterSharedBF("abc", "xya")


// MARK: Hash Set
// Time Complexity: O(n + m) → n = length of str1, m = length of str2; Building the set: O(n) + Checking each character: O(m)
// Space Complexity: O(n) → Store all characters of str1 in the set; worst-case all unique → O(n)

methodLabel("Problem 3: Check If Two Strings Share a Character", .hashSet)

func characterSharedHS(_ str1: String, _ str2: String) -> Bool {
    var str1Set: Set<Character> = []
    
    for char in str1 {
        str1Set.insert(char)
        print("Added '\(char)' to set: \(str1Set)")
    }
    
    for char in str2 {
        print("Checking '\(char)' against set: \(str1Set)")
        if str1Set.contains(char) {
            print(" → Match found: '\(char)'")
            return true
        }
    }
    
    return false
}


characterSharedHS("abc", "xya")


// MARK: - Problem 4: Intersection of Two Arrays

/*
 Goal:
 Given two integer arrays, return an array of their unique common elements.
 Each element in the result should appear only once, regardless of how many times it appears in the input arrays.
 
 Example:
 Input: nums1 = [1,2,2,1], nums2 = [2,2]
 Output: [2]
 Explanation: The number 2 appears in both arrays, and duplicates are ignored in the result.
 */


// MARK: Brute Force
/*
 Time Complexity: O(n * m * k) →
 n = nums1.count, m = nums2.count, k = size of uniqueCommonElement (for .contains() check)
 Worst-case: For every pair of elements, we may scan the result array to avoid duplicates.
 Space Complexity: O(min(n, m)) → Stores at most the number of unique common elements
 */
methodLabel("Problem 4: Intersection of Two Arrays", .bruteForce)

func intersectionOfTwoArraysBF(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var uniqueCommonElement: [Int] = []
    
    for num1 in nums1 {
        print("Checking nums1 element: \(num1)")
        
        // Skip if already added to the result
        if uniqueCommonElement.contains(num1) {
            print(" → \(num1) is already in result, skipping further checks")
            continue
        }
        
        for num2 in nums2 {
            print(" → Comparing with nums2 element: \(num2)")
            
            if num1 == num2 {
                uniqueCommonElement.append(num1)
                print(" → Match found! Added \(num1) to result: \(uniqueCommonElement)")
                break // stop inner loop once a match is found
            }
        }
        print("Current result array: \(uniqueCommonElement)")
    }
    
    print("Final array of unique common elements: \(uniqueCommonElement)")
    return uniqueCommonElement
}

intersectionOfTwoArraysBF([1,2,2,1],[2,2])



// MARK: Hash Set
/* Time Complexity: O(n + m) →
 n = nums1.count (building nums1Set)
 m = nums2.count (checking nums2 elements against the set)
 .contains() and .insert() are O(1) average
 Space Complexity: O(n + k) →
 n = size of nums1Set
 k = size of result array (unique common elements, ≤ min(n, m))
 */
methodLabel("Problem 4: Intersection of Two Arrays", .hashSet)

func intersectionOfTwoArraysHS(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var nums1Set: Set<Int> = []
    var uniqueCommonElement: [Int] = []
    
    for num in nums1 {
        nums1Set.insert(num)
    }
    print("Set of nums1: \(nums1Set)")
    
    for num in nums2 {
        print("Checking nums2 element: \(num)")
        
        // If debug not needed
        //        if nums1Set.contains(num) && !uniqueCommonElement.contains(num) {
        //             uniqueCommonElement.append(num)
        //         }
        //
        
        // Debug needed
        if nums1Set.contains(num) {
            if !uniqueCommonElement.contains(num) {
                uniqueCommonElement.append(num)
                print(" → Match found! Added \(num) to result: \(uniqueCommonElement)")
            } else {
                print(" → \(num) already added to result, skipping")
            }
        } else {
            print(" → \(num) not found in nums1 set")
        }
        
        print("Current result array: \(uniqueCommonElement)")
    }
    
    print("Final array of unique common elements: \(uniqueCommonElement)")
    return uniqueCommonElement
}

intersectionOfTwoArraysHS([1,2,2,1],[2,2])


// MARK: - Problem 5: Valid Parentheses

/*
 Goal:
    Determine if a string containing only parentheses characters is valid.
    A string is valid if every opening bracket has a corresponding closing bracket
    in the correct order. Use a Set to identify opening brackets and a stack
    to match closing brackets.

 Example:
    Input: "()"
    Output: true
    Explanation: Each opening bracket has a corresponding closing bracket in order.
*/


// MARK: Hash Set + Stack
//Time Complexity: O(n) – scan each character once
//Space Complexity: O(n) – stack may store all opening brackets
methodLabel("Problem 5: Valid Parentheses", .hashSet)

func validParenthesesHSDebug(_ str: String) -> Bool {
    var stack: [Character] = []
    let opening: Set<Character> = ["(", "{", "["]
    let matching: [Character: Character] = [")": "(", "}": "{", "]": "["]
    
    print("Input string: \(str)")
    
    for char in str {
        if opening.contains(char) {
            // Push opening brackets onto the stack
            stack.append(char)
            print("Pushed opening bracket '\(char)' → Stack: \(stack)")
        } else if let expectedOpen = matching[char] {
            // Handle closing brackets
            if let last = stack.last {
                if last == expectedOpen {
                    stack.removeLast()
                    print("Matched closing bracket '\(char)' with '\(last)' → Stack after pop: \(stack)")
                } else {
                    print("Mismatch! Expected '\(expectedOpen)', but found '\(last)' → Invalid")
                    return false
                }
            } else {
                // Stack is empty but found a closing bracket
                print("Closing bracket '\(char)' found but stack is empty → Invalid")
                return false
            }
        } else {
            // Ignore other characters if any
            print("Ignoring character: \(char)")
        }
    }
    
    if stack.isEmpty {
        print("All brackets matched → Valid parentheses")
        return true
    } else {
        print("Unmatched opening brackets remain in stack → Invalid: \(stack)")
        return false
    }
}

validParenthesesHSDebug("(){}[]")      // true
validParenthesesHSDebug("([{}])")      // true


func validParenthesesHS(_ str: String) -> Bool {
    var stack: [Character] = []
    let opening: Set<Character> = ["(", "{", "["]
    let matching: [Character: Character] = [")": "(", "}": "{", "]": "["]
    
    for char in str {
        if opening.contains(char) {
            stack.append(char)
        } else if let expectedOpen = matching[char] {
            guard let last = stack.last, last == expectedOpen else {
                return false
            }
            stack.removeLast()
        }
    }
    
    return stack.isEmpty
}

validParenthesesHS("([{}])")      // true




// MARK: - Problem 6: Happy Number

/*
 Goal:
    Determine if a number is a "happy number."
    A happy number is defined as follows:
    - Start with any positive integer.
    - Replace the number by the sum of the squares of its digits.
    - Repeat the process until the number equals 1 (then it’s happy), or it loops endlessly in a cycle (then it’s not happy).
    Use a Set to track previously seen numbers to detect cycles and avoid infinite loops.

 Example:
    Input: 19
    Output: true
    Explanation: 19 → 1² + 9² = 82 → 8² + 2² = 68 → ... → 1, so 19 is a happy number.
*/


// MARK: Hash Set
/* Time Complexity: O(k) →
        k is the number of transformations until we reach 1 or detect a cycle.
        Each transformation computes the sum of squares of digits (O(log n) per number),
        but since numbers eventually fall below 243, → 9^2 + 9^2 + 9^2 = 81 + 81 + 81 = 243 (the maximum sum of squares for 3-digit numbers)
        the loop runs a constant number of times in practice.
    Space Complexity: O(k) →
        We store all previously seen numbers in a HashSet to detect cycles.
*/
 
methodLabel("Problem 6: Happy Number", .hashSet)


func happyNumber(_ n: Int) -> Bool {
    var seen: Set<Int> = []
    var num = n
    
    while num != 1 && !seen.contains(num) {
        seen.insert(num)
        var sum = 0
        var temp = num
        
        while temp > 0 {
            let digit = temp % 10
            sum += digit * digit
            temp /= 10
        }
        print("Current number: \(num), sum of squares: \(sum), seen: \(seen)")
        num = sum
    }
   
    return num == 1
}


happyNumber(19)
