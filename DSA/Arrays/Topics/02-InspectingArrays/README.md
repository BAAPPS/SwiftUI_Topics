# Swift Collection Emptiness and Capacity Management Guide

This guide demonstrates how to check if a **collection** (like an array or string) is **empty** and how to understand **array capacity** in Swift. It covers:

- Checking if a collection (array or string) is empty
- Basic and preferred ways to check for emptiness
- Comparing the **count** and **capacity** of arrays
- Preallocating **array capacity** for performance optimization

---

## Table of Contents

1. [Checking if a Collection is Empty](#checking-if-a-collection-is-empty)  
2. [Basic and Preferred Emptiness Check](#basic-and-preferred-emptiness-check)  
3. [Count vs Capacity](#count-vs-capacity)  
4. [Preallocating Array Capacity](#preallocating-array-capacity)  
5. [Summary](#summary)

---

## Checking if a Collection is Empty

In Swift, you can check if an array or string is empty using `count`, `isEmpty`, or by writing a custom helper function.

### Example: Checking if an Array or String is Empty

```swift
import Cocoa

// MARK: - Checking if a Collection is Empty

let games = ["Battlefield 6", "Call of Duty: Modern Warfare", "Grand Theft Auto V", "Elden Ring", "Dark Souls III"]
let id = [1, 2, 3, 4, 5]

// Generic function to check if an array is nil or empty (O(1))
func isEmptyArray<T>(_ array: [T]?) -> Bool {
    guard let array = array else {
        return true // Nil arrays are considered empty
    }
    return array.isEmpty
}

// Check if a String is nil or empty (O(1))
func isEmptyString(_ string: String?) -> Bool {
    guard let string = string else {
        return true // Nil strings are considered empty
    }
    return string.isEmpty
}

// Examples:
let name1: String? = "CodersKnowledge"
let name2: String? = nil
let name3: String? = ""

print(isEmptyString(name1)) // Outputs: false
print(isEmptyString(name2)) // Outputs: true
print(isEmptyString(name3)) // Outputs: true
````

### Explanation:

* The function `isEmptyArray` checks if an array is either `nil` or empty.
* Similarly, `isEmptyString` checks if a string is either `nil` or empty.
* These checks are **O(1)**, meaning they have constant time complexity.

---

## Basic and Preferred Emptiness Check

There are two ways to check if a collection is empty:

1. **Basic Check:** Using the `count` property of the array.
2. **Preferred Check:** Using a custom helper function like `isEmptyArray` or `isEmptyString`.

### Example: Basic Check (Using `count`)

```swift
// Basic / worse-case check using count
print(games.count == 0 ? "Empty" : "Not Empty") // Outputs: Not Empty
```

### Example: Preferred Check (Using Helper Function)

```swift
// Preferred / safer check using helper function
print(isEmptyArray(games)) // Outputs: false
print(!isEmptyArray(id))   // Outputs: true
```

* **Basic Check:** `games.count == 0` checks the array's length directly. While this works fine, using `isEmptyArray` provides more clarity.
* **Preferred Check:** The `isEmptyArray` function is safer and more expressive for checking whether the array is empty or `nil`.

---

## Count vs Capacity

An important concept in arrays is **capacity**, which is the amount of space allocated in memory for an array, whereas **count** refers to the number of elements actually in the array.

### Example: Count vs Capacity

```swift
// MARK: - Count vs Capacity

var numbers: [Int] = []

print("\nInitial state:")
print("Count: \(numbers.count), Capacity: \(numbers.capacity)") // 0, 0

// Adding elements and watching the capacity grow
for i in 1...10 {
    numbers.append(i)
    print("After appending \(i): Count = \(numbers.count), Capacity = \(numbers.capacity)")
}
```

* **`count`** represents how many elements are in the array.
* **`capacity`** is how much space has been allocated internally, which may be more than the `count`.

In most cases, Swift **automatically manages capacity**, growing the array as needed. However, you can manually control it.

---

## Preallocating Array Capacity

You can **preallocate capacity** when you know an array will grow to a certain size. This prevents multiple reallocations, which can improve performance in performance-critical code.

### Example: Preallocating Array Capacity

```swift
// MARK: - Preallocating Capacity for Performance

var largeArray = [Int]()
largeArray.reserveCapacity(20) // Preallocate space for 20 elements
print("\nAfter reserving capacity:")
print("Count: \(largeArray.count), Capacity: \(largeArray.capacity)")

// Add elements
for i in 1...20 {
    largeArray.append(i)
}
print("After adding 20 elements: Count = \(largeArray.count), Capacity = \(largeArray.capacity)")
```

* The `reserveCapacity(_:)` method **pre-allocates memory** for a given number of elements, reducing the number of reallocations if you know how many elements will be added.

---

## Summary

* **Check if an array or string is empty** using `count == 0`, `isEmptyArray()`, or `isEmptyString()`.
* **Capacity** represents the space allocated in memory for an array, while **count** is the actual number of elements.
* You usually don’t need to manage **capacity** manually, but **preallocating** capacity can be helpful for **performance optimization** in large arrays.

### Key Points:

* **`isEmptyArray()` and `isEmptyString()`** are the preferred methods for checking emptiness.
* **`count`** and **`capacity`** are distinct but both important when working with arrays.
* Use **`reserveCapacity(_:)`** to optimize large arrays for better memory allocation efficiency.

This reference should serve as a guide for working with arrays and strings in Swift, particularly for checking emptiness and managing array memory efficiently.
