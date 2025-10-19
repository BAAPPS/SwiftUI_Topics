# Swift Array Initialization Guide

This guide demonstrates **all common and advanced ways to create arrays in Swift** using `import Cocoa`. It covers empty arrays, arrays with elements, arrays from sequences, arrays with repeated values, and advanced unsafe uninitialized array initialization.

---

## Table of Contents

1. [Homogeneous Array Initialization Examples](#homogeneous-array-initialization-examples)  
   1.1 [Empty Arrays](#empty-arrays)  
   1.2 [Arrays with Elements](#arrays-with-elements)  
2. [Array Initialization from a Sequence](#array-initialization-from-a-sequence)  
3. [Convert a Complex Collection to an Array](#convert-a-complex-collection-to-an-array)  
4. [Array Initialization with Repeated Values](#array-initialization-with-repeated-values)  
5. [Advanced Array Initialization (Unsafe Uninitialized Capacity)](#advanced-array-initialization-unsafe-uninitialized-capacity)  

---

## Homogeneous Array Initialization Examples

### Empty Arrays

```swift
/// Explicit empty array of Int
var emptyIntArray = Array<Int>()
/// Explicit empty array of String
var emptyStringArray = Array<String>()

/// Preferred empty array using type annotation
var emptyArrayInt: [Int] = []
var emptyArrayString: [String] = []
````

* Use `Array<Type>()` to explicitly declare an empty array.
* Preferred approach for readability: type annotation with `[]`.

---

### Arrays with Elements

```swift
/// Implicitly typed array of Int
var arrayIntImplicit = [1, 2, 3]
/// Implicitly typed array of String
var arrayStringImplicit = ["a", "b", "c"]
```

* Swift infers the array type automatically from literals.

---

## Array Initialization from a Sequence

```swift
/// Array.init(_:)
// Creates a new array from any sequence (numeric ranges, strings, dictionary keys/values, or mapped sequences)

// Numeric range
let numSequence = Array(1...7) // [1, 2, 3, 4, 5, 6, 7]

// Numeric range mapped to strings
let stringSequence = Array((0...8).map { "User\($0)" }) // ["User0", "User1", ..., "User8"]

// String as a sequence of characters
let charSequence = Array("BAAPPS") // ["B", "A", "A", "P", "P", "S"]
```

* `Array.init(_:)` is versatile and works with **any sequence**.

---

## Convert a Complex Collection to an Array

```swift
let userDict: [Int: String] = [1: "Duck01", 9: "Tim02", 8: "Dim032", 10: "Turner01"]

/// Convert dictionary keys to array
let ids = Array(userDict.keys) // [1, 8, 9, 10] (order not guaranteed)

/// Convert dictionary values to array
let usernames = Array(userDict.values) // ["Duck01", "Dim032", "Tim02", "Turner01"]
```

* Dictionary keys and values are sequences and can be converted easily to arrays.

---

## Array Initialization with Repeated Values

```swift
/// Creates an array of repeated values (String version)
func repeatingValue(value: String, count: Int) -> [String] {
    return Array(repeating: value, count: count)
}

/// Generic version for any type (DRY principle)
func repeatingValueGeneric<T>(value: T, count: Int) -> [T] {
    return Array(repeating: value, count: count)
}

// Examples
let repeatHello5Times = repeatingValue(value: "Hello", count: 5)
let repeatPC7Times = repeatingValue(value: "PC", count: 7)
let repeatNumber4Times = repeatingValueGeneric(value: 42, count: 4)
let repeatBool3Times = repeatingValueGeneric(value: true, count: 3)
```

* `Array(repeating:count:)` is ideal for **arrays with identical elements**.
* The generic version works for **any data type**.

---

## Advanced Array Initialization (Unsafe Uninitialized Capacity)

```swift
/// Array.init(unsafeUninitializedCapacity:initializingWith:)
/// Creates an array with the specified capacity without initializing its elements.
/// You provide a closure to fill the elements manually and specify how many were initialized.
/// ⚠️ Unsafe — only use for performance-critical tasks or large numeric computations.

let squares = Array<Int>(unsafeUninitializedCapacity: 5) { buffer, initializedCount in
    for i in 0..<5 {
        buffer[i] = i * i
    }
    initializedCount = 5
}

print(squares) // [0, 1, 4, 9, 16]
```

* This is **rarely needed** for everyday coding.
* Use for **high-performance or large numeric arrays**.
* Safer alternatives: `Array(repeating:count:)` or `Array(_)`.

