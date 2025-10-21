# Dropping Elements & Sliding Windows in Swift Collections

This section covers methods for **removing elements** and performing **sliding window operations** in Swift collections: `dropFirst`, `dropLast`, and `drop(while:)`.

---

## Table of Contents

* [dropFirst(_:)](#dropfirst)
* [dropLast(_:)](#droplast)
* [drop(while:)](#dropwhile)
* [Sliding Window Examples](#sliding-window-examples)

---

## `dropFirst(_:)`

```swift
let numbers = [10, 20, 30, 40, 50]

// Drop first element
let afterDrop = numbers.dropFirst()
print(afterDrop) // [20, 30, 40, 50]

// Drop first 3 elements
let afterDrop3 = numbers.dropFirst(3)
print(afterDrop3) // [40, 50]
```

---

## `dropLast(_:)`

```swift
let afterDropLast = numbers.dropLast()
print(afterDropLast) // [10, 20, 30, 40]
```

---

## `drop(while:)`

```swift
let numbers2 = [1, 2, 3, 4, 5, 6, 1, 2, 3]

// Skip numbers until we hit a value >= 4
let droppedNumbers = numbers2.drop(while: { $0 < 4 })
print(droppedNumbers) // [4, 5, 6, 1, 2, 3]

// Drop strings until predicate fails
let names = ["Alice", "Bob", "Charlie", "David"]
let remainingNames = names.drop(while: { $0.count < 7 })
print(remainingNames) // ["Charlie", "David"]
```

---

## Sliding Window Examples

**Sliding window using `dropFirst` (forward direction):**

```swift
let numbers1 = [1, 2, 3, 4, 5, 6]
let windowSize = 3
var current: ArraySlice<Int> = numbers1[0..<numbers1.count]

while current.count >= windowSize {
    let window = current.prefix(windowSize)
    let windowSum = window.reduce(0, +)
    print("Window:", window)
    print("Window sum:", windowSum)
    
    current = current.dropFirst(1) // move window forward by 1
}
```

**Sliding window using `dropLast` (backward direction):**

```swift
var current1: Array<Int> = numbers // use Array to avoid ArraySlice index issues

while current1.count >= windowSize {
    let window = current1.suffix(windowSize)
    let windowSum = window.reduce(0, +)
    print("Window:", window, "Sum:", windowSum)
    
    current1 = Array(current1.dropLast(1)) // shrink window from the end
}
```

**Notes:**
* `dropFirst(_:)`, and `dropLast(_:)` are often combined for sliding window calculations.
* Using `ArraySlice` avoids copying the array unnecessarily for each step.
* `drop(while:)` is useful when you want to skip elements until a certain condition is met and then apply a sliding window.

