//  ---------------------------------------------------------------
//  Two Pointers – Group 3: Sorting Before Two Pointer
//  ---------------------------------------------------------------
//
//  🎯 Purpose of Sorting:
//  Sorting transforms the array into a structure where pointer movement
//  becomes predictable and meaningful. Without sorting, pointer decisions
//  (move left? move right?) would have **no guarantee** of improving the result.
//
//  📈 How Sorting Enables Two Pointers:
//      • Increasing the left pointer → increases the value
//      • Decreasing the right pointer → decreases the value
//
//  This ordered structure lets us intelligently shrink the search space
//  instead of checking every pair.
//
//  🔥 What Sorting Unlocks:
//  - Skip impossible pairs
//  - Move pointers in one direction only (no backtracking)
//  - Reduce O(n²) brute force → O(n) linear scan
//  - Guarantee that each pointer adjustment brings us closer to the goal
//
//  ⚠️ Important Reminder:
//  Two pointers **do not work** on unsorted arrays because the values do not
//  move in predictable directions.
//  → Always sort first *unless the input is already sorted*.
//
//  ---------------------------------------------------------------


import Cocoa


// MARK: Print Statements Helper

enum MethodType: String {
    case bruteForce = "💡 BRUTE FORCE"
    case twoPointer = "⚡️ TWO POINTER"
    case linear = "LINEAR SCAN"
}

func methodLabel(_ problem: String,  _ method: MethodType)  {
    return print("\(problem) \(method.rawValue)")
}


// MARK: -   Problem 1: Two Sum Closest

/* Goal:
 Given an unsorted array, find two numbers whose sum is closest to the target.
 Example:
 Input: nums = [4,1,2,7], target = 6
 Output: [4,2]  // sum = 6
 
 
 */


// MARK: Brute Force
// Time Complexity: O(n²) → check all pairs
// Space Complexity: O(1) → constant space, storing only a few variables

methodLabel("Problem 1: Two Sum Closest", .bruteForce)


func twoSumClosestBF(_ nums: [Int], _ target: Int) -> (Int, Int)? {
    var bestPair: (Int, Int)? = nil
    var smallestDiff = Int.max
    
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            let currentNum = nums[i]
            let nextNum = nums[j]
            let currentSum = currentNum +  nextNum
            let difference = abs(currentSum - target)
            
            print("Checking pair (\(currentNum), \(nextNum)) → sum=\(currentSum), diff=\(difference)")
            
            if difference < smallestDiff {
                smallestDiff = difference
                bestPair = (currentNum, nextNum)
                print(" New closest pair found → \(bestPair!), diff=\(smallestDiff)")
            }
            
        }
    }
    
    
    print("\nFinal Best Pair: \(String(describing: bestPair)) with diff = \(smallestDiff)")
    return bestPair
}

// MARK: Two Pointer
// Time Complexity: O(n log n) → sorting dominates; pointer scan is O(n)
// Space Complexity: O(1) → constant extra space (if sorting in-place), OR O(n) if using nums.sorted() which creates a new array


twoSumClosestBF([4,1,2,7], 6)


methodLabel("Problem 1: Two Sum Closest", .twoPointer)


func twoSumClosestTP(_ nums: [Int], _ target: Int) -> (Int, Int)? {
    //    let sorted = nums.sorted() // O(n) space
    var nums = nums
    nums.sort() // O(1) space
    
    var left = 0
    var right = nums.count - 1
    
    var bestPair: (Int, Int)? = nil
    var smallestDiff = Int.max
    
    while left < right {
        let sum = nums[left] + nums[right]
        let difference = abs(sum - target)
        
        
        print("Checking: \(nums[left]) + \(nums[right]) = \(sum), diff = \(difference)")
        
        
        if difference < smallestDiff {
            smallestDiff = difference
            bestPair = (nums[left], nums[right])
            print(" → New best pair found: \(bestPair!), smallestDiff = \(smallestDiff)")
        }
        
        if sum < target {
            left += 1
        } else {
            right -= 1
        }
    }
    
    return bestPair
    
}


twoSumClosestTP([4,1,2,7], 6)

// MARK: -  Problem 2: Smallest Difference Pair Between Two Arrays

/* Goal:
 Given two unsorted arrays, find the pair (a,b) with the smallest |a-b|.
 Example:
 Input: A=[1,3,15,11,2], B=[23,127,235,19,8]
 Output: [11,8]  // difference = 3
 
 
 */


