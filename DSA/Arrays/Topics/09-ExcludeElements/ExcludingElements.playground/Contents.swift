import Cocoa

// MARK: - dropFirst(_:)
// Returns a subsequence containing all but the given number of initial elements.
//O(1) if the collection conforms to RandomAccessCollection; otherwise, O(k), where k is the number of elements to drop from the beginning of the collection.

// Drop first element
let numbers = [10, 20, 30, 40, 50]

let afterDrop = numbers.dropFirst()
print(afterDrop) // [20, 30, 40, 50]

let afterDrop3 = numbers.dropFirst(3)
print(afterDrop3) // [40, 50]

let windowSize = 3
let numbers1 = [1, 2, 3, 4, 5, 6]

// Slide windows by dropping the first elements
// using ArraySlice avoids copying the whole array every step.
var current: ArraySlice<Int> = numbers1[0..<numbers1.count]

while current.count >= windowSize {
    let window = current.prefix(windowSize)
    let windowSum = window.reduce(0, +)
    print("Window:", window)
    print("Window sum: \(windowSum)")
    current = current.dropFirst(1) // move forward by 1
}


// MARK: - dropLast(_:)
// Returns a subsequence containing all but the specified number of final elements.
//O(1) if the collection conforms to RandomAccessCollection; otherwise, O(k), where k is the number of elements to drop from the beginning of the collection.

// let numbers = [10, 20, 30, 40, 50]
// let windowSize = 3

let afterDropLast = numbers.dropLast()
print(afterDropLast) // [10, 20, 30, 40]

var current1: Array<Int> = numbers // use Array to avoid slice index issues

while current1.count >= windowSize {
    let window = current1.suffix(windowSize)
    let windowSum = window.reduce(0, +)
    print("Window:", window, "Sum:", windowSum)
    
    current1 = Array(current1.dropLast(1)) // shrink from the end
}

// MARK: - drop(while:)
// Returns a subsequence by skipping elements while the predicate returns true,
// and returns the remaining elements.
// Complexity: O(n), where n is the length of the collection.

let numbers2 = [1, 2, 3, 4, 5, 6, 1, 2, 3]

// Skip numbers until we hit a value >= 4
let droppedNumbers = numbers2.drop(while: { $0 < 4 })
print(droppedNumbers) // [4, 5, 6, 1, 2, 3]

// You can also chain functional operations
let sumAfterDrop = droppedNumbers.reduce(0, +)
print("Sum of remaining elements:", sumAfterDrop) // 21

let names = ["Alice", "Bob", "Charlie", "David"]

// Drops elements whose length is less than 7
let remainingNames = names.drop(while: { $0.count < 7 })
print(remainingNames) // ["Charlie", "David"]
