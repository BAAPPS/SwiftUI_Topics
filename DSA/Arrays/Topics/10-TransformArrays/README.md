# Transforming Arrays in Swift

This playground is a **reference for transforming arrays** using Swift’s powerful sequence methods like `flatMap`, `compactMap`, `reduce`, and `reduce(into:)`. It includes practical examples such as sliding windows, frequency counts, and grouping.

---

## Table of Contents

1. [flatMap](#flatmap)
2. [compactMap](#compactmap)
3. [reduce](#reduce)

   * Sliding Window Sums
   
4. [reduce(into:)](#reduceinto)

   * Frequency Counts
   * Grouping Elements
   * Transform + Accumulate
   * Transform + Aggregate
   * Dictionary from Two Arrays
   * Flattening Nested Arrays
   * Counting Pairs of Elements
   * Grouping by Computed Key
   * Nested Grouping

---

## flatMap

`flatMap` concatenates results of a transformation into a single array.

```swift
let numbersArrays = [[1], [2], [3], [4]]
let numbersArrayFlatted = numbersArrays.flatMap { $0 }
print(numbersArrayFlatted) // [1, 2, 3, 4]

let numbersArrayRepeated = numbersArrayFlatted.flatMap { Array(repeating: $0, count: $0) }
print(numbersArrayRepeated) // [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
```

**Complexity:** O(n + m), where n = original array length, m = result length.

---

## compactMap

`compactMap` transforms elements and filters out nil values.

```swift
let usernamesArrayDict: [[String: Any]] = [
    ["id": 1, "username": "Tim"],
    ["id": 2, "username": "Timmy"],
    ["id": 3, "username": "Alex"],
    ["id": 4, "username": "Kevin"]
]

let usernames = usernamesArrayDict.compactMap { $0["username"] as? String }
print(usernames) // ["Tim", "Timmy", "Alex", "Kevin"]
```

**Complexity:** O(n)

---

## reduce

`reduce` combines elements of a sequence using a closure.

### Sliding Window Sums (Naive)

```swift
func slidingWindowSum(_ array: [Int], _ windowSize: Int) -> [Int] { ... }
```

**Optimized Sliding Window:**

```swift
func slidingWindowOptimizedSum(_ array: [Int], _ windowSize: Int) -> [Int] { ... }
```

**Custom Step Sliding Window:**

```swift
func slidingWindowSumsStep(_ array:[Int], windowSize: Int, step: Int) -> [Int] { ... }
```

**Complexity:**

* Naive: O(n * k), k = window size
* Optimized: O(n)

---

## reduce(into:)

`reduce(into:)` is more efficient for building collections, avoiding repeated allocations.

### Frequency Counts

```swift
let letters = "abracadabra"
let letterCount = letters.reduce(into: [Character: Int]()) { counts, letter in
    counts[letter, default: 0] += 1
}
print(letterCount)
```

```swift
let numbers = [1, 2, 3, 4, 5, 2, 3, 1]
let numberFreq = numbers.reduce(into: [Int: Int]()) { counts, num in
    counts[num, default: 0] += 1
}
print(numberFreq)
```

### Grouping Elements

```swift
struct User { let name: String; let age: Int }
let users = [User(name: "Alice", age: 20), User(name: "Bob", age: 25), User(name: "Charlie", age: 20)]

let groupedByAge = users.reduce(into: [Int: [String]]()) { dict, user in
    dict[user.age, default: []].append(user.name)
}
print(groupedByAge)
```

### Transform + Accumulate

```swift
let transformed = numbers.reduce(into: []) { arr, n in
    if n % 2 == 0 { arr.append(n * 10) }
}
print(transformed)
```

### Transform + Aggregate

```swift
let squares = numbers.reduce(into: [Int:Int]()) { dict, num in
    dict[num] = num * num
}
print(squares)
```

### Dictionary from Two Arrays

```swift
let keys = ["a", "b", "c"]
let values = [1, 2, 3]
let dict = zip(keys, values).reduce(into: [String:Int]()) { d, pair in
    let (key, value) = pair
    d[key] = value
}
print(dict)
```

### Flattening Nested Arrays

```swift
let nested = [[1, 2], [3, 4], [5]]
let flat = nested.reduce(into: [Int]()) { result, arr in
    result.append(contentsOf: arr)
}
print(flat)
```

### Counting Pairs of Elements

```swift
struct WordPair: Hashable, CustomStringConvertible {
    let word: String
    let length: Int
    var description: String { "(\(word), \(length))" }
}

let words = ["apple", "bat", "car", "apple", "bat"]
let pairCounts = words.reduce(into: [WordPair:Int]()) { counts, word in
    let pair = WordPair(word: word, length: word.count)
    counts[pair, default: 0] += 1
}
print(pairCounts)
```

### Grouping by Computed Key

```swift
let nums1 = [1, 2, 3, 4, 5, 6]
let groupedOddEven = nums1.reduce(into: [String: [Int]]()) { dict, num in
    let key = (num % 2 == 0) ? "even" : "odd"
    dict[key, default: []].append(num)
}
print(groupedOddEven)
```

### Nested Grouping by First Letter + Length

```swift
struct FirstLetterLength: Hashable, CustomStringConvertible {
    let first: String
    let length: Int
    var description: String { "(\(first), \(length))" }
}

let words2 = ["apple", "bat", "banana", "ball", "ant"]
let nestedGrouped = words2.reduce(into: [FirstLetterLength: [String]]()) { dict, word in
    let key = FirstLetterLength(first: String(word.first!), length: word.count)
    dict[key, default: []].append(word)
}
print(nestedGrouped)
```

---

## Best Practices

1. Prefer `reduce(into:)` when building collections to avoid unnecessary array/dictionary copies.
2. Use type annotations to avoid `[AnyHashable: Any]` issues.
3. Keep sliding windows **O(n)** when possible.
4. Flatten, map, and filter arrays before applying transformations for cleaner pipelines.

