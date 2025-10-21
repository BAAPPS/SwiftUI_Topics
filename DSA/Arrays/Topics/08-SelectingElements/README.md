# Swift Sequences & Collections Reference: Selecting Elements

A concise reference guide for selecting elements from Swift collections using `prefix`, `suffix`, and related methods. Includes examples, sliding windows, top-K selection, and functional transformations.

---

## Table of Contents

* [Prefix](#prefix)
  * [prefix(_:)](#prefix)
  * [Top-K Example](#top-k-example)
  * [prefix(through:)](#prefixthrough)
  * [prefix(upTo:)](#prefixupto)
  * [prefix(while:)](#prefixwhile)
* [Suffix](#suffix)
  * [suffix(_:)](#suffix)
  * [suffix(from:)](#suffixfrom)
* [Sliding Window Examples](#sliding-window-examples)
* [Functional Examples](#functional-examples)

---

## Prefix

### `prefix(_:)`

Returns a subsequence containing the first `k` elements of a collection.  
- **Complexity:** O(1) for RandomAccessCollection, O(k) otherwise.

```swift
let usernames: [String] = ["alice", "bob", "chris", "david", "eve"]
let maxKUsernameLength: Int = 3

let usernamesPrefix = usernames.prefix(maxKUsernameLength)
print("Prefix of usernames:", usernamesPrefix) // ["alice", "bob", "chris"]
````

---

### Top-K Example

#### Top-K Usernames

```swift
let usernames: [String] = ["alice", "bob", "chris", "david", "eve"]
// Descending order
let sortedUsernames = usernames.sorted(by: >)
let top3Users = sortedUsernames.prefix(3)
print("Top 3 usernames:", top3Users) // ["eve", "david", "chris"]
```

#### Top-K Numbers

```swift
let numbers = [2, 5, 1, 8, 3, 7]
// Ascending order
let top3Numbers = numbers.sorted(by: <).prefix(3)
print("Top 3 numbers:", top3Numbers) // [1, 2, 3]
```

---

### `prefix(through:)`

Returns a subsequence from the start of the collection **through the specified index**, inclusive.

* **Complexity:** O(1) for RandomAccessCollection.

```swift
let numbers2 = [3, 5, 1, 8, 3, 7, 15, 10, 22, 20]

if let indexOf15 = numbers2.firstIndex(of: 15) {
    let window = numbers2.prefix(through: indexOf15)
    print("Window up to 15:", window) // [3, 5, 1, 8, 3, 7, 15]
    
    let windowSum = window.reduce(0, +)
    print("Sum of window elements:", windowSum) // 42
}
```

**Sliding window using `prefix(through:)`:**

```swift
if let windowIndex = numbers2.firstIndex(of: 15) {
    let window = numbers2.prefix(through: windowIndex)
    let windowSize = window.count

    for i in 0...(numbers2.count - windowSize) {
        let currentWindow = numbers2[i..<(i + windowSize)]
        let windowSum = currentWindow.reduce(0, +)
        print("Window \(currentWindow): sum = \(windowSum)")
    }
}
```

---

### `prefix(upTo:)`

Returns a subsequence from the start of the collection **up to, but not including**, the specified index.

```swift
if let windowIndex = numbers2.firstIndex(of: 15) {
    let window = numbers2.prefix(upTo: windowIndex)
    let windowSize = window.count
    print("Window up to (excluding) 15:", window)
}
```

---

### `prefix(while:)`

Returns a subsequence containing elements **from the start until the predicate fails**. Stops at the first false.

```swift
let greaterThanOrEqual = numbers2.prefix(while: { $0 >= 3 })
print(greaterThanOrEqual)

let window = numbers2.prefix(while: { $0 < 10 })
let windowTotal = window.reduce(0, +)
print(window)       // [3, 5, 1, 8, 3, 7]
print(windowTotal)  // 27
```

**Counting consecutive `true` values:**

```swift
let results = [true, true, true, false, true, false]
let consecutiveSuccesses = results.prefix(while: { $0 == true })
print(consecutiveSuccesses.count) // 3
```

**Consecutive ones example:**

```swift
let consecutiveOnes = [1, 0, 1, 1, 0, 1, 1, 1]
let consecutiveOnesSuccesses = consecutiveOnes.prefix(while: { $0 == 1 })
print(consecutiveOnesSuccesses.count) // 1 (only from start)
```

---

## Suffix

### `suffix(_:)`

Returns a subsequence containing the **last `k` elements**.

```swift
let last3Numbers = numbers.sorted(by: <).suffix(3)
print("Last 3 numbers:", last3Numbers) // [5, 7, 8]
```

### `suffix(from:)`

Returns a subsequence from the specified index to the end.

```swift
if let windowIndex = numbers2.firstIndex(of: 15) {
    let window = numbers2.suffix(from: windowIndex)
    let windowSize = window.count
    print("Window from 15 to end:", window)

    // Sliding window backwards
    for i in stride(from: numbers2.count - windowSize, through: 0, by: -1) {
        let currentWindow = numbers2[i..<(i + windowSize)]
        let windowSum = currentWindow.reduce(0, +)
        print("Window \(currentWindow): sum = \(windowSum)")
    }
}
```

---

## Sliding Window Examples

* **Forward sliding:**

```swift
for i in 0...(numbers2.count - windowSize) {
    let currentWindow = numbers2[i..<(i + windowSize)]
    let windowSum = currentWindow.reduce(0, +)
    print("Window \(currentWindow): sum = \(windowSum)")
}
```

* **Backward sliding:**

```swift
for i in stride(from: numbers2.count - windowSize, through: 0, by: -1) {
    let currentWindow = numbers2[i..<(i + windowSize)]
    let windowSum = currentWindow.reduce(0, +)
    print("Window \(currentWindow): sum = \(windowSum)")
}
```

---

## Functional Examples

* **Map elements in a window:**

```swift
if let indexOf15 = numbers2.firstIndex(of: 15) {
    let doubledWindow = numbers2.prefix(through: indexOf15).map { $0 * 2 }
    print("Doubled window:", doubledWindow) // [6, 10, 2, 16, 6, 14, 30]
}
```

* **Reduce sums in a window:**

```swift
let windowSum = numbers2.prefix(through: windowIndex).reduce(0, +)
```

