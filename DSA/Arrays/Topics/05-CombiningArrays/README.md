# Swift Array Combination Guide

This playground demonstrates different ways to combine arrays and sequences in Swift, including `append(contentsOf:)`, `+`, and `+=` operators.

---

## Table of Contents

1. [Appending Elements with `append(contentsOf:)`](#appending-elements-with-appendcontentsof)
2. [Concatenating Arrays with `+`](#concatenating-arrays-with-)
3. [Appending Arrays In-Place with `+=`](#appending-arrays-in-place-with-)

---

## Appending Elements with `append(contentsOf:)`

Appends the elements of a sequence to the end of an array.

- **Complexity:** O(m) on average, where m is the number of elements being appended.
- **Modifies:** The original array.

```swift
import Cocoa

var numbers = [1, 2, 3, 4, 5]
numbers.append(contentsOf: 10...15) 
// Result: [1, 2, 3, 4, 5, 10, 11, 12, 13, 14, 15]
````

---

## Concatenating Arrays with `+`

The `+` operator creates a **new array** by combining two collections.

* **LHS (Left-Hand Side)** elements come first, followed by **RHS (Right-Hand Side)** elements.
* **Does not modify** LHS or RHS.
* **Complexity:** O(n + m), where n = LHS length, m = RHS length.

### Numbers Example

```swift
let numbers1 = [7, 8, 9, 10]

// LHS: 1...6  -> [1, 2, 3, 4, 5, 6]
// RHS: numbers1 -> [7, 8, 9, 10]
let moreNumbers = (1...6) + numbers1
// Output: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

### Strings Example

```swift
let firstNames = ["Alice", "Bob", "Charlie"]
let lastNames = ["Smith", "Johnson", "Williams"]

// LHS: firstNames -> ["Alice", "Bob", "Charlie"]
// RHS: lastNames  -> ["Smith", "Johnson", "Williams"]
let allNames = firstNames + lastNames
// Output: ["Alice", "Bob", "Charlie", "Smith", "Johnson", "Williams"]
```

---

## Appending Arrays In-Place with `+=`

The `+=` operator appends the elements of a sequence (RHS) to an existing collection (LHS) **in-place**.

* **Modifies:** LHS directly.
* **Does not modify:** RHS.
* **Complexity:** O(m), where m is the length of RHS.

### Numbers Example

```swift
var numbers3 = [1, 2, 3, 4, 5]

// LHS: numbers3 -> [1, 2, 3, 4, 5]
// RHS: 10...15  -> [10, 11, 12, 13, 14, 15]
numbers3 += 10...15
// Output: [1, 2, 3, 4, 5, 10, 11, 12, 13, 14, 15]
```

### Strings Example

```swift
var usernames = ["Alice", "Bob"]
let moreUsernames = ["Charlie", "David"]

// LHS: usernames -> ["Alice", "Bob"]
// RHS: moreUsernames -> ["Charlie", "David"]
usernames += moreUsernames
// Output: ["Alice", "Bob", "Charlie", "David"]
```

---

**Notes:**
* Use `+` when you need a **new array**.
* Use `+=` when you want to **modify the existing array**.
* `append(contentsOf:)` is ideal when appending sequences like ranges or slices.

