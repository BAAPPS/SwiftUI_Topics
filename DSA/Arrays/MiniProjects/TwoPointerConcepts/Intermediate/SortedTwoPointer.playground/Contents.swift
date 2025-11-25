//  ---------------------------------------------------------------
//  Two Pointers – Group 2: Sorted Arrays
//  ---------------------------------------------------------------
//
//  🎯 Concept Focus:
//  Apply the two-pointer pattern on **sorted arrays** to solve problems
//  involving sums, differences, intersections, closest values, and merging.
//
//  💡 Why Sorting Helps:
//  Once the array is sorted, pointer movement becomes meaningful:
//
//      • If the current sum is too small → move left pointer right
//      • If the current sum is too large → move right pointer left
//
//  This guarantees that every pointer move reduces the search space,
//  eliminating unnecessary comparisons.
//
//  🔑 When To Use This Pattern:
//  - Find pairs that sum to a target
//  - Find pairs with minimum or maximum difference
//  - Find closest value to a target
//  - Merge two sorted arrays
//  - Remove duplicates (sorted input required)
//  - Square & sort negatives/positives
//
//  🙌 Complexity Benefits:
//  • Naive nested loops:   O(n²)
//  • Sorted two pointers:  O(n)  (or O(n log n) if sorting first)
//
//  🧩 Pro Tip:
//  For **unsorted arrays** → two pointers DO NOT work directly.
//  You must either:
//      (1) Sort the array first (changes original indices),
//                             OR
//      (2) Use a HashMap if you care about original indices.
//
//  ---------------------------------------------------------------


import Cocoa


// MARK: Print Statements Helper

enum MethodType: String {
    case bruteForce = "💡 BRUTE FORCE"
    case twoPointer = "⚡️ TWO POINTER"
}

func methodLabel(_ problem: String,  _ method: MethodType)  {
    return print("\(problem) \(method.rawValue)")
}


// MARK: -  Problem 1: Two Sum

/* Goal:
 Find two numbers such that nums[l] + nums[r] == target.
 Example:
 Input: nums = [2,7,11,15], target = 9
 Output: [0,1]
 
 */


// MARK: Brute Force
// Time Complexity: O(n²) →
// Space Complexity: O(n) →

methodLabel("Problem 1: Two Sum", .bruteForce)

func twoSumBF(_ nums: [Int], _ target: Int) -> [(Int, Int)] {
    var result: [(Int, Int)] = []
    
    for i in 0..<nums.count {
        for j in i + 1..<nums.count {
            let currentNum = nums[i]
            let nextNum = nums[j]
            let sum = currentNum + nextNum
            
            print("Checking indices \(i) and \(j): \(currentNum) + \(nextNum) = \(sum)")
            
            if sum == target {
                print("Target found! \(currentNum) + \(nextNum) = \(target)")
                result.append((i, j))
                print(" → Appended pair (\(i), \(j)). Current result: \(result)")
            }
        }
    }
    
    print("🔚 Final result: \(result)")
    return result
}

twoSumBF([2,7,11,15], 9)


// MARK: Two Pointer (Unsorted Array)
// Time Complexity: O(n log n) → Sorting dominates (O(n log n)), then a linear scan (O(n)).
// Space Complexity: O(n) → We store the paired array (value + original index) → O(n).
// Note: returning a single pair doesn’t add extra space beyond the paired array.

methodLabel("Problem 1: Two Sum", .twoPointer)

func twoSumTP(_ nums: [Int], _ target: Int) -> (Int, Int)? {
    // Pair values with original indices
    var paired = nums.enumerated().map { (value: $0.element, index: $0.offset) }
    
    // Sort by value
    paired.sort { $0.value < $1.value }
    
    var left = 0
    var right = paired.count - 1
    
    while left < right {
        let sum = paired[left].value + paired[right].value
        
        print("Comparing: \(paired[left].value) (index \(paired[left].index)) + \(paired[right].value) (index \(paired[right].index)) = \(sum)")
        
        if sum == target {
            print(" → Match found → indices (\(paired[left].index), \(paired[right].index))")
            return (paired[left].index, paired[right].index)
        } else if sum < target {
            left += 1
        } else {
            right -= 1
        }
    }
    
    return nil // no pair found
}


twoSumTP([2,7,11,15], 9)



// MARK: - Problem 2: Two Sum II (Sorted Array)

/* Goal:
        Given a **1-indexed sorted array** `nums` and a target integer `target`,
        find **the indices of the two numbers** such that they add up to the target.
        Return the indices **as an array [index1, index2]**, where index1 < index2.
    Example:
        Input:  nums = [2, 7, 11, 15], target = 9
        Output: [1, 2]   // 1-indexed
*/