// MARK: Brute Force
// Time Complexity: O(n * m) → We compare every element of array A with every element of array B
// Space Complexity: O(1) → Only a few variables are used (bestPair and smallestAbs), no additional arrays


methodLabel(" Problem 2: Smallest Difference Pair Between Two Arrays", .bruteForce)

func smallestDifferencePairBF(_ A: [Int], _ B: [Int]) -> (Int, Int)? {
    guard !A.isEmpty, !B.isEmpty else { return nil }
    
    var bestPair: (Int, Int)? = nil
    var smallestAbs = Int.max
    
    for i in 0..<A.count {
        for j in 0..<B.count {
            let currentDiff = abs(A[i] - B[j])
            
            print("Comparing A[\(i)] = \(A[i]) with B[\(j)] = \(B[j]), |difference| = \(currentDiff)")
            
            if currentDiff < smallestAbs {
                smallestAbs = currentDiff
                bestPair = (A[i], B[j])
                print(" → New best pair found: \(bestPair!) with smallestDiff = \(smallestAbs)")
            }
        }
    }
    
    print("\nFinal Best Pair: \(String(describing: bestPair)) with smallest difference = \(smallestAbs)")
    return bestPair
}

smallestDifferencePairBF([1,3,15,11,2],[23,127,235,19,8])


// MARK: Two Pointer
// Time Complexity: O(n log n + m log m) → Sorting both arrays dominates (n = size of A, m = size of B), then linear two-pointer scan O(n + m)
// Space Complexity: O(1) → In-place sorting of copies, only a few extra variables for pointers and tracking best pair

methodLabel(" Problem 2: Smallest Difference Pair Between Two Arrays", .twoPointer)


func smallestDifferencePairTP(_ A: [Int], _ B: [Int]) -> (Int, Int)? {
    guard !A.isEmpty, !B.isEmpty else { return nil }
    
    var bestPair: (Int, Int)? = nil
    var smallestAbs = Int.max
    
    var A = A, B = B
    A.sort()
    B.sort()
    
    var aPointer = 0
    var bPointer = 0
    
    while aPointer < A.count && bPointer < B.count {
        let absDiff = abs(A[aPointer] - B[bPointer])
        
        // Update best pair if current difference is smaller
        if absDiff < smallestAbs {
            smallestAbs = absDiff
            bestPair = (A[aPointer], B[bPointer])
        }
        
        // Move the pointer pointing to the smaller value
        // because increasing the smaller number might reduce the difference
        if A[aPointer] < B[bPointer] {
            print("A[\(aPointer)] = \(A[aPointer]) < B[\(bPointer)] = \(B[bPointer]) → move aPointer right")
            aPointer += 1
        } else {
            print("A[\(aPointer)] = \(A[aPointer]) >= B[\(bPointer)] = \(B[bPointer]) → move bPointer right")
            bPointer += 1
        }
        
        print("Current best pair: \(String(describing: bestPair)), smallestAbs: \(smallestAbs)\n")
    }
    
    print("Final Best Pair: \(String(describing: bestPair)) with abs = \(smallestAbs)")
    return bestPair
}

smallestDifferencePairTP([1,3,15,11,2],[23,127,235,19,8])


// MARK: - Problem 3: Count Pairs With Sum ≤ Target

/* Goal:
 Count the number of pairs in an unsorted array whose sum ≤ target.
 Example:
 Input: nums = [3,1,2,5], target = 5
 Output: 3  // pairs: (3,1), (3,2), (1,2)
 */



// MARK: Brute Force
// Time Complexity: O(n²) → Nested loops over all pairs
// Space Complexity: O(1) → Only storing the count


methodLabel("Problem 3: Count Pairs With Sum ≤ Target", .bruteForce)


func countSumLessThanEqualTargetBF(_ nums: [Int], _ target: Int) -> Int {
    var count: Int = 0
    
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            let currentNum = nums[i]
            let nextNum = nums[j]
            let currentSum = currentNum +  nextNum
            
            print("Checking pair (\(currentNum), \(nextNum)) → sum = \(currentSum)")
            
            if currentSum <= target {
                count += 1
                print(" New pair found → \(currentNum), \(nextNum), incrementing count: \(count)")
            }
        }
    }
    
    print("Final pair count: \(count)")
    return count
}


countSumLessThanEqualTargetBF([3,1,2,5], 5)


// MARK: Two Pointer
// Time Complexity: O(n log n) → Sorting dominates + linear two-pointer scan
// Space Complexity: O(1) → In-place sort + constant extra variables

