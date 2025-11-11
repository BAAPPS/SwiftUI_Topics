//  Sliding Window – Group 5: Advanced – Deque (Optimized Window Operations)
//  ---------------------------------------------------------------
//
//  🎯 Concept Focus:
//  Use a **Deque (Double-Ended Queue)** to efficiently maintain order-based properties
//  while sliding through an array. Ideal for problems where you need
//  **real-time updates of the window’s min/max/first negative/etc.** in O(n) time.
//
//  💡 Key Idea:
//  Maintain a *monotonic deque* — either **increasing** (for min) or **decreasing** (for max) —
//  by adding/removing elements from both ends as the window slides.
//
//  🧩 Pro Tip:
//  1. Remove indices that fall out of the window (index <= end - k).
//  2. Discard elements smaller (for max) or larger (for min) than the new element to preserve monotonicity.
//  3. This reduces brute force O(n*k) scans to O(n).
//
//  ⚡ Suitable Problems:
//  - Maximum in every subarray of size k
//  - Minimum in every subarray of size k
//  - First negative number in every window
//  - Sum of min + max in every window
//  - Sliding window median (with slight modifications using heaps + deque)
//  - Other order-based window queries where you need **front element as answer**
//
//  🔑 Why It Works:
//  - **maxDeq**: stores indices in decreasing order → front is max
//  - **minDeq**: stores indices in increasing order → front is min
//  - Every element enters and exits the deque at most once → **O(n)** time
//  - Deque size ≤ k → **O(k)** space
//
//  🧩 Deque Sliding Window Logic:
//
//  1. Keep deque in decreasing order (values of nums at indices) for max, or increasing for min.
//  2. Remove elements from back if current element is larger (max) or smaller (min).
//  3. Append current index to the back.
//  4. Remove front index if it’s out of the current window (index <= end - k).
//  5. When window is full (end >= k - 1), use deque.front as max/min for the window.


import Cocoa

// MARK: Print Statements Helper

enum MethodType: String {
    case bruteForce = "💡 BRUTE FORCE"
    case slidingWindow = "⚡️ SLIDING WINDOW"
}

func methodLabel(_ problem: String,  _ method: MethodType)  {
    return print("\(problem) \(method.rawValue)")
}


// MARK: -  Problem 1: Maximum in Every Sliding Window

/* Goal:
 Given an array of integers nums and an integer k,
 return a list of the maximum value in every contiguous subarray of size k.
 Use a decreasing deque to maintain potential maximums.
 Example:
 Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
 Output: [3,3,5,5,6,7]
 */

// MARK: Brute Force (Single-Loop Form)
/*
 Time Complexity: O(n * k)
 - For each of the n-k+1 windows, you scan up to k elements to find the maximum.
 Space Complexity: O(1)
 - Only extra space used is for variables and the output array (excluding output).
 */

methodLabel("Problem 1: Maximum in Every Sliding Window", .bruteForce)

func maxSlidingWindowBF(_ nums: [Int], _ k: Int) -> [Int] {
    guard !nums.isEmpty, k > 0 else { return [] }
    var maxValues: [Int] = []
    for i in 0...(nums.count - k){
        let window = nums[i..<(i+k)]
        let maxInWindow = window.max() ?? 0
        maxValues.append(maxInWindow)
        print("Window: \(window) -> max = \(maxInWindow)")
    }
    return maxValues
}


maxSlidingWindowBF([1,3,-1,-3,5,3,6,7], 3)

// MARK: - Sliding Window

// MARK:  Sliding Window Naive


/*
 Time Complexity: O(n * k)
 - There are (n - k + 1) windows.
 - For each window, we scan k elements to find the max.
 Space Complexity: O(1) auxiliary (excluding output)
 - Only a constant amount of extra space is used.
 - The result array uses O(n - k + 1) space, which is required to store output.
 */

methodLabel("Problem 1: Maximum in Every Sliding Window", .slidingWindow)


func maxSlidingWindowSW(_ nums: [Int], _ k: Int) -> [Int] {
    guard !nums.isEmpty, k > 0 else { return [] }
    
    var maxValues: [Int] = []
    
    for end in 0..<nums.count {
        // Making sure window actually has k elements before using it
        if end >= k - 1 {
            let window = nums[(end - k + 1)...end]
            maxValues.append(window.max()!)
        }
    }
    return maxValues
}


