# Swift Element-Finding Methods Reference

A concise reference guide for Swift methods used to find or locate elements in sequences and collections. Includes examples, return types, and complexity notes. Perfect for learning, reviewing, or quick lookup while coding in Swift.

---

## Table of Contents

- [contains(_:)](#contains)
- [contains(where:)](#containswhere)
- [allSatisfy(_:)](#allsatisfy)
- [first(where:)](#firstwhere)
- [firstIndex(of:)](#firstindexof)
- [last(where:)](#lastwhere)
- [lastIndex(of:)](#lastindexof)
- [lastIndex(where:)](#lastindexwhere)
- [min()](#min)
- [min(by:)](#minby)
- [max()](#max)
- [max(by:)](#maxby)

---

## contains(_:)

Checks if a sequence contains a given element and returns a Boolean value.  
**Complexity:** O(n)  

```swift
let bannedIDs = [1120, 1133, 2200, 3300]
print(bannedIDs.contains(3300)) // true
````

---

## contains(where:)

Checks if a sequence contains an element that satisfies the given predicate.
Returns `Bool`.
**Complexity:** O(n)

```swift
let names = ["Alex", "Tom", "Thomas"]
let hasAlex = names.contains { $0 == "Alex" }
```

---

## allSatisfy(_:)

Checks if every element in a sequence satisfies a predicate.
Returns `Bool`.
**Complexity:** O(n)

```swift
let requiredNames = ["Alex", "Tom"]
let hasAll = requiredNames.allSatisfy { names.contains($0) }
```

---

## first(where:)

Returns the first element that satisfies a given predicate.
Returns `nil` if not found.
**Complexity:** O(n)

```swift
let users = ["Bob", "Alice", "Charlie"]
if let startsWithA = users.first(where: { $0.hasPrefix("A") }) {
    print(startsWithA)
}
```

---

## firstIndex(of:)

Returns the first index of a specified value.
Returns `nil` if not found.
**Complexity:** O(n)

```swift
var usernames = ["Alice", "Bob", "Charlie"]
if let indexOfBob = usernames.firstIndex(of: "Bob") {
    usernames[indexOfBob] = "Bobby"
}
```

---

## last(where:)

Returns the last element satisfying a predicate.
Returns `nil` if not found.
**Complexity:** O(n)

```swift
if let lastBob = usernames.last(where: { $0 == "Bob" }) {
    print(lastBob)
}
```

---

## lastIndex(of:)

Returns the last index of a specified value.
Returns `nil` if not found.
**Complexity:** O(n)

```swift
if let indexOfAlice = usernames.lastIndex(of: "Alice") {
    usernames[indexOfAlice] = "Alex"
}
```

---

## lastIndex(where:)

Returns the last index satisfying a predicate.
Returns `nil` if not found.
**Complexity:** O(n)

```swift
if let i = usernames.lastIndex(where: { $0.hasSuffix("w") }) {
    print(usernames[i])
}
```

---

## min()

Returns the minimum element in a sequence.
Returns `nil` if sequence is empty.
**Complexity:** O(n)

```swift
let heights = [7.5, 5.7, 4.3, 8.5]
if let lowest = heights.min() { print(lowest) }
```

---

## min(by:)

Returns the minimum element using a custom comparator.
Returns `nil` if sequence is empty.
**Complexity:** O(n)

```swift
let ratings: [String: Int] = ["Alex": 5, "Tom": 6]
if let lowest = ratings.min(by: { $0.value < $1.value }) { print(lowest) }
```

---

## max()

Returns the maximum element in a sequence.
Returns `nil` if sequence is empty.
**Complexity:** O(n)

```swift
if let highest = heights.max() { print(highest) }
```

---

## max(by:)

Returns the maximum element using a custom comparator.
Returns `nil` if sequence is empty.
**Complexity:** O(n)

```swift
if let highest = ratings.max(by: { $0.value < $1.value }) { print(highest) }
```

---

## Notes

* Most of these methods have **O(n)** complexity because they may need to iterate through the entire collection.
* Methods returning an optional (`first(where:)`, `lastIndex(where:)`, `min()`, etc.) return `nil` when no matching element is found or the sequence is empty.
* Use `contains` and `allSatisfy` for Boolean checks, and `first` / `last` methods when you need the element or its index.
