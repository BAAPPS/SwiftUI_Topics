# Accessing Elements in Array

This playground demonstrates various ways to **access and manipulate elements in Swift arrays**, including:

- Subscript access and modification  
- Array slicing and `ArraySlice` handling  
- Safe access to first and last elements  
- Random element selection with default and custom generators  

---

## Table of Contents

1. [Subscript](#subscript)  
2. [Element Slicing](#element-slicing)  
3. [Finding Element Index After Slicing](#finding-element-index-after-slicing)  
4. [Safe Access of ArraySlice](#safe-access-of-arrayslice)  
5. [First and Last Elements](#first-and-last-elements)  
6. [Random Elements](#random-elements)  
7. [Key Points](#key-points)

---

## Subscript

```swift
var codingLanguages = ["Java", "JavaScript", "Python", "C#", "C++"]

// Access element at index 1 (O(1))
let element1 = codingLanguages[1] // "JavaScript"

// Modify element at index 1
codingLanguages[1] = "Swift"
````

* **Subscript access** allows you to read or modify elements at a specific index in **O(1)** time for arrays.

---

## Element Slicing

```swift
// Slice from index 2 to the end (explicit)
let slicedLanguages = codingLanguages[2..<codingLanguages.endIndex] // ["Python", "C#", "C++"]

// Slice using shortcut (from index 3 to end)
let slicedLanguagesShortcut = codingLanguages[3...] // ["C#", "C++"]

// Convert ArraySlice back to Array if needed
let slicedLanguagesArray = Array(slicedLanguages) // ["Python", "C#", "C++"]
```

* Slicing returns an **`ArraySlice`**, which preserves the **original indices**.
* Convert to `Array` if you need **zero-based indexing**.

---

## Finding Element Index After Slicing

```swift
if let indexOfSwift = codingLanguages.firstIndex(of: "Swift") {
    print("Index of Swift: \(indexOfSwift)")
}
```

* `firstIndex(of:)` searches for an element and returns its index or `nil` if not found.
* Complexity: **O(n)** for arrays.

---

## Safe Access of ArraySlice

```swift
// Using startIndex to safely access first element
let firstElementInSlice = slicedLanguagesShortcut[slicedLanguagesShortcut.startIndex]

// Iterating safely over a slice
for i in slicedLanguagesShortcut.startIndex..<slicedLanguagesShortcut.endIndex {
    print("\(i): \(slicedLanguagesShortcut[i])")
}

// Optional: convert to Array for zero-based indexing
let normalArray = Array(slicedLanguagesShortcut)
```

* **Important:** `ArraySlice` preserves original indices; do not assume `0` is the first index.
* Always use `.startIndex` and `.endIndex` for safe access.

---

## First and Last Elements

```swift
let numbers = [1, 2, 3, 4, 5]

// Safe access to first element
if let first = numbers.first {
    print(first)
}

// Safe access to last element
let names = ["Alice", "Bob", "Charlie"]
if let last = names.last {
    print(last)
}
```

* Both `.first` and `.last` return optionals (`nil` if the array is empty).
* Complexity: **O(1)** for arrays.

---

## Random Elements

```swift
// Random element using default generator
let randomName = names.randomElement() ?? "Unknown"

// Random element using a custom generator
struct MyGenerator: RandomNumberGenerator {
    var state: UInt64 = 42
    mutating func next() -> UInt64 {
        state = 6364136223846793005 &* state &+ 1
        return state
    }
}

var myGen = MyGenerator()
let deterministicRandomName = names.randomElement(using: &myGen) ?? "Unknown"

// Multiple picks using the same generator
for _ in 1...5 {
    if let name = names.randomElement(using: &myGen) {
        print(name)
    }
}
```

* `.randomElement()` → uses the system generator, sufficient for most everyday use.
* `.randomElement(using:)` → allows **custom or deterministic randomness**.
* Complexity: **O(1)** for arrays, **O(n)** for collections without random access.

---

### Key Points

1. Use **subscripts** for O(1) element access.
2. **Array slicing** returns `ArraySlice` with preserved indices.
3. Use **`.startIndex`** and **`.endIndex`** to safely access slices.
4. `.first` and `.last` provide safe access to ends of the array.
5. `.randomElement()` is usually sufficient; custom generators are optional for deterministic behavior.

