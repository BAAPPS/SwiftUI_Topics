import Cocoa

// MARK: - Append
// Appending adds an element to the end of a mutable array.
// Complexity: O(1) if the array has enough capacity and is not sharing its storage with another instance; otherwise, O(n).

var names = ["Tim", "John", "Jack", "Chris"]
names.append("David") // ["Tim", "John", "Jack", "Chris", "David"] (O(1))

var numbers = [1, 2, 3]
// (O(m)), where m is the number of elements
numbers.append(contentsOf: 10...12) // ["1", "2", "3", "10", "11", "12"]

// MARK: - Insert
// Inserting at a specific index requires shifting elements, making it O(n).
// If inserting at the end, it is equivalent to append (O(1)).

// MARK: Insert a new element at a specific position
var ids = [1, 2, 3, 4, 5]
ids.insert(10, at: 2) // [1, 2, 10, 3, 4, 5] (O(n))
ids.insert(20, at: ids.endIndex) // [1, 2, 10, 3, 4, 5, 20] (O(1))

// MARK: Insert a sequence of elements at a specific position
// Complexity: O(n + m), where n is the length of the array and m is the number of new elements.
// If inserting at the end, it’s equivalent to append(contentsOf:) (O(m)).

ids.insert(contentsOf: 10...15, at: 4) // [1, 2, 10, 3, 10, 11, 12, 13, 14, 15, 4, 5, 20] (O(n + m))

ids.insert(contentsOf: 20...25, at: ids.endIndex) // [1, 2, 10, 3, 10, 11, 12, 13, 14, 15, 4, 5, 20, 20, 21, 22, 23, 24, 25] (O(m))

// MARK: - Replace Subrange

// Replaces a specified range of elements in an array with elements from another collection.
// - O(n + m), where n is the length of the array and m is the length of `newElements`.
// - If replacing a subrange that ends at the array’s end (effectively appending), this is equivalent to `append(contentsOf:)` with O(m) complexity.

// MARK: Replace a Range with Repeated Values


var nums = [10, 20, 30, 40, 50]

// MARK: 1. Replace with Repeated Values
// Removes elements from index 1 to 4 and replaces them with five 2's
nums.replaceSubrange(1...4, with: repeatElement(2, count: 5)) // Output: [10, 2, 2, 2, 2, 2]

// MARK: 2. Replace with an Array

// Replaces elements from index 1 to 3 with [10, 20]
nums.replaceSubrange(1...3, with: [10, 20]) // Output: [10, 10, 20, 2, 2]

// MARK: 3. Replace with a Range Collection

// Replaces elements from index 1 to 3 with the range 100...102
nums.replaceSubrange(1...3, with: 100...102) // Output: [10, 100, 101, 102, 2]

// MARK: 4. Replace with Different Number of Elements

var nameOfUsers = ["Tim", "John", "Alex", "Tom"]
print("Original: \(nameOfUsers)")

// Removes elements at indices 1...2 ("John", "Alex") and replaces them with five "Kevin" entries (more elements)
nameOfUsers.replaceSubrange(1...2, with: repeatElement("Kevin", count: 5)) // Output: ["Tim", "Kevin", "Kevin", "Kevin", "Kevin", "Kevin", "Tom"]

// Replaces elements at indices 1...3 ("Kevin", "Kevin", "Kevin") with three new names (equal number of elements)
nameOfUsers.replaceSubrange(1...3, with: ["Alex", "Matt", "Matthew"]) // Output: ["Tim", "Alex", "Matt", "Matthew", "Kevin", "Kevin", "Tom"]

// MARK: ReplaceSubrange with Zero-Length Range or Collection

// Example Array
var numbers1 = [10, 20, 30, 40, 50]

// MARK:  Using a zero-length RANGE
// This inserts elements at the startIndex of the empty range.
// Equivalent to: numbers.insert(contentsOf: [15, 17], at: 2) (clearer to use .insert(contentsOf:at:) for readability)
numbers1.replaceSubrange(2..<2, with: [15, 17]) // Output: [10, 20, 15, 17, 30, 40, 50]

//  MARK: Using a zero-length COLLECTION
// This removes the range 3...4 (i.e., 17 and 30) without replacement.
// Equivalent to: numbers.removeSubrange(3...4) (clearer to use .removeSubrange(_:) instead)
numbers1.replaceSubrange(3...4, with: []) // Output: [10, 20, 15, 40, 50]
