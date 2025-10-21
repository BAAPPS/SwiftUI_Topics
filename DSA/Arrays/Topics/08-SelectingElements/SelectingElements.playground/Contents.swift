import Cocoa

// MARK: - prefix(_:)
// Returns a subsequence containing the first `k` elements of a collection.
// O(1) for RandomAccessCollection; otherwise, O(k)

let usernames: [String] = ["alice", "bob", "chris", "david", "eve"]
let maxKUsernameLength: Int = 3

// Get the first 3 elements
let usernamesPrefix = usernames.prefix(maxKUsernameLength)
print("Prefix of usernames:", usernamesPrefix) // ["alice", "bob", "chris"]

// MARK:  Top-K Example

// Find top 3 usernames after sorting in descending order
let sortedUsernames = usernames.sorted(by: >)
let top3Users = sortedUsernames.prefix(3)
print("Top 3 usernames:", top3Users) // ["eve", "david", "chris"]

// MARK: Top-K Number Example
// Find top 3 largest numbers
let numbers = [2, 5, 1, 8, 3, 7]

// Sort ascending and take first 3 elements
let top3Numbers = numbers.sorted(by: <).prefix(3)
print("Top 3 numbers:", top3Numbers) // [1, 2, 3]

// MARK: - prefix(through:)
// Returns a subsequence from the start of the collection through the specified index.
// O(1) for RandomAccessCollection (like Array)

let numbers2 = [3, 5, 1, 8, 3, 7, 15, 10, 22, 20]

// Sort the numbers (ascending order)
let sortedNumbers = numbers2.sorted(by: <)
print("Sorted numbers:", sortedNumbers) // [1, 3, 3, 5, 7, 8, 10, 15, 20, 22]

// Find the index of a target value
if let indexOf15 = sortedNumbers.firstIndex(of: 15) {
    // Get all elements from start up to and including 15
    let window = sortedNumbers.prefix(through: indexOf15)
    print("Window up to 15:", window) // [1, 3, 3, 5, 7, 8, 10, 15]
    
    // Compute sum of elements in the window
    let windowSum = window.reduce(0, +)
    print("Sum of window elements:", windowSum) // 52
}


if let windowIndex = numbers2.firstIndex(of: 15) {
    let window = numbers2.prefix(through: windowIndex) // ArraySlice<Int>
    let windowSize = window.count                        // 7
    print("Window up to 15:", window)
    print("Window size:", windowSize)

    // Step 2: Sliding window of that size
    for i in 0...(numbers2.count - windowSize) {
        let currentWindow = numbers2[i..<(i + windowSize)]
        let windowSum = currentWindow.reduce(0, +)
        print("Window \(currentWindow): sum = \(windowSum)")
    }
}


// MARK: Functional Example
// Multiply each element in the window by 2
if let indexOf15 = sortedNumbers.firstIndex(of: 15) {
    let doubledWindow = sortedNumbers.prefix(through: indexOf15).map { $0 * 2 }
    print("Doubled window:", doubledWindow) // [2, 6, 6, 10, 14, 16, 20, 30]
}

// MARK: - prefix(upTo:)
// Returns a subsequence from the start of the collection up to, but not including, the specified position.
// O(1) for RandomAccessCollection (like Array)

// let numbers2 = [3, 5, 1, 8, 3, 7, 15, 10, 22, 20]

// Exclude the value 15 from the window
if let windowIndex = numbers2.firstIndex(of: 15) {
    let window = numbers2.prefix(upTo: windowIndex) // ArraySlice<Int>
    let windowSize = window.count                    // 6
    print("Window up to (but not including) 15:", window)
    print("Window size:", windowSize)

    // Sliding window of size = windowSize
    for i in 0...(numbers2.count - windowSize) {
        let currentWindow = numbers2[i..<(i + windowSize)]
        let windowSum = currentWindow.reduce(0, +)
        print("Window \(currentWindow): sum = \(windowSum)")
    }
}

// MARK: - prefix(while:)

// Returns a subsequence containing the initial elements until predicate returns false and skipping the remaining elements.
// “All consecutive elements from the start satisfying a condition”
// O(n), where n is the length of the collection.

// let numbers2 = [3, 5, 1, 8, 3, 7, 15, 10, 22, 20]
let greaterThanOrEqual = numbers2.prefix(while: {$0 >= 3})
print(greaterThanOrEqual) // [3,5]

let window = numbers2.prefix(while: {$0 < 10})
let windowTotal = window.reduce(0, +)
print(window) // [3, 5, 1, 8, 3, 7]
print(windowTotal) // 27

// Count consecutive successes from start
let results = [true, true, true, false, true, false]
let consecutiveSuccesses = results.prefix(while: { $0 == true })
print(consecutiveSuccesses.count) // 3

let consecutiveOnes = [1, 0, 1, 1, 0, 1, 1, 1]
let consecutiveOnesSuccesses = consecutiveOnes.prefix(while: { $0 == 1 })
print(consecutiveOnesSuccesses.count)

// MARK: - suffix(_:)
// Returns a subsequence, up to the given maximum length, containing the final elements of the collection.
// O(1) if the collection conforms to RandomAccessCollection; otherwise, O(k), where k is equal to maxLength.

// let numbers = [2, 5, 1, 8, 3, 7]

// Sort ascending and take last 3 elements
let last3Numbers = numbers.sorted(by: <).suffix(3)
print("Last 3 numbers:", last3Numbers) // [5, 7, 8]


// MARK: - suffix(from:)
// Returns a subsequence from the specified position to the end of the collection.
// O(1) if the collection conforms to RandomAccessCollection; otherwise, O(k), where k is equal to maxLength.

// let numbers2 = [3, 5, 1, 8, 3, 7, 15, 10, 22, 20]

if let windowIndex = numbers2.firstIndex(of: 15) {
    let window = numbers2.suffix(from: windowIndex) // ArraySlice<Int>
    let windowSize = window.count                        // 4
    print("Window up to 15:", window)
    print("Window size:", windowSize)

    // Step 2: Sliding window of that size
    for i in 0...(numbers2.count - windowSize) {
        let currentWindow = numbers2[i..<(i + windowSize)]
        let windowSum = currentWindow.reduce(0, +)
        print("Window \(currentWindow): sum = \(windowSum)")
    }
}

if let windowIndex = numbers2.firstIndex(of: 7) {
    let window = numbers2.suffix(from: windowIndex) // ArraySlice<Int>
    let windowSize = window.count                        // 5
    print("Window up to 7:", window)
    print("Window size:", windowSize)

    // Step 2: Sliding window of that size
    // Start from the last possible window and go backwards
    for i in stride(from: numbers2.count - windowSize, through: 0, by: -1) {
        let currentWindow = numbers2[i..<(i + windowSize)]
        let windowSum = currentWindow.reduce(0, +)
        print("Window \(currentWindow): sum = \(windowSum)")
    }
}
