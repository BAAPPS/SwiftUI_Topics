# Swift `split()` and `joined()` Reference

A concise reference covering Swift’s `split()` and `joined()` methods from the Swift Standard Library.
Includes explanations, examples, and complexity details.

---

## Table of Contents

1. [Overview](#overview)
2. [split(separator:maxSplits:omittingEmptySubsequences:)](#splitseparatormaxsplitsomittingemptysubsequences)
3. [split(maxSplits:omittingEmptySubsequences:whereSeparator:)](#splitmaxsplitsomittingemptysubsequenceswhereseparator)
4. [joined()](#joined)
5. [joined(separator:)](#joinedseparator)
6. [Summary](#summary)

---

## Overview

These examples demonstrate how to:

* Split collections (like `String`) into subsequences using a separator or a predicate.
* Join nested collections (like `[[Int]]` or `[String]`) into a single sequence or string.

Each method includes **runtime complexity** and **example output** for quick learning.

---

## split(separator:maxSplits:omittingEmptySubsequences:)

**Definition:**
Splits a collection into subsequences, separated by a given element.

**Complexity:**
O(n), where *n* is the length of the collection.

```swift
let goal = "To get good at Swift,  I will practice and practice everyday"

let splitGoal = goal.split(separator: " ")
print(splitGoal)
// ["To", "get", "good", "at", "Swift,", "I", "will", "practice", "and", "practice", "everyday"]

let splitGoalMaxSplits = goal.split(separator: " ", maxSplits: 2)
print(splitGoalMaxSplits)
// ["To", "get", "good at Swift, I will practice and practice everyday"]

let splitGoalOmit = goal.split(separator: " ", omittingEmptySubsequences: false)
print(splitGoalOmit)
// ["To", "get", "good", "at", "Swift,", "", "I", "will", "practice", "and", "practice", "everyday"]
```

---

## split(maxSplits:omittingEmptySubsequences:whereSeparator:)

**Definition:**
Splits a collection into subsequences around elements that satisfy a predicate.

**Complexity:**
O(n), where *n* is the length of the collection.

```swift
print(goal.split(whereSeparator: { $0 == "," }))
// ["To get good at Swift", "  I will practice and practice everyday"]
```

---

## joined()

**Definition:**
Concatenates the elements of a sequence of sequences into a single sequence.

**Example:**

```swift
let ranges = [0..<4, 7..<10, 12..<17]

for index in ranges.joined() where index % 2 == 0 {
    print(index, terminator: " ")
}
// Output: 0 2 8 10 12 14 16
```

---

## joined(separator:)

**Definition:**
Concatenates the elements of a sequence of sequences, inserting a separator between each.

**Example 1: Joining Strings**

```swift
let cast = ["Vivien", "Marlon", "Kim", "Karl"]
let list = cast.joined(separator: ", ")
print(list)
// "Vivien, Marlon, Kim, Karl"
```

**Example 2: Joining Arrays of Integers**

```swift
let nestedNumbers = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
let joined = nestedNumbers.joined(separator: [-1])
print(Array(joined))
// [1, 2, 3, -1, 4, 5, 6, -1, 7, 8, 9]
```

---

## Summary

| Method                   | Description                            | Complexity |
| ------------------------ | -------------------------------------- | ---------- |
| `split(separator:)`      | Splits around a given element          | O(n)       |
| `split(whereSeparator:)` | Splits where a predicate returns true  | O(n)       |
| `joined()`               | Concatenates nested sequences          | O(n)       |
| `joined(separator:)`     | Concatenates with a separator inserted | O(n)       |

- Use `split()` for dividing collections into parts, and `joined()` for flattening or merging sequences — both are fundamental for working with strings, arrays, and ranges in Swift.


