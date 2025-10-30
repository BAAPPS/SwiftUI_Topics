import Cocoa

// MARK: - Sliding Window Concept
/*
 Focus: Understand how the sliding window moves across an array
 and captures subarrays efficiently.

 Pro Tip:
 - Visualize elements entering and leaving the window.
 - Start simple before optimizing sums, max, averages, or uniqueness.
*/

// Example array and window size
let numbers = [1, 3, 4, 5, 6, 7, 10, 12, 15]
let k = 3

// MARK: Extract all subarrays of size k
// Time Complexity: O(n*k)
print("\n--- Extract subarrays of size \(k) ---")
var subarrays: [[Int]] = []

for i in 0...(numbers.count - k) {
    let window = Array(numbers[i..<i + k])
    subarrays.append(window)
    print("Window \(i + 1): \(window)")
}

print("All subarrays of size \(k): \(subarrays)")

// MARK: Compute sum of each subarray
// Time Complexity: O(n*k)
print("\n--- Compute sum of each window ---")
var subarraySums: [Int] = []

for i in 0...(numbers.count - k) {
    let window = numbers[i..<i + k]
    let sum = window.reduce(0, +)
    subarraySums.append(sum)
    print("Window \(i + 1): \(Array(window)) → Sum = \(sum)")
}

print("All window sums: \(subarraySums)")

// MARK: Maximum in every window
// Time Complexity: O(n*k)
print("\n--- Maximum in every window ---")
let example1 = [1, 3, 5, 2, 8, 0, 9]
let size = 3
var maxArray: [Int] = []

for i in 0...(example1.count - size) {
    let window = example1[i..<i + size]
    let maxValue = window.max() ?? 0
    maxArray.append(maxValue)
    print("Window \(i + 1): \(Array(window)) → Max = \(maxValue)")
}

print("All window max values: \(maxArray)")

// MARK: Average of each subarray
// Time Complexity: O(n*k)
print("\n--- Average of each window ---")
let example2 = [1, 2, 3, 4, 5]
let kSize = 2
var averageArray: [Double] = []

for i in 0...(example2.count - kSize) {
    let window = example2[i..<i + kSize]
    let sum = window.reduce(0, +)
    let average = Double(sum) / Double(kSize)
    averageArray.append(average)
    print("Window \(i + 1): \(Array(window)) → Average ≈ \(average)")
}

print("All window averages: \(averageArray)")

// MARK: Count subarrays with sum < target
// Time Complexity: O(n*k)
print("\n--- Count subarrays with sum < target ---")
let example3 = [2, 1, 3, 4]
let target = 7
var targetResult: [Int] = []

for i in 0..<example3.count {
    var sum = 0
    for j in i..<example3.count {
        sum += example3[j]
        if sum < target {
            targetResult.append(sum)
            print("Subarray \(example3[i...j]) → Sum = \(sum)")
        } else {
            break
        }
    }
}

print("All subarray sums < \(target): \(targetResult)")

// MARK: Smallest subarray with sum ≥ target
// Time Complexity: O(n*k)
print("\n--- Smallest subarray with sum ≥ target ---")
let example4 = [2, 3, 1, 2, 4, 3]
let target2 = 7
var lengths: [Int] = []

for i in 0..<example4.count {
    var sum = 0
    for j in i..<example4.count {
        sum += example4[j]
        if sum >= target2 {
            let length = j - i + 1
            lengths.append(length)
            print("Subarray \(example4[i...j]) → Sum = \(sum), Length = \(length)")
            break
        }
    }
}

if let minLength = lengths.min() {
    print("Smallest subarray length ≥ \(target2): \(minLength)")
} else {
    print("No subarray found with sum ≥ \(target2)")
}

// MARK: Check if all elements in the window are unique
// Time Complexity: O(n*k)
print("\n--- Check uniqueness in each window ---")
let example5 = [1, 2, 3, 1, 4, 5]
let windowSize = 3
var allWindowsUnique = true

for i in 0...(example5.count - windowSize) {
    let window = example5[i..<i + windowSize]
    let hasDuplicates = Set(window).count != window.count
    if hasDuplicates {
        allWindowsUnique = false
        break
    }
}

print("All windows of size \(windowSize) unique? \(allWindowsUnique)")

// MARK: Longest substring without repeating characters (string version)
// Time Complexity: O(n*k)
print("\n--- Longest substring without repeating characters ---")
let stringChar = "abcabcbb"
let characters = Array(stringChar)
var maxLength = 0

for i in 0..<characters.count {
    var seen = Set<Character>()
    var currentLength = 0
    
    print("\nStarting new substring at index \(i):")
    
    for j in i..<characters.count {
        let char = characters[j]
        if seen.contains(char) {
            print("  Duplicate '\(char)' found at index \(j), stopping substring.")
            break
        }
        seen.insert(char)
        currentLength += 1
        print("  Adding '\(char)' → Current length: \(currentLength)")
    }
    
    maxLength = max(maxLength, currentLength)
    print("Substring starting at index \(i) ended with length: \(currentLength)")
}

print("Longest substring without repeating characters: \(maxLength)")

