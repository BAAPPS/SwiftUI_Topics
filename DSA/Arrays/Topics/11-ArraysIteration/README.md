
# Swift Iterating 

## Table of Contents

1. [forEach](#foreach)
2. [enumerated](#enumerated)
3. [zip](#zip)
4. [Examples](#examples)

   * [Arrays](#arrays)
   * [Dictionaries](#dictionaries)
   * [Sets](#sets)
   * [Nested Arrays](#nested-arrays)
   * [Filtering with forEach](#filtering-with-foreach)
   

---

## forEach

`forEach` iterates over each element in a sequence (`Array`, `Dictionary`, `Set`, etc.) and executes a closure for every element in order.

* Similar to a `for-in` loop
* Cannot use `break` or `continue`
* Ideal for side-effect operations (printing, appending, updating)

```swift
let numberWords = ["one", "two", "three"]

// Using for-in loop
for word in numberWords {
    print("For-in loop:", word)
}

// Using forEach
numberWords.forEach { word in
    print("forEach:", word)
}

// Squaring numbers in an array
let numbers: [Int] = [1, 2, 3, 4, 5]
numbers.forEach { num in
    print("Square:", num * num)
}
```

### Dictionaries

```swift
var dict: [Int: Int] = [:]
numbers.forEach { num in
    dict[num] = num + num
}
print("Dict (unordered):", dict)

// Sorted dictionary output
dict.sorted { $0.key < $1.key }.forEach { key, value in
    print("Sorted dict -> \(key): \(value)")
}
```

### Sets

```swift
let letters: Set<Character> = ["a", "b", "c"]
letters.forEach { char in
    print("Letter:", char)
}
```

### Nested Arrays

```swift
let nestedNumbers = [[1, 2], [3, 4], [5]]
nestedNumbers.forEach { subArray in
    subArray.forEach { num in
        print("Nested number:", num)
    }
}
```

### Filtering with forEach

```swift
var evenNumbers: [Int] = []
numbers.forEach { num in
    if num % 2 == 0 {
        evenNumbers.append(num)
    }
}
print("Even numbers:", evenNumbers)
```

---

## enumerated()

Returns a sequence of pairs `(index, element)` where `index` starts at `0`.

```swift
for (index, value) in numbers.enumerated() {
    print("Index \(index) -> Value \(value)")
}

// Using enumerated with forEach
numbers.enumerated().forEach { index, value in
    print("forEach: Index \(index) -> Value \(value)")
}

// Map using index
let multipliedByIndex = numbers.enumerated().map { index, value in
    value * (index + 1)
}
print("Multiplied by (index+1):", multipliedByIndex)
```

**Notes:**

* The `index` from `enumerated()` is only guaranteed to match collection indices for **zero-based, integer-indexed collections** (like `Array` or `ContiguousArray`).
* For other collections, such as `Set` or `Dictionary`, the counter may not match valid indices.

---

## zip

`zip(_:_:)` combines two sequences into a sequence of pairs `(x, y)` and stops at the shortest sequence.

**Why use `zip` over `enumerated`?**

* Use `enumerated()` for a simple counter with Arrays.
* Use `zip(indices, collection)` for **valid indices** when iterating over Sets or Dictionaries, where `enumerated()` indices may not be valid.

```swift
let names: Set = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
var shorterIndices: [Set<String>.Index] = []

for (i, name) in zip(names.indices, names) {
    if name.count <= 5 {
        shorterIndices.append(i)
    }
}

// Access elements safely by index
for i in shorterIndices {
    print(names[i])
}
// Output:
// Sofia
// Mateo
```

**Key points:**

* Returns pairs of `(index, element)` where `index` comes from the actual collection indices.
* Stops at the shorter sequence.
* Safe for non-integer-indexed collections.

---