// MARK: Brute Force
// Time Complexity: O(n²) → nested loop checks all pairs
// Space Complexity: O(n) → stores valid pairs in result array

methodLabel("Problem 2: Two Sum II (Sorted Array)", .bruteForce)


func twoSum2BF(_ nums: [Int], _ target: Int) -> [(Int, Int)] {
    var result: [(Int, Int)] = []
    
    for i in 0..<nums.count{
        for j in i+1..<nums.count{
            let currentNum = nums[i]
            let nextNum = nums[j]
            let sum = currentNum + nextNum
            
            print("Checking indices \(i) and \(j): \(currentNum) + \(nextNum) = \(sum)")
            
            if sum == target{
                print("Target found! \(currentNum) + \(nextNum) = \(target)")
                result.append((i + 1, j + 1))
                print(" → Appended pair (\(i + 1), \(j + 1)). Current result: \(result)")
            }
        }
    }
    print("🔚 Final result: \(result)")
    return result
}

twoSum2BF([2, 7, 11, 15], 9)

// MARK: Two Pointer
// Time Complexity: O(n) → linear scan of the sorted array
// Space Complexity: O(1) → Used only a left, right variables


methodLabel("Problem 2: Two Sum II (Sorted Array)", .twoPointer)


func twoSum2TP(_ nums: [Int], _ target: Int) -> [Int] {
    var left = 0
    var right = nums.count - 1
    
    while left < right {
        let sum = nums[left] + nums[right]
        print("Comparing: \(nums[left]) + \(nums[right]) = \(sum)")
        
        if sum == target {
            print(" → Match found → indices (\(left + 1), \(right + 1))")
            return [left + 1, right + 1] // O(1) space
        } else if sum < target {
            left += 1
        } else {
            right -= 1
        }
    }
    return [] // no pair found
}


twoSum2TP([2,7,11,15], 9)


// MARK: - Problem 3: Pair Sum Equals Target

/* Goal:
    Given an sorted array of integers `nums` and a target integer `target`,
    find **all pairs of indices** whose corresponding numbers sum to the target.
    
    Return each pair as a tuple of indices (1-indexed).

    Example:
        Input:  nums = [1, 2, 3, 4, 5], target = 6
        Output: [(1, 5), (2, 4)]
*/



// MARK: Brute Force
// Time Complexity: O(n²) → nested loop checks all pairs
// Space Complexity: O(n) → stores valid pairs in result array

methodLabel("Problem 3: Pair Sum Equals Target", .bruteForce)


func pairSumBF(_ nums: [Int], _ target: Int) -> [(Int, Int)] {
    var result: [(Int, Int)] = []
    
    for i in 0..<nums.count{
        for j in i+1..<nums.count{
            var currentNum = nums[i]
            var nextNum = nums[j]
            var sum = currentNum + nextNum
            
            print("current: \(currentNum), next: \(nextNum), sum:\(sum)")
            
            if sum == target {
                print("Target pair found: current num \(currentNum), index \(i + 1),  next num \(nextNum), index \(j + 1) ")
                result.append((i + 1, j + 1))
            }
            
     
        }
    }
    
    print("Final result: \(result)")
    
    return result
}

pairSumBF([1, 2, 3, 4, 5], 6)


// MARK: Two Pointer
// Time Complexity: O(n) → linear scan of the sorted array
// Space Complexity: O(n) → stores valid pairs in result array

methodLabel("Problem 3: Pair Sum Equals Target", .twoPointer)


func pairSumTP(_ nums: [Int], _ target: Int) -> [(Int, Int)] {
    var result: [(Int, Int)] = []
    var left = 0
    var right = nums.count - 1
    
    while left < right {
        let sum = nums[left] + nums[right]
        
        print("Comparing: \(nums[left]) + \(nums[right]) = \(sum)")
        
        if sum == target {
            print(" → Match found → indices (\(left + 1), \(right + 1))")
            result.append((left + 1, right + 1))
            left += 1
            right -= 1
        } else if sum < target {
            left += 1
        } else {
            right -= 1
        }
    }
    
    print("Final result: \(result)")
    return result
}

pairSumTP([1, 2, 3, 4, 5], 6)

// MARK: - Problem 4: Find Pair With Minimum Absolute Difference

/* Goal:
    Given a **sorted array** of integers `nums`, find the pair of numbers
    whose **absolute difference** is the smallest among all adjacent pairs.
    Return the **minimum absolute difference**.

    Example:
        Input:  nums = [3, 8, 15, 17]
        Output: 2   // pair with minimum difference: (15, 17)
*/



// MARK: Brute Force
// Time Complexity: O(n²) → Using nested loops
// Space Complexity: O(n) → Keeping a single minSum variable

