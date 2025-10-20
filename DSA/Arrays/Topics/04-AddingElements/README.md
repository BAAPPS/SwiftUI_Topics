# Swift Array Modification Guide

This playground demonstrates how to **append, insert, and replace elements in Swift arrays**, including replacing ranges and handling edge cases like zero-length ranges or collections.  

All examples are written in Swift with **`import Cocoa`** for playground execution.

---

## Table of Contents

1. [Append](#append)  
2. [Insert](#insert)  
3. [Replace Subrange](#replace-subrange)  
   - [Replace with Repeated Values](#replace-with-repeated-values)  
   - [Replace with an Array](#replace-with-an-array)  
   - [Replace with a Range Collection](#replace-with-a-range-collection)  
   - [Replace with Different Number of Elements](#replace-with-different-number-of-elements)  
   - [Zero-Length Range or Collection](#zero-length-range-or-collection)  

---

## Append

Appending adds an element to the end of a mutable array.

- **Complexity:** O(1) if the array has enough capacity and is not sharing storage; otherwise O(n).

```swift
var names = ["Tim", "John", "Jack", "Chris"]
names.append("David") // ["Tim", "John", "Jack", "Chris", "David"] (O(1))

var numbers = [1, 2, 3]
// O(m), where m is the number of elements
numbers.append(contentsOf: 10...12) // [1, 2, 3, 10, 11, 12]
````

---

## Insert

Inserting at a specific index requires shifting elements, making it O(n).
If inserting at the end, it is equivalent to append (O(1)).

```swift
var ids = [1, 2, 3, 4, 5]

// Insert single element
ids.insert(10, at: 2) // [1, 2, 10, 3, 4, 5] (O(n))
ids.insert(20, at: ids.endIndex) // [1, 2, 10, 3, 4, 5, 20] (O(1))

// Insert sequence of elements
ids.insert(contentsOf: 10...15, at: 4) // O(n + m)
ids.insert(contentsOf: 20...25, at: ids.endIndex) // O(m)
```

---

## Replace Subrange

Replaces a specified range of elements with elements from another collection.

* **Complexity:** O(n + m), where n = array length, m = newElements count.
* Appending at the end is equivalent to `append(contentsOf:)` with O(m).

---

### Replace with Repeated Values

```swift
var nums = [10, 20, 30, 40, 50]

// Remove indices 1...4 and replace with five 2's
nums.replaceSubrange(1...4, with: repeatElement(2, count: 5)) // [10, 2, 2, 2, 2, 2]
```

---

### Replace with an Array

```swift
// Replace indices 1...3 with [10, 20]
nums.replaceSubrange(1...3, with: [10, 20]) // [10, 10, 20, 2, 2]
```

---

### Replace with a Range Collection

```swift
// Replace indices 1...3 with 100...102
nums.replaceSubrange(1...3, with: 100...102) // [10, 100, 101, 102, 2]
```

---

### Replace with Different Number of Elements

```swift
var nameOfUsers = ["Tim", "John", "Alex", "Tom"]

// Replace indices 1...2 with five "Kevin" entries (more elements)
nameOfUsers.replaceSubrange(1...2, with: repeatElement("Kevin", count: 5)) 
// ["Tim", "Kevin", "Kevin", "Kevin", "Kevin", "Kevin", "Tom"]

// Replace indices 1...3 with three new names (equal elements)
nameOfUsers.replaceSubrange(1...3, with: ["Alex", "Matt", "Matthew"]) 
// ["Tim", "Alex", "Matt", "Matthew", "Kevin", "Kevin", "Tom"]
```

---

### Zero-Length Range or Collection

#### Using a zero-length RANGE

Inserts elements at the startIndex of the empty range. Prefer `.insert(contentsOf:at:)` for clarity.

```swift
var numbers1 = [10, 20, 30, 40, 50]
numbers1.replaceSubrange(2..<2, with: [15, 17])
// [10, 20, 15, 17, 30, 40, 50]
```

#### Using a zero-length COLLECTION

Removes the range without replacement. Prefer `.removeSubrange(_:)` for clarity.

```swift
numbers1.replaceSubrange(3...4, with: [])
// [10, 20, 15, 40, 50]
```