maxSlidingWindowSW([1,3,-1,-3,5,3,6,7], 3)

// MARK: -  Sliding Window Deque
/*
 Time: O(n) — you never scan the whole window to recompute max.
 Space: O(k) — only storing indices.
 */

methodLabel("Problem 1: Maximum in Every Sliding Window Deque", .slidingWindow)

func maxSlidingWindowSWDeq(_ nums: [Int], _ k: Int) -> [Int] {
    guard !nums.isEmpty, k > 0 else { return [] }
    
    var maxValues: [Int] = []
    var deque: [Int] = [] // stores indices of elements
    
    for end in 0..<nums.count {
        
        // Remove indices from the back if the current element is greater
        while let last = deque.last, nums[last] < nums[end] {
            deque.removeLast()
        }
        
        // Add current index to the deque
        deque.append(end)
        
        // Remove indices from the front if they are out of the window
        if let first = deque.first, first <= end - k {
            deque.removeFirst()
        }
        
        // Append max value for the window
        if end >= k - 1 {
            maxValues.append(nums[deque.first!])
        }
        
        print("Window end indice: \(end), deque: \(deque.map { nums[$0] }), maxValues: \(maxValues)")
    }
    
    return maxValues
}


maxSlidingWindowSWDeq([1,3,-1,-3,5,3,6,7], 3)

// MARK: -  Problem 2: First Negative Number in Every Window

/* Goal:
 Given an array of integers and a window size k, find the first negative number
 in every contiguous subarray of size k. If none exists, return 0 for that window.
 Use a decreasing deque to maintain potential maximums.
 Example:
 Input: nums = [12, -1, -7, 8, -15, 30, 16, 28], k = 3
 Output: [-1, -1, -7, -15, -15, 0]
 */

// MARK: Brute Force (Single-Loop Form)
/*
 Time Complexity: O(n * k)
 - The loop runs (n - k + 1) times.
 - For each window, `.first(where:)` may scan up to k elements.
 - Therefore total = O(n * k).
 
 Space Complexity: O(1)
 - Aside from the output array, no extra data structures are used.
 - The window slice uses references (not copies), so auxiliary space stays constant.
 */


methodLabel("Problem 2: First Negative Number in Every Window", .bruteForce)

func firstNegativeNumberWindowBF(_ nums: [Int], _ k: Int) -> [Int] {
    guard !nums.isEmpty, k > 0 else { return [] }
    var firstNegatives: [Int] = []
    
    for i in 0...(nums.count - k) {
        
        let window = nums[i..<(i + k)]
        
        if  let firstNegative = window.first(where: { $0 < 0 }) {
            firstNegatives.append(firstNegative)
        } else {
            firstNegatives.append(0)
        }
        
        print("Window: \(window) -> First negative appended: \(firstNegatives)")
    }
    
    
    return firstNegatives
}

firstNegativeNumberWindowBF([12, -1, -7, 8, -15, 30, 16, 28], 3)

// MARK: - Sliding Window

// MARK:  Sliding Window Naive

/*
 Time Complexity: O(n * k)
 - The loop runs (n - k + 1) times.
 - For each window, `.first(where:)` may scan up to k elements.
 - Therefore total = O(n * k).
 
 Space Complexity: O(1)
 - Aside from the output array, no extra data structures are used.
 - The window slice uses references (not copies), so auxiliary space stays constant.
 */

methodLabel("Problem 2: First Negative Number in Every Window", .slidingWindow)

func firstNegativeNumberWindowSW(_ nums: [Int], _ k: Int) -> [Int] {
    guard !nums.isEmpty, k > 0 else { return [] }
    
    var firstNegatives: [Int] = []
    
    // Skip the “warming up” phase and jump straight into fully formed windows
    // If you start from 0..<nums.count, same as if end >= k - 1 checker
    /*
     Example:
     [12] // Skip
     [12, -1] // Skip
     [12, -1, -7] // First full window
     */
    for end in (k-1)..<nums.count {
        let window = nums[(end - k + 1)...end]
        let firstNegative = window.first(where: { $0 < 0 }) ?? 0
        
        firstNegatives.append(firstNegative)
        
        print("window: \(window), -> first negative appended: \(firstNegatives)")
        
    }
    
    return firstNegatives
    
}