methodLabel("Problem 3: Count Pairs With Sum ≤ Target", .twoPointer)


func countSumLessThanEqualTargetTP(_ nums: [Int], _ target: Int) -> Int {
    var nums = nums.sorted()
    var left = 0
    var right = nums.count - 1
    var count = 0
    
    while left < right {
        let sum = nums[left] + nums[right]
        
        if sum <= target {
            // All pairs between left and right are valid
            count += right - left
            print("nums[\(left)] = \(nums[left]) + nums[\(right)] = \(nums[right]) of sum: \(sum) <= target (\(target))")
            print(" → Counting pairs: \( (left+1)...right ) → Incrementing count by \(right - left), total count = \(count)\n")
            left += 1
        } else {
            print("nums[\(left)] = \(nums[left]) + nums[\(right)] = \(nums[right]) of sum: \(sum) > target (\(target)) → move right pointer left")
            right -= 1
        }
    }
    
    print("Final pair count: \(count)")
    return count
}

countSumLessThanEqualTargetTP([3,1,2,5], 5)



// MARK: -  Problem 4: Maximize Difference Between Two Elements

/* Goal:
 From an unsorted array, pick two elements to maximize difference while satisfying a condition (e.g., a < b)
 Example:
 Input: nums = [7,1,3,9], condition: a < b
 Output: 8  // 1 & 9
 */



// MARK: Brute Force
// Time Complexity: O(n²) → Nested loops over all pairs
// Space Complexity: O(1) → Only storing a few variables


methodLabel("Problem 4: Maximize Difference Between Two Elements", .bruteForce)


func maxDifferenceOfTwoElementsBF(_ nums: [Int]) -> Int {
    var maxDiff = Int.min
    
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            var diff = nums[j] - nums[i] // satisfies a < b
            
            if diff > maxDiff {
                maxDiff = diff
            }
            
        }
    }
    
    return maxDiff
}


// MARK: Two Pointer (Single Pass Approach)
// Time Complexity: O(n) → Single pass
// Space Complexity: O(1) → only minVal and maxDiff


methodLabel("Problem 4: Maximize Difference Between Two Elements", .twoPointer)

func maxDifferenceOfTwoElementsTPSingle(_ nums: [Int]) -> Int {
    guard nums.count > 1 else {return 0}
    var minVal = nums[0]
    var maxDiff = Int.min
    
    for i in 1..<nums.count {
        let diff = nums[i] - minVal
        if diff > maxDiff {
            maxDiff = diff
            print("New maxDiff = \(maxDiff) using minVal = \(minVal) and nums[\(i)] = \(nums[i])")
        }
        
        // Always tracks the smallest number seen so far
        // Pointer either stays if current nums[i] isn’t smaller, or updates if it is.
        minVal = min(minVal, nums[i])
    }
    
    print(maxDiff)
    return maxDiff
}


maxDifferenceOfTwoElementsTPSingle([7,1,3,9])

// MARK: - Problem 5: Minimum Absolute Difference in Array

/* Goal:
 Find the pair of numbers with the smallest absolute difference.
 Example:
 Input: nums = [4,2,1,3]
 Output: 1  // pair (2,3) or (1,2)
 */



// MARK: Brute Force
// Time Complexity: O(n²) → Nested loops over all pairs
// Space Complexity: O(1) → Only storing a few variables


methodLabel("Problem 5: Minimum Absolute Difference in Array", .bruteForce)

func minAbsDifferenceArrayBF(_ nums: [Int]) -> Int {
    guard nums.count > 1 else { return 0 }
    
    var minDifference = Int.max
    
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            var absDiff = abs(nums[i] - nums[j])
            
            if absDiff < minDifference {
                minDifference = absDiff
            }
        }
    }
    
    return minDifference
}


// MARK: Two Pointer Approach
// Time Complexity: O(n log n) → sorting dominates
// Space Complexity: O(1) → in-place scan

methodLabel("Problem 5: Minimum Absolute Difference in Array", .twoPointer)

func minAbsDifferenceTP(_ nums: [Int]) -> Int {
    guard nums.count > 1 else { return 0 }
    
    var nums = nums
    nums.sort()
    var left = 0
    var right = 1
    var minDiff = Int.max
    
    print("Sorted array: \(nums)\n")
    
    while right < nums.count {
        let diff = nums[right] - nums[left]  // always non-negative
        print("Checking pair (\(nums[left]), \(nums[right])) → diff = \(diff)")
        
        if diff < minDiff {
            minDiff = diff
            print(" → New min difference found: \(minDiff)")
        }
        
        // Slide the window forward
        left += 1
        right += 1
    }
    
    print("\nFinal minimum absolute difference: \(minDiff)")
    return minDiff
}

