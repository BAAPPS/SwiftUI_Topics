//  Sliding Window – Group 2: Average of Subarrays Variations
//  ----------------------------------------------------------
//
//  Concept Focus:
//  Understand how to efficiently calculate averages of contiguous subarrays
//  using the **fixed-size sliding window** pattern.
//
//  Key Idea:
//  As the window slides across the array, we maintain a running sum of the
//  current window. Each time we move forward, subtract the element that
//  slides out and add the new one that enters — compute the average in O(1).
//  Pro Tip:
//  - Always track both the *running sum* and *window start index*.
//  - Don’t forget to use `Double` for average calculation (avoid integer division).
//  - Once comfortable, try solving using a dynamic-sized window next.



import Cocoa

// MARK: - Average of All Subarrays of Size K
/*
 Goal: Compute average for every contiguous subarray of size k.
 Input: [1, 2, 3, 4, 5], k = 3
 Output: [2.0, 3.0, 4.0]
*/


// MARK: Brute Force
// O(n*k)
print("Average of All Subarrays of Size K BRUTE FORCE")

func subarrayAverageBF(for array: [Int], size k: Int) -> [Double] {
    guard k <= array.count else { return [] }
    var averages: [Double] = []
    
    for i in 0...(array.count - k){
        let window = array[i..<(i+k)]
        let sum = window.reduce(0, +)
        averages.append((Double(sum) / Double(k)))
        print("current window: \(window), current sum: \(sum), average: \(Double(sum) / Double(k))")
    }
    return averages
}

print("BF Averages of all subarrays of size 3: \(subarrayAverageBF(for: [1, 2, 3, 4, 5], size: 3))")

// MARK: Sliding Window
// O(n)

print("\nAverage of All Subarrays of Size K SLIDING WINDOW")

func subarrayAverageSW(for array: [Int], size k: Int) -> [Double] {
    guard k <= array.count else { return [] }
    
    var currentSum: Int = array[0..<k].reduce(0, +)
    var averages: [Double] = []
    averages.append((Double(currentSum) / Double(k)))
    print("Initial window: \(array[0..<k]), Initial sum: \(currentSum), Initial average:\(Double(currentSum) / Double(k))")
    
    for end in k..<array.count {
        currentSum += array[end] - array[end - k]
        averages.append((Double(currentSum) / Double(k)))
        print("current window: \(array[(end - k + 1)...end]), current sum: \(currentSum), average: \(Double(currentSum) / Double(k))")
    }
    
    return averages
    
}

print("SW Averages of all subarrays of size 3: \(subarrayAverageSW(for: [1, 2, 3, 4, 5], size: 3))")


// MARK: - Average of All Subarrays of Size K (with Floating Point Precision)

/*
 Goal: Handle arrays with decimals or double precision
 Input: [1.2, 2.5, 3.5, 4.8, 5.0], k = 2
 Output: [1.85, 3.0, 4.15, 4.9]
*/


// MARK: Brute Force
// O(n*k)

print("\nAverage of All Subarrays of Size K  w/ Floating Point Precision BRUTE FORCE")

func subarrayAverageBFWithFP(for array: [Double], size k: Int) -> [Double] {
    guard k <= array.count else { return [] }
    var averages: [Double] = []
    
    for i in 0...(array.count - k){
        let window = array[i..<i+k]
        let sum = window.reduce(0, +)
        averages.append((sum / Double(k)))
        print("current window: \(window), current sum: \(sum), average: \(sum / Double(k))")
    }
    return averages
}

print("BF Averages of all subarrays of size 2 with FP: \(subarrayAverageBFWithFP(for:[1.2, 2.5, 3.5, 4.8, 5.0], size: 2))")


// MARK: Sliding Window
// O(n)

print("\nAverage of All Subarrays of Size K  w/ Floating Point Precision SLIDING WINDOW")

func subarrayAverageSWWithFP(for array: [Double], size k: Int) -> [Double] {
    guard k <= array.count else { return [] }
    var currentSum = array[0..<k].reduce(0, +)
    var averages: [Double] = []
    let initialAverage: Double = currentSum / Double(k)
    averages.append(initialAverage)
    print("Initial window: \(array[0..<k]), Initial sum: \(currentSum), Initial average:\(initialAverage)")
    
    for rightWindow in k..<array.count {
        currentSum += array[rightWindow] - array[rightWindow - k]
        averages.append((currentSum / Double(k)))
        print("current window: \(array[(rightWindow - k + 1)...rightWindow]), current sum: \(currentSum), current average: \(currentSum / Double(k))")
    }
    
    return averages
}

