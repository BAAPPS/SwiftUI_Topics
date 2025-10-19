import Cocoa

// ============================================
// Swift Array Initialization Guide
// Covers:
// - Empty arrays
// - Arrays with elements (implicit & explicit)
// - Arrays from sequences (numeric ranges, strings, dictionary keys/values)
// - Arrays with repeated values
// - Advanced unsafe uninitialized array initialization
// ============================================

// MARK: - Homogeneous Array Initialization Examples

// MARK: Empty Arrays

/// Explicit empty array of Int
var emptyIntArray = Array<Int>()

/// Explicit empty array of String
var emptyStringArray = Array<String>()

/// Preferred empty array using type annotation
var emptyArrayInt: [Int] = []
var emptyArrayString: [String] = []

// MARK: Arrays with Elements

/// Implicitly typed array of Int
var arrayIntImplicit = [1, 2, 3]

/// Implicitly typed array of String
var arrayStringImplicit = ["a", "b", "c"]

// MARK: - Array Initialization from a Sequence

/// Array.init(_:)
// Creates a new array from any sequence (numeric ranges, strings, dictionary keys/values, or mapped sequences)

// Numeric range
let numSequence = Array(1...7) // [1, 2, 3, 4, 5, 6, 7]

// Numeric range mapped to strings
let stringSequence = Array((0...8).map { "User\($0)" }) // ["User0", "User1", ..., "User8"]

// String as a sequence of characters
let charSequence = Array("BAAPPS") // ["B", "A", "A", "P", "P", "S"]

// MARK: - Convert a Complex Collection to an Array

let userDict: [Int: String] = [1: "Duck01", 9: "Tim02", 8: "Dim032", 10: "Turner01"]

/// Convert dictionary keys to array
let ids = Array(userDict.keys) // [1, 8, 9, 10] (order not guaranteed)

/// Convert dictionary values to array
let usernames = Array(userDict.values) // ["Duck01", "Dim032", "Tim02", "Turner01"]

// MARK: - Array Initialization with Repeated Values

/// Creates an array of repeated values (String version)
func repeatingValue(value: String, count: Int) -> [String] {
    return Array(repeating: value, count: count)
}

/// Generic version for any type (DRY principle)
func repeatingValueGeneric<T>(value: T, count: Int) -> [T] {
    return Array(repeating: value, count: count)
}

// Examples
let repeatHello5Times = repeatingValue(value: "Hello", count: 5) // ["Hello", "Hello", "Hello", "Hello", "Hello"]
let repeatPC7Times = repeatingValue(value: "PC", count: 7)       // ["PC", "PC", "PC", "PC", "PC", "PC", "PC"]
let repeatNumber4Times = repeatingValueGeneric(value: 42, count: 4) // [42, 42, 42, 42]
let repeatBool3Times = repeatingValueGeneric(value: true, count: 3) // [true, true, true]

// MARK: - Advanced Array Initialization (Unsafe Uninitialized Capacity)

/// Array.init(unsafeUninitializedCapacity:initializingWith:)
/// Creates an array with the specified capacity without initializing its elements.
/// You provide a closure to fill the elements manually and specify how many were initialized.
/// ⚠️ Unsafe — only use for performance-critical tasks or large numeric computations.
/// Typical Swift code rarely needs this; prefer safe initializers like Array(repeating:count:) or Array(_:).

// Example: creating an array of squares efficiently
let squares = Array<Int>(unsafeUninitializedCapacity: 8) { buffer, initializedCount in
    for i in 0..<8 {
        buffer[i] = i * i
    }
    initializedCount = 7
}

print(squares) // [0, 1, 4, 9, 16, 25, 36]