minAbsDifferenceTP([5, 2, 3, 8, 1])



// MARK: Linear Scan
// Time Complexity: O(n log n) → sorting dominates
// Space Complexity: O(1) → in-place sort

methodLabel("Problem 5: Minimum Absolute Difference in Array", .linear)


func minAbsDifferenceArrayLinear(_ nums: [Int]) -> Int {
    guard nums.count > 1 else { return 0 }
    
    var nums = nums
    nums.sort()  // O(n log n)
    
    var minDiff = Int.max
    
    for i in 1..<nums.count {
        let a = nums[i - 1]
        let b = nums[i]
        let diff = b - a
        print("Checking pair (\(a), \(b)) → diff = \(diff)")
        
        if diff < minDiff {
            minDiff = diff
            print(" → New min difference found: \(minDiff)")
        }
    }
    
    print("Final minimum absolute difference: \(minDiff)")
    return minDiff
}

minAbsDifferenceArrayLinear([5, 2, 3, 8, 1])


// MARK: - Problem 6: Find Pair With Sum Closest to Zero

/* Goal:
 From an unsorted array, find the pair whose sum is closest to zero.
 Example:
 Input: nums = [-8, -3, 1, 5, 7]
 Output: [-8,7]  // sum = 1
 */


// MARK: Brute Force
// Time Complexity: O(n²) → Nested loops over all pairs
// Space Complexity: O(1) → Only storing a few variables


methodLabel("Problem 6: Find Pair With Sum Closest to Zero", .bruteForce)

func closestZeroSumBF(_ nums:[Int]) -> (Int, Int)? {
    var bestPair: (Int, Int)? = nil
    var minDiff = Int.max
    
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            let current = nums[i]
            let next = nums[j]
            let sum = current + next
            let absSum = abs(sum)
            
            print("Checking pair (\(current), \(next)) → sum = \(sum), absSum = \(absSum)")
            
            if absSum < minDiff {
                minDiff = absSum
                bestPair = (current, next)
                print(" → New closest pair found! (\(current), \(next)), minDiff updated to \(minDiff)")
            }
        }
    }
    
    print("Final closest pair: \(String(describing: bestPair)) with abs sum = \(minDiff)")
    return bestPair
}

closestZeroSumBF([-8, -3, 1, 5, 7])



// MARK: Two Pointer Approach
// Time Complexity: O(n log n) → sorting dominates
// Space Complexity: O(1) → only a few variables

methodLabel("Problem 6: Find Pair With Sum Closest to Zero", .twoPointer)

func closestZeroSumTP(_ nums: [Int]) -> (Int, Int)? {
    guard nums.count > 1 else { return nil }
    
    // Step 1: Sort the array
    var nums = nums
    nums.sort()
    print("Sorted array: \(nums)")
    
    var left = 0
    var right = nums.count - 1
    var bestPair: (Int, Int)? = nil
    var minDiff = Int.max
    
    while left < right {
        let sum = nums[left] + nums[right]
        let absSum = abs(sum)
        
        print("Checking pair (\(nums[left]), \(nums[right])) → sum = \(sum), absSum = \(absSum)")
        
        if absSum < minDiff {
            minDiff = absSum
            bestPair = (nums[left], nums[right])
            print(" → New closest pair found: \(bestPair!), minDiff updated to \(minDiff)")
        }
        
        // Move pointers to try to get closer to zero
        if sum < 0 { // Sum is too small (negative), so we need a bigger number. Moving the left pointer right increases the sum.
            left += 1
            print("Sum < 0 → move left pointer to index \(left)")
        } else if sum > 0 { // Sum is too large (positive), so we need a smaller number. Moving the right pointer left decreases the sum.
            right -= 1
            print("Sum > 0 → move right pointer to index \(right)")
        } else { // Closest possible to zero. We can stop immediately
            print("Exact zero found! Pair = (\(nums[left]), \(nums[right]))")
            break
        }
    }
    
    print("Final closest pair: \(String(describing: bestPair)) with abs sum = \(minDiff)")
    return bestPair
}

closestZeroSumTP([-8, -3, 1, 5, 7])