methodLabel("Problem 4: Find Pair With Minimum Absolute Difference", .bruteForce)

func minimumAbsoluteDifferencePairBF(_ nums:[Int]) -> Int {
    var minDiff = Int.max
    
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            let diff = abs(nums[i] - nums[j])
            print("Comparing \(nums[i]) and \(nums[j]), diff = \(diff)")
            
            if diff < minDiff {
                print(" → New min difference found: \(diff)")
                minDiff = diff
            }
        }
    }
    
    print("Final minimum difference: \(minDiff)")
    return minDiff
}

minimumAbsoluteDifferencePairBF([3, 8, 15, 17])


// MARK: Two Pointer
// Time Complexity: O(n) → linear scan of the sorted arrays
// Space Complexity: O(n) → stores valid pairs in result array

methodLabel("Problem 4: Find Pair With Minimum Absolute Difference", .twoPointer)


func minimumAbsoluteDifferencePairTP(_ nums:[Int]) -> Int {
    var minDiff = Int.max
    var left = 0
    var right = 1

    while right < nums.count {
        let diff = nums[right] - nums[left]
        minDiff = min(minDiff, diff)
        print("Comparing \(nums[left]) and \(nums[right]), diff = \(diff), minDiff = \(minDiff)")
        left += 1
        right += 1
    }

    print("Final min difference: \(minDiff)")
    return minDiff
}

minimumAbsoluteDifferencePairTP([3, 8, 15, 17])


// MARK: - Problem 5: Find K-th Pair Distance

/* Goal:
    Given a **sorted array** of integers `nums` and an integer `k`,
    find the **k-th smallest distance** among all possible pairs of numbers in the array.
    
    The distance of a pair `(nums[i], nums[j])` is defined as `abs(nums[i] - nums[j])`.

    Example:
        Input:  nums = [1, 3, 4], k = 2
        All pair distances: [2, 3, 1] → sorted → [1, 2, 3]
        Output: 2   // 2nd smallest distance
*/



// MARK: Brute Force
// Time Complexity: O(n² log n) → compute all pairs (O(n²)) + sort (O(n² log n))
// Space Complexity: O(n²) → store all pair distances

methodLabel("Problem 5: Find K-th Pair Distance", .bruteForce)

func kthSmallestDistanceBF(_ nums: [Int], _ k: Int) -> Int {
    var allDistances: [Int] = []

    // Compute all pair distances
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            let dist = abs(nums[i] - nums[j])
            allDistances.append(dist)
            print("Pair (\(nums[i]), \(nums[j])) → distance = \(dist)")
        }
    }

    print("All distances before sorting: \(allDistances)")

    // Sort distances
    allDistances.sort()
    print("All distances after sorting: \(allDistances)")

    // Using 0 index, subtract 1 to get the actual 2nd element at index 1 in the array
    let kthDistance = allDistances[k - 1]
    print("k = \(k), k-th smallest distance = \(kthDistance)")

    return kthDistance
}

kthSmallestDistanceBF([1, 3, 4], 2)



// MARK: Two Pointer + Binary Search
// Time Complexity: O(n log D) → n for counting pairs × log D for binary search,
// where D = maxDist = nums.last! - nums.first!
// Space Complexity: O(1) → Only pointers and counters, no extra distance array needed

methodLabel("Problem 5: Find K-th Pair Distance", .bruteForce)

func kthSmallestDistanceOptimized(_ nums: [Int], _ k: Int) -> Int {
    var low = 0
    var high = nums.last! - nums.first!

    // Counts the number of pairs in the sorted array `nums` whose distance is less than or equal to `maxDist`.
    // We count pairs to determine how many distances are ≤ maxDist, which helps guide the binary search for the k-th smallest distance.
    func countPairs(maxDist: Int) -> Int {
        var count = 0
        var left = 0

        for right in 0..<nums.count {
            while nums[right] - nums[left] > maxDist {
                left += 1
            }
            count += right - left
        }

        return count
    }

    while low < high {
        let mid = (low + high) / 2
        let count = countPairs(maxDist: mid)
        print("Trying mid = \(mid), pairs ≤ mid = \(count)")

        if count < k {
            low = mid + 1
        } else {
            high = mid
        }
    }

    print("k-th smallest distance = \(low)")
    return low
}

kthSmallestDistanceOptimized([1, 3, 4], 2)


// MARK: - Problem 6:  Intersection of Two Sorted Arrays

/* Goal:
    Given two **sorted arrays** `nums1` and `nums2`, find their intersection,
    where each element in the result should appear as many times as it shows
    in both arrays.
    
    Example:
        Input:  nums1 = [1, 2, 2, 3], nums2 = [2, 2]
        Output: [2, 2]   // 2 appears twice in both arrays
*/


