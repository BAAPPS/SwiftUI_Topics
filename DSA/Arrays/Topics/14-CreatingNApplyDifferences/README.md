# Swift CollectionDifference Reference

This reference covers Swift’s **CollectionDifference APIs**:  
- `difference(from:)`  
- `difference(from:by:)`  
- `applying(_:)`  

These APIs allow you to compute differences between collections, apply those differences to reconstruct arrays, and track changes efficiently. They are useful for **data syncing, UI updates, patching, and diff-based algorithms**.

---

## Table of Contents

1. [Overview](#overview)  
2. [applying(_:)](#applying)  
3. [difference(from:)](#differencefrom)  
4. [difference(from:by:)](#differencefromby)  
5. [Tracking Changes Example](#tracking-changes-example)  
6. [Summary](#summary)  

---

## Overview

`CollectionDifference` represents the differences between two collections — the elements removed or inserted to go from one collection to another.  
You can:  
1. Compute differences between arrays.  
2. Apply differences to reconstruct a new collection.  
3. Customize equality checks using a predicate.  

---

## applying(_:)

**Definition:**  
Applies a `CollectionDifference` to a collection to produce a **new array reflecting the changes**.

**Complexity:**  
O(n + c), where `n` is the count of the collection and `c` is the number of changes.

---

### Example 1 — Simple String Array

```swift
let oldArray = ["A", "B", "C"]
let newArray = ["A", "C", "D"]

// Compute the difference
let difference = newArray.difference(from: oldArray)

// Apply the difference
if let updated = oldArray.applying(difference) {
    print(updated)
}
// Output: ["A", "C", "D"]
````

**Explanation:**

* `"B"` is removed
* `"D"` is inserted
* `applying(_:)` reconstructs the new array.

---

### Example 2 — Numeric Array

```swift
let numArrayOld: [Int] = [1, 2, 3, 4, 5]
let numArrayNew: [Int] = [1, 3, 4, 6, 5]

let numDifference = numArrayNew.difference(from: numArrayOld)

if let numUpdated = numArrayOld.applying(numDifference) {
    print("Reconstructed:", numUpdated)
}
// Output: [1, 3, 4, 6, 5]
```

---

## difference(from:)

**Definition:**
Returns the difference needed to produce a collection’s elements from another collection.

**Complexity:**
Worst-case O(n * m), where n = `self.count` and m = `other.count`. Faster when collections share elements or elements conform to `Hashable`.

---

### Example — Reverse Difference

```swift
let oldArrayDifference = oldArray.difference(from: newArray)
print(oldArrayDifference)
```

**Explanation:**

* Produces a `CollectionDifference` describing what changes are needed to transform `newArray` → `oldArray`.

---

## difference(from:by:)

**Definition:**
Returns the difference needed to produce a collection’s elements from another collection using a **custom equivalence predicate**.

**Complexity:**
Worst-case O(n * m), faster when collections share elements.

---

### Example — Custom Object Comparison

```swift
struct User: CustomStringConvertible {
    let id: Int
    let name: String
    
    var description: String { "(\(id), \(name))" }
}

let oldUsers = [
    User(id: 1, name: "Alice"),
    User(id: 2, name: "Bob"),
    User(id: 3, name: "Charlie")
]

let newUsers = [
    User(id: 1, name: "Alice A."), // name changed
    User(id: 3, name: "Charlie"),
    User(id: 4, name: "Diana")
]

// Compare users by id only
let diff = newUsers.difference(from: oldUsers) { $0.id == $1.id }

// Inspect changes
for change in diff {
    switch change {
    case .insert(let offset, let element, _):
        print("Inserted:", element.name, "at index", offset)
    case .remove(let offset, let element, _):
        print("Removed:", element.name, "at index", offset)
    }
}
```

**Output:**

```
Removed: Bob at index 1
Inserted: Diana at index 2
```

**Explanation:**

* `Bob` is removed
* `Diana` is inserted
* `Alice`’s name change is ignored because comparison is by `id`.

---

### Applying the Difference

```swift
if let updated = oldUsers.applying(diff) {
    print("Updated list:", updated.map(\.name))
}
// Output: ["Alice A.", "Charlie", "Diana"]
```

---

## Tracking Changes Example — Username Updates

```swift
let newUsers2 = [
    User(id: 1, name: "Alice A."),
    User(id: 2, name: "Bob"),
    User(id: 3, name: "Charlie"),
    User(id: 4, name: "Diana")
]

// Compare users by name
let userNameChanged = newUsers2.difference(from: oldUsers) { $0.name == $1.name }

// Inspect username changes
for change in userNameChanged {
    switch change {
    case .remove(_, let element, _):
        print("Old name removed:", element.name)
    case .insert(_, let element, _):
        print("New name inserted:", element.name)
    }
}

// Apply the changes
if let updatedUsername = oldUsers.applying(userNameChanged) {
    print("Username updated:", updatedUsername.map(\.name))
}
```

**Output:**

```
Old name removed: Alice
New name inserted: Alice A.
Username updated: ["Alice A.", "Bob", "Charlie", "Diana"]
```

**Explanation:**

* Tracks username changes as **remove + insert**
* Reconstructs the updated user list with new names applied

---

## Summary 

| Method                 | Description                                   | Complexity |
| ---------------------- | --------------------------------------------- | ---------- |
| `difference(from:)`    | Compute differences between arrays            | O(n * m)   |
| `difference(from:by:)` | Compute differences using custom predicate    | O(n * m)   |
| `applying(_:)`         | Apply a difference to reconstruct a new array | O(n + c)   |

* `applying(_:)` returns **optional** — returns `nil` if the diff cannot be applied.
* Use `inverse()` on a `CollectionDifference` to **undo changes**.
* Ideal for: **data syncing**, **UI diffing**, **patch-based algorithms**, and **tracking property changes**.
* Use `difference(from:by:)` when comparing objects **by specific fields** (like IDs, usernames, or other identifiers).