firstNegativeNumberWindowSW([12, -1, -7, 8, -15, 30, 16, 28], 3)



// MARK: -  Sliding Window Deque
/*
 Time complexity: O(n) — each index is added/removed at most once.
 Space complexity: O(k) — deque can hold at most k indices.
 */

methodLabel("Problem 2: First Negative Number in Every Window Deque", .slidingWindow)

func firstNegativeNumberWindowSWDeq(_ nums: [Int], _ k: Int) -> [Int] {
    guard !nums.isEmpty, k > 0 else { return [] }
    
    var firstNegatives: [Int] = []
    var deque: [Int] = [] // store indices of negative numbers
    
    for end in 0..<nums.count {
        // Add current element if it is negative
        if nums[end] < 0 {
            deque.append(end)
        }
        
        // Remove indices that are out of current window
        while let first = deque.first, first < end - k + 1 {
            deque.removeFirst()
        }
        
        // Append first negative for the window
        if end >= k - 1 {
            if let first = deque.first {
                firstNegatives.append(nums[first])
            } else {
                firstNegatives.append(0)
            }
        }
        
        print("Window end: \(end), deque: \(deque.map { nums[$0] }), first negative appended: \(firstNegatives)")
    }
    
    return firstNegatives
}


firstNegativeNumberWindowSWDeq([12, -1, -7, 8, -15, 30, 16, 28], 3)


// MARK: -  Problem 3: Sum of Minimum and Maximum of All Subarrays of Size K

/* Goal:
 Given an array of integers `nums` and a window size `k`:
 - For each contiguous subarray (window) of size `k`, find the **minimum** and **maximum** elements.
 - Add the min and max together for that window.
 - Return the **total sum** across all windows.
 
 Use **two deques**:
 - Increasing deque → tracks minimums
 - Decreasing deque → tracks maximums
 
 Example:
 Input: nums = [2, 5, -1, 7, -3, -1, -2], k = 4
 Number of windows: n - k + 1 = 7 - 4 + 1 = 4
 Windows:
 [2, 5, -1, 7] -> min=-1, max=7 -> sum=6
 [5, -1, 7, -3] -> min=-3, max=7 -> sum=4
 [-1, 7, -3, -1] -> min=-3, max=1? -> sum=4
 [7, -3, -1, -2] -> min=-3, max=1? -> sum=4
 Total sum = 6 + 4 + 4 + 4 = 18
 */

// MARK: - Sliding Window

// MARK:  Sliding Window Naive

/*
 Time Complexity: O(n * k)
 - For each of the (n - k + 1) windows, min() and max() scan up to k elements.
 
 Space Complexity: O(1) auxiliary
 - Only a few variables (min, max, totalSum) are used
 - The window slice is a view, so no extra space per window
 - Output is a single integer
 */

methodLabel(" Problem 3: Sum of Minimum and Maximum of All Subarrays of Size K", .slidingWindow)

func minMaxSumOfSizeKSW(_ nums: [Int], _ k: Int) -> Int {
    var min = Int.max
    var max  = Int.min
    var totalSum = 0
    
    for end in (k - 1)..<nums.count {
        let window = nums[(end - k + 1)...end]
        min = window.min() ?? 0
        max = window.max() ?? 0
        totalSum += min + max
        
        print("window: \(window), min: \(min), max: \(max), sum: \(totalSum)")
        
    }
    
    return totalSum
}


minMaxSumOfSizeKSW([2, 5, -1, 7, -3, -1, -2], 4)


// MARK:  Sliding Window Deque

/*
 Time Complexity: O(n)
 - Each element’s index is added to and removed from each deque at most once.
 - No scanning of the whole window is needed (min() / max() calls are avoided).
 - Total operations ≈ 2 per element per deque → O(n).
 
 Space Complexity: O(k)
 - Each deque stores indices of elements in the current window only.
 -  A window can have at most k elements → deque size ≤ k → O(k).
 - Output is a single integer → negligible extra space.
 */


methodLabel(" Problem 3: Sum of Minimum and Maximum of All Subarrays of Size K SW Deque", .slidingWindow)


