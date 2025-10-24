# Swift Reordering Reference

---

## Table of Contents

1. [sort()](#sort)
2. [sorted()](#sorted)
3. [Reversing Collections](#reversing-collections)
   3.1 [reverse()](#reverse)
   3.2 [reversed()](#reversed)
4. [Shuffling Collections](#shuffling-collections)
   4.1 [shuffle()](#shuffle)
   4.2 [shuffle(using:)](#shuffleusing)
   4.3 [shuffled()](#shuffled)
   4.4 [shuffled(using:)](#shuffledusing)
5. [Partitioning Collections](#partitioning-collections)
6. [Swapping Elements](#swapping-elements)
7. [Advanced Sorting Examples](#advanced-sorting-examples)
8. [Notes & Best Practices](#notes--best-practices)

---

## sort()

Sorts the collection **in place**.
Complexity: O(n log n)

```swift
var students = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]

// Ascending
students.sort()
print("Ascending:", students)

// Descending
students.sort(by: >)
print("Descending:", students)
```

---

## sorted()

Returns a **new sorted array**, original unchanged.
Complexity: O(n log n)

```swift
let ascendingStudents = students.sorted()
let descendingStudents = students.sorted(by: >)
```

---

## Reversing Collections

### reverse()

Reverses the collection **in place**. O(n)

```swift
var chars: [Character] = ["C","a","f","é"]
chars.reverse()
print(chars) // ["é","f","a","C"]

var numbers = [1,2,3,4,5]
numbers.reverse()
print(numbers) // [5,4,3,2,1]
```

---

### reversed()

Returns a **view** of the collection in reverse order. Does **not mutate**. O(1) for arrays.

```swift
let word = "Backwards"
let reversedWord = String(word.reversed())
print(reversedWord) // "sdrawkcaB"

let nums = [1,2,3,4,5]
let doubledReversed = nums.reversed().map { $0 * 2 }
print(doubledReversed) // [10,8,6,4,2]
```

---

## Shuffling Collections

### shuffle()

Shuffles **in place**.

```swift
var names = ["Alejandro","Camila","Diego"]
names.shuffle()
```

### shuffle(using:)

Shuffles in place with a **custom random generator**.

```swift
var generator = SystemRandomNumberGenerator()
numbers.shuffle(using: &generator)
```

### shuffled()

Returns a new shuffled array.

```swift
let numbers3 = numbers.shuffled()
```

### shuffled(using:)

Returns a new shuffled array using a custom generator.

```swift
let numbers4 = numbers.shuffled(using: &generator)
```

---

## Partitioning Collections

`partition(by:)` reorders so elements **matching the predicate come first**.

```swift
var nums = [1,2,3,4,5,6,7,8,9,10]
let pivot = nums.partition { $0 % 2 == 0 }
print(nums)   // Even numbers first
print(pivot)  // Index of first non-even element
```

---

## Swapping Elements

`swapAt(_:_)` swaps elements **in place**.

```swift
var letters = ["a","b","c","d","e"]
letters.swapAt(0, letters.count - 1)
print(letters) // ["e","b","c","d","a"]

// Reverse using swapAt
for i in 0..<letters.count/2 {
    letters.swapAt(i, letters.count - 1 - i)
}
print(letters) // ["a","b","c","d","e"] reversed
```

---

## Advanced Sorting Examples

```swift
struct Student { let name: String; let age: Int; let grade: Double }

let studentsArray = [
    Student(name: "Alice", age: 22, grade: 88.5),
    Student(name: "Bob", age: 20, grade: 91.0),
    Student(name: "Charlie", age: 22, grade: 91.0)
]

// Sort by single property
let sortByAge = studentsArray.sorted { $0.age < $1.age }

// Sort by multiple properties
let sortedByGradeThenName = studentsArray.sorted {
    if $0.grade != $1.grade { return $0.grade > $1.grade }
    else { return $0.name < $1.name }
}

// Using tuple for compact multiple key sort
let sortedByAgeGradeTuple = studentsArray.sorted {
    ($0.age, -$0.grade) < ($1.age, -$1.grade)
}
```

---

## Notes & Best Practices

* `sort()` mutates the collection; `sorted()` returns a new one.
* `reverse()` mutates; `reversed()` is a view.
* `shuffle()`/`shuffled()` are random; use custom generator for reproducibility.
* `partition(by:)` is **not stable**; order within partitions is not guaranteed.
* `swapAt()` is ideal for in-place reordering, reversing, and shuffling.
* For dictionaries: keys are unordered; sort into an array if order matters.

