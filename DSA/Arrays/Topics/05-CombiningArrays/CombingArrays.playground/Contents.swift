import Cocoa

// MARK: - append(contentsOf:)
// Complexity: O(m) on average, where m is the number of elements being appended.
// Appends the elements of a sequence to the end of the array.


var numbers = [1, 2, 3, 4, 5]
numbers.append(contentsOf: 10...15) // [1, 2, 3, 4, 5, 10, 11, 12, 13, 14, 15]

// MARK: - +(_:_:)
// The `+` operator creates a **new array** by concatenating two collections.
// LHS (Left-Hand Side) elements come first, followed by RHS (Right-Hand Side) elements.
/// Notes:
/// The + operator does not modify either LHS or RHS; it creates a new array.
/// Works with any collection type conforming to Collection, like Array, ContiguousArray, etc.
/// Complexity: O(n + m), where n = LHS length, m = RHS length.

// Numbers Example
let numbers1 = [7, 8, 9, 10]

// LHS: 1...6  -> [1, 2, 3, 4, 5, 6]
// RHS: numbers1 -> [7, 8, 9, 10]
let moreNumbers = (1...6) + numbers1 // Output: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// Strings Example
let firstNames = ["Alice", "Bob", "Charlie"]
let lastNames = ["Smith", "Johnson", "Williams"]

// LHS: firstNames -> ["Alice", "Bob", "Charlie"]
// RHS: lastNames  -> ["Smith", "Johnson", "Williams"]
let allNames = firstNames + lastNames // Output: ["Alice", "Bob", "Charlie", "Smith", "Johnson", "Williams"]

// MARK: - +=(_:_:)
// The `+=` operator appends the elements of a sequence (RHS) to an existing collection (LHS) in-place.
// LHS is modified, RHS is not changed.
// Complexity: O(m), where m is the length of RHS.

// Numbers Example
var numbers3 = [1, 2, 3, 4, 5]

// LHS: numbers3 -> [1, 2, 3, 4, 5]
// RHS: 10...15  -> [10, 11, 12, 13, 14, 15]
numbers3 += 10...15 // Output: [1, 2, 3, 4, 5, 10, 11, 12, 13, 14, 15]

// --------------------
// Strings Example
// --------------------
var usernames = ["Alice", "Bob"]
let moreUsermames = ["Charlie", "David"]

// LHS: usernames -> ["Alice", "Bob"]
// RHS: moreUsermames  -> ["Charlie", "David"]
usernames += moreUsermames // Output: ["Alice", "Bob", "Charlie", "David"]