func minMaxSumOfSizeKSWDeq(_ nums: [Int], _ k: Int) -> Int {
    guard !nums.isEmpty, k > 0 else { return 0 }
    
    var minDeq: [Int] = [] // indices of potential minimums
    var maxDeq: [Int] = [] // indices of potential maximums
    var totalSum = 0
    
    for end in 0..<nums.count {
        
        // Remove from back while current is bigger (for max)
        while let last = maxDeq.last, nums[end] >= nums[last] {
            maxDeq.removeLast()
        }
        maxDeq.append(end)
        
        // Remove from back while current is smaller (for min)
        while let last = minDeq.last, nums[end] <= nums[last] {
            minDeq.removeLast()
        }
        minDeq.append(end)
        
        
        // Remove elements out of window
        if let first = maxDeq.first, first < end - k + 1 {
            maxDeq.removeFirst()
        }
        if let first = minDeq.first, first < end - k + 1 {
            minDeq.removeFirst()
        }
        
        // Add to total sum once window is fully formed
        if end >= k - 1 {
            totalSum += nums[maxDeq.first!] + nums[minDeq.first!]
        }
        
        print("Window end: \(end), maxDeq: \(maxDeq.map { nums[$0] }), minDeq: \(minDeq.map { nums[$0] }), totalSum: \(totalSum)")
    }
    
    return totalSum
}


minMaxSumOfSizeKSWDeq([2, 5, -1, 7, -3, -1, -2], 4)

// MARK: -  Problem 4: Shortest Subarray with Sum ≥ K

/* Goal:
 Given an integer array nums and an integer k, return the length of the shortest
 non-empty subarray with a sum ≥ k. Use prefix sums and a monotonic deque.
 
 Example:
 Input: nums = [2, -1, 2], k = 3
 Number of windows: n - k + 1 = 3 - 3 + 1 = 1
 Output: 3
 
 */

// MARK:  Brute Force
/*
 Time: O(n²) → for each start index, you might scan up to n elements.
 Space: O(1) auxiliary → only variables, not counting output.
 */
methodLabel("Problem 4: Shortest Subarray with Sum ≥ K ", .bruteForce)

func shortestSubarraySumBF(_ nums: [Int], _ k: Int) -> Int {
    guard !nums.isEmpty, k > 0 else { return 0 }
    
    var minLength =  Int.max
    
    for i in 0..<nums.count {
        var currentSum = 0
        
        for j in i..<nums.count {
            currentSum += nums[j]
            
            print("current window: \(nums[i...j]), current sum: \(currentSum), min length: \(minLength)")
            
            if currentSum >= k {
                minLength = min(minLength, j - i + 1)
                break
            }
        }
    }
    
    return minLength
}


shortestSubarraySumBF([2, -1, 2], 3)


// MARK: Sliding Window Prefix Sum W/ Montonic Deque

/*
 Time Complexity: O(n) → each index enters and exits deque at most once
 Space Complexity: O(n) → prefix sums + deque
 */

methodLabel("Problem 4: Shortest Subarray with Sum ≥ K", .slidingWindow)

func shortestSubarraySumSW(_ nums: [Int], _ k: Int) -> Int {
    guard !nums.isEmpty, k > 0 else { return 0 }
    let n = nums.count
    
    var prefixSums = [Int](repeating:0, count: n + 1)
    
    // Step 1: Compute prefix sums
    for i in 0..<n {
        prefixSums[i + 1] = prefixSums[i] + nums[i]
    }
    
    
    var deque: [Int] = []  // stores indices of prefix sums
    var minLength = n + 1  // initialize with impossible max
    
    for i in 0...n {
        
        // Maintain monotonic increasing deque
        while let last = deque.last, prefixSums[i] <= prefixSums[last] {
            deque.removeLast()
        }
        
        // Check if current prefix sum - front >= k
        while let first  = deque.first, prefixSums[i] - prefixSums[first] >= k {
            minLength = min(minLength, i - first)
            deque.removeFirst()
        }
        
        deque.append(i)
        
        print("i: \(i), prefixSum: \(prefixSums[i]), deque: \(deque), minLength: \(minLength)")
    }
    
    return minLength <= n ? minLength : -1
}


shortestSubarraySumSW([2, -1, 2], 3)