// MARK: Brute Force
// Time Complexity: O(n * m) → For each element in nums1, we scan nums2
// Space Complexity: O(min(n, m)) → store intersection elements

methodLabel("Problem 6: Intersection of Two Sorted Arrays", .bruteForce)

func twoSortedArraysIntersectionBF(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var result: [Int] = []
    var nums2Copy = nums2   // Make a mutable copy to mark used elements
    
    for i in 0..<nums1.count {
        for j in 0..<nums2Copy.count {
            print("Comparing nums1[\(i)] = \(nums1[i]) with nums2[\(j)] = \(nums2Copy[j])")
            if nums1[i] == nums2Copy[j] {
                print(" → Match found! Appending \(nums1[i]) to result")
                result.append(nums1[i])
                nums2Copy[j] = Int.min  // Mark as used
                break
            }
        }
    }
    
    print("Final intersection: \(result)")
    return result
}

twoSortedArraysIntersectionBF([1,2,2,3], [2,2])

// MARK: Two Pointer
// Time Complexity: O(n + m) → single pass through both arrays
// Space Complexity: O(min(n, m)) → store intersection elements

methodLabel("Problem 6: Intersection of Two Sorted Arrays", .twoPointer)

func twoSortedArraysIntersectionTP(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var result: [Int] = []
    var i = 0
    var j = 0
    
    while i < nums1.count && j < nums2.count {
        print("Comparing nums1[\(i)] = \(nums1[i]) with nums2[\(j)] = \(nums2[j])")
        
        if nums1[i] == nums2[j] {
            print(" → Match found! Appending \(nums1[i]) to result")
            result.append(nums1[i])
            i += 1
            j += 1
        } else if nums1[i] < nums2[j] {
            print(" → nums1[\(i)] < nums2[\(j)], increment i")
            i += 1
        } else {
            print(" → nums1[\(i)] > nums2[\(j)], increment j")
            j += 1
        }
    }
    
    print("Final intersection: \(result)")
    return result
}


twoSortedArraysIntersectionTP([1,2,2,3], [2,2])

// MARK: - Problem 7:  Two Numbers With Sum Closest to Target

/* Goal:
    Given an array of integers `nums` and an integer `target`,
    find the pair of numbers in the array whose sum is **closest to the target**.
    
    Return the **sum of that pair**.
    
    Example:
        Input:  nums = [-1, 2, 1, -4], target = 1
        Output: 1   // Pair with sum closest to target: (-1 + 2)
*/


// MARK: Brute Force
// Time Complexity: O(n²) → Nested loops over the array to check all pairs
// Space Complexity: O(1) → Only a single variable `closestSum` is used

methodLabel("Problem 7: Two Numbers With Sum Closest to Target", .bruteForce)

func sumClosestToTargetBF(_ nums: [Int], _ target: Int) -> Int {
    var closestSum = nums[0] + nums[1] // initialize with first pair
    print("Initial closestSum = \(closestSum) (pair: \(nums[0]), \(nums[1]))")
    
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            let currentSum = nums[i] + nums[j]
            print("Checking pair: (\(nums[i]), \(nums[j])) → currentSum = \(currentSum)")
            
            if abs(currentSum - target) < abs(closestSum - target) {
                print(" → New closest sum found! Previous closestSum = \(closestSum), new closestSum = \(currentSum)")
                closestSum = currentSum
            }
        }
    }
    
    print("Final closest sum to target \(target) = \(closestSum)")
    return closestSum
}

sumClosestToTargetBF([-1, 2, 1, -4], 1)

// MARK: Two Pointer
// Time Complexity: O(n log n) → Sorting dominates
// Space Complexity: O(n) → Sorted array copy

methodLabel("Problem 7: Two Numbers With Sum Closest to Target", .twoPointer)

func sumClosestToTargetTP(_ nums: [Int], _ target: Int) -> Int {
    let sorted = nums.sorted()
    var closestSum = sorted[0] + sorted[1]
    var left = 0
    var right = sorted.count - 1
    
    while left < right {
        let currentSum = sorted[left] + sorted[right]
        print("Checking pair (\(sorted[left]), \(sorted[right])) → sum = \(currentSum)")
        
        if abs(currentSum - target) < abs(closestSum - target) {
            print(" → New closest sum found! Previous = \(closestSum), New = \(currentSum)")
            closestSum = currentSum
        }
        
        if currentSum < target {
            left += 1
        } else {
            right -= 1
        }
    }
    
    print("Closest sum to target \(target) is \(closestSum)")
    return closestSum
}

sumClosestToTargetTP([-1, 2, 1, -4], 1)