print("SW Averages of all subarrays of size 2 with FP: \(subarrayAverageSWWithFP(for:[1.2, 2.5, 3.5, 4.8, 5.0], size: 2))")


// MARK: - Check if Average of Window ≥ Threshold
/*
 Goal: Count windows whose average is greater than or equal to a given threshold.
 Input: [2, 1, 3, 5, 2, 8, 1, 5], k = 3, threshold = 4
 Output: 2
*/


// MARK: Brute Force
// O(n*k)
print("\nCheck if Average of Window ≥ Threshold BRUTE FORCE")

func checkSubarrayThresholdBF(for array: [Int], size k: Int, threshold: Int) -> Int {
    guard k <= array.count else { return 0 }
    
    var count = 0
    
    for i in 0...(array.count - k) {
        let window = array[i..<i+k]
        let sum = window.reduce(0, +)
        
        if sum >= threshold * k  {
            count += 1
        }
        print("current window: \(window), current sum: \(sum), count: \(count)")
    }
    return count
}

print("BF Check if Average of Window ≥ Threshold: \(checkSubarrayThresholdBF(for:[2, 1, 3, 5, 2, 8, 1, 5], size: 3, threshold: 4 ))")

// MARK: Sliding Window
// O(n)
print("\nCheck if Average of Window ≥ Threshold SLIDING WINDOW")

func checkSubarrayThresholdSW(for array: [Int], size k: Int, threshold: Int) -> Int {
    guard k <= array.count else { return 0 }
    var currentSum = array[0..<k].reduce(0, +)
    var count = currentSum >= threshold * k ? 1 : 0
    
    print("Initial window: \(array[0..<k]), Initial sum: \(currentSum), Initial count:\(count)")
    
    for end in k..<array.count {
        currentSum += array[end] - array[end - k]
        if currentSum >= threshold * k {
            count += 1
        }
        
        print("current window: \(array[(end - k + 1)...end]), current sum: \(currentSum), count: \(count) ")
    }
    
    return count
    
}

print("SW Check if Average of Window ≥ Threshold: \(checkSubarrayThresholdSW(for:[2, 1, 3, 5, 2, 8, 1, 5], size: 3, threshold: 4 ))")


// MARK: - Moving Average Stream
/*
 Goal: Compute moving average as elements stream in one by one.
 Input: Stream [1, 10, 3, 5], k = 3
 Output: [1.0, 5.5, 4.6, 6.0]
*/

// MARK: Brute Force
// O(n*k)
print("\nMoving Average Stream BRUTE FORCE")

func movingAverageStreamBF(for array: [Int], size k: Int) -> [Double] {
    var results: [Double] = []
    
    for i in 0..<array.count {
        // Take last k elements (or fewer if stream not yet full)
        let start = max(0, i - k + 1)
        let window = array[start...i]
        let sum = window.reduce(0, +)
        let average = Double(sum) / Double(window.count)
        results.append(average)
        print("Window:", window, "→ Average:", average)
    }
    return results
}

let streamResult = movingAverageStreamBF(for: [1, 10, 3, 5], size: 3)

print("BF Moving Average Stream: \(streamResult)")

// MARK: Sliding Window
// O(n)
print("\nMoving Average Stream SLIDING WINDOW")

func movingAverageStreamSW(for array: [Int], size k: Int) -> [Double] {
    guard k > 0 else { return [] }
    var results: [Double] = []
    var window: [Int] = []
    var currentSum = 0
    
    for value in array {
        // Add new element to window
        window.append(value)
        currentSum += value
        
        // If window exceeds size k, remove oldest
         if window.count > k {
             currentSum -= window.removeFirst()
         }
         
         // Compute average for current window
         let average = Double(currentSum) / Double(window.count)
         results.append(average)
         
         print("Window:", window, "→ Sum:", currentSum, "→ Average:", average)
    }
   
    return results
}

print("SW Moving Average Stream: \(movingAverageStreamSW(for: [1, 10, 3, 5], size: 3))")
