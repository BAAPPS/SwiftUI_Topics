import Cocoa

// MARK: - sort()
// Sorts the collection **in place**.
// Complexity: O(n log n), where n is the length of the collection.

var students = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]

// Ascending order (default, using < operator)
students.sort()
print("Ascending:", students) // ["Abena", "Akosua", "Kofi", "Kweku", "Peter"]

// Descending order (using > operator)
students.sort(by: >)
print("Descending:", students) // ["Peter", "Kweku", "Kofi", "Akosua", "Abena"]


// MARK: - sorted()
// Returns a **new sorted array**, leaving original unchanged.
// Complexity: O(n log n)

let ascendingStudents = students.sorted()
print("Sorted Ascending (new array):", ascendingStudents)

let descendingStudents = students.sorted(by: >)
print("Sorted Descending (new array):", descendingStudents)


// MARK: - Sorting dictionary values
var letters = "abcdfegggaaabbcccttt"

// Count frequencies of each letter
let frequencies = letters.reduce(into: [Character: Int]()) { counts, letter in
    counts[letter, default: 0] += 1
}
print("Frequencies:", frequencies)
// Example output: ["t": 3, "f": 1, "a": 4, "c": 4, "b": 3, "e": 1, "d": 1, "g": 3]


// MARK: Sorting dictionary by value

// Descending order (largest → smallest)
let sortedDescending = frequencies.sorted { $0.value > $1.value }
print("Descending by value:", sortedDescending)

// Ascending order (smallest → largest)
let sortedAscending = frequencies.sorted { $0.value < $1.value }
print("Ascending by value:", sortedAscending)


// MARK: Sort by multiple properties (primary + secondary)
// When values are equal, sort by key (alphabetically)
let sortedStable = frequencies.sorted {
    if $0.value != $1.value {
        return $0.value > $1.value   // primary: descending by value
    } else {
        return $0.key < $1.key       // secondary: ascending by key
    }
}
print("Stable descending by value, ascending by key:", sortedStable)

// MARK: - reverse()
// Reverses the elements of the collection in place.
// Modifies the original collection. O(n)
var characters: [Character] = ["C", "a", "f", "é"]
characters.reverse()
print("Reversed in place:", characters) // Output: ["é", "f", "a", "C"]

// Reversing an array of numbers
var numbers = [1, 2, 3, 4, 5]
numbers.reverse()
print("Numbers reversed in place:", numbers) // [5, 4, 3, 2, 1]

// Reverse a portion of an array using slice
var partialNumbers = [10, 20, 30, 40, 50]
partialNumbers[1...3].reverse() // Reverses elements at index 1,2,3
print("Partial reverse:", partialNumbers) // [10, 40, 30, 20, 50]

// Reverse a dictionary’s keys (as array, since dictionary itself is unordered)
let dict: [Int: String] = [1: "One", 2: "Two", 3: "Three"]
let reversedKeys = Array(dict.keys).reversed()
print("Reversed dictionary keys:", Array(reversedKeys)) // e.g. [3, 2, 1]

// MARK: - reversed()
// Returns a view presenting the elements of the collection in reverse order.
// Does NOT modify original collection. O(1) for arrays, O(n) for other sequences
let word = "Backwards"
for char in word.reversed() {
    print(char, terminator: "")
}
print() // Output: sdrawkcaB

let reversedWord = String(word.reversed())
print("Reversed word string:", reversedWord) // sdrawkcaB

// Advanced: reversed() on arrays and then mapping
let nums = [1, 2, 3, 4, 5]
let doubledReversed = nums.reversed().map { $0 * 2 }
print("Doubled after reversing:", doubledReversed) // [10, 8, 6, 4, 2]

// Reversing a sequence of tuples
let pairs = [(1, "one"), (2, "two"), (3, "three")]
let reversedPairs = pairs.reversed()
print("Reversed pairs:")
reversedPairs.forEach { print($0) }
// Output:
// (3, "three")
// (2, "two")
// (1, "one")

// Reversing a range
let range = 1...5
for i in range.reversed() {
    print("Range reversed:", i)
}
// Output: 5, 4, 3, 2, 1

// Reversing a string array with sorting + reverse
var fruits = ["apple", "banana", "cherry", "date"]
fruits.sort()         // ascending
fruits.reverse()      // descending now
print("Fruits sorted then reversed:", fruits) // ["date", "cherry", "banana", "apple"]

// Chaining reversed() with forEach
fruits.reversed().forEach { print("Chained reversed:", $0) }
// Prints from apple -> date



// MARK: - shuffle()
// Shuffles the collection in place
// O(n), where n is the length of the collection.

var names = ["Alejandro", "Camila", "Diego", "Luciana", "Luis", "Sofía"]
names.shuffle()
// names == ["Luis", "Camila", "Luciana", "Sofía", "Alejandro", "Diego"]
print(names)

// MARK: - shuffle(using:)
// Reorders elements randomly using a specific RandomNumberGenerator

// Using the system default generator
print("Original:", numbers)

// Create a mutable instance of the generator
var systemGen = SystemRandomNumberGenerator()
numbers.shuffle(using: &systemGen)
print("Shuffled:", numbers)

// MARK: - shuffled()
// Returns the elements of the sequence, shuffled.
// O(n), where n is the length of the sequence.

let numbers3 = numbers.shuffled()
print("Shuffled (returns new array):", numbers3)

// MARK: - shuffled(using:)
// Returns a new shuffled array using a custom/random generator
// O(n), where n is the length of the sequence.
var generator2 = SystemRandomNumberGenerator()
let numbers4 = numbers.shuffled(using: &generator2)
print("Shuffled with custom generator (returns new array):", numbers4)


// MARK: - partition(by:)
// Reorders the array so that all elements satisfying the predicate come before those that don't
// Returns the index of the first element in the "non-matching" partition
// O(n)

var numbers5 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// Partition even numbers to the front
let pivotIndex = numbers5.partition { $0 % 2 == 0 }

print("Partitioned array:", numbers5)
print("Pivot index (first non-even):", pivotIndex)
// Example output:
// Partitioned array: [2, 4, 6, 8, 10, 7, 5, 1, 3, 9]
// Pivot index: 5

// Partition using a string predicate
var words = ["apple", "banana", "cherry", "date", "fig"]

// Words starting with a vowel first
let firstConsonantIndex = words.partition { word in
    let firstChar = word.first!
    return "aeiou".contains(firstChar.lowercased())
}

print("Partitioned words:", words)
print("Index of first consonant-starting word:", firstConsonantIndex)
// Example output:
// Partitioned words: ["apple", "banana", "cherry", "date", "fig"]
// Index: 1 (depends on the initial order of words)

// MARK: Notes
/*
- The array is mutated in place.
- `partition(by:)` does NOT guarantee relative order among elements in the same partition.
- Use the returned index to know where the partition boundary is.
- If you want a stable version (keeping relative order), use `stablePartition(by:)` from Swift Collections package or implement manually.
*/


// MARK: - swapAt(_:_:)
// Swaps the elements at the given indices in place
// O(1)

var numbers6 = [10, 20, 30, 40, 50]

// Swap first and last element
numbers.swapAt(0, numbers6.count - 1)
print("After swapping first and last:", numbers6)
// Output: [50, 20, 30, 40, 10]

// Swap two middle elements
numbers.swapAt(1, 3)
print("After swapping middle elements:", numbers6)
// Output: [50, 40, 30, 20, 10]

// Swapping in a loop
var lettersSwap = ["a", "b", "c", "d", "e"]

// Reverses the array in place
for i in 0..<lettersSwap.count / 2 {
    // Starts at the last index and moves backward
    lettersSwap.swapAt(i, lettersSwap.count - 1 - i)
}

print("Reversed array in-place using swapAt:", lettersSwap)
// Output: ["e", "d", "c", "b", "a"]

// MARK: Notes
/*
- Only works on collections that are mutable (var).
- Indices must be valid and within bounds; otherwise, it will crash.
- Commonly used for in-place reversing, shuffling, or custom reordering algorithms.
*/



// MARK: - Advanced Reordering Examples

// Sample data
struct Student {
    let name: String
    let age: Int
    let grade: Double
}

let studentsArray = [
    Student(name: "Alice", age: 22, grade: 88.5),
    Student(name: "Bob", age: 20, grade: 91.0),
    Student(name: "Charlie", age: 22, grade: 91.0),
    Student(name: "David", age: 21, grade: 78.0),
    Student(name: "Eva", age: 20, grade: 88.5)
]

// MARK:  Sort by single property
let sortByAge = studentsArray.sorted { $0.age < $1.age }

print("Sorted by age ascending:")
sortByAge.forEach {
    print("\($0.name) - \($0.age)")
}

// MARK: Sort by multiple properties (primary + secondary)

let sortedByGradeThenName = studentsArray.sorted {
    if $0.grade != $1.grade {
        return $0.grade > $1.grade  // primary: grade descending
    } else {
        return $0.name < $1.name    // secondary: name ascending
    }
}

print("\nSorted by grade descending, then name ascending:")

sortedByGradeThenName.forEach { print("\($0.name) - \($0.grade)") }

// MARK:  Using tuple for multiple key sorting (more compact)
let sortedByAgeGradeTuple = studentsArray.sorted {
    ($0.age, -$0.grade) < ($1.age, -$1.grade) // age ascending, grade descending
}
print("\nSorted by age ascending and grade descending (tuple):")
sortedByAgeGradeTuple.forEach { print("\($0.name) - \($0.age) - \($0.grade)") }

// MARK: Reverse a sorted array
let descendingByGrade = studentsArray.sorted { $0.grade < $1.grade }.reversed()
print("\nReversed sorted by grade ascending -> descending:")
descendingByGrade.forEach { print("\($0.name) - \($0.grade)") }

// MARK: Sorting dictionary by value, then key (stable)
let scores: [String: Int] = ["Alice": 88, "Bob": 91, "Charlie": 91, "David": 78, "Eva": 88]
let sortedScores = scores.sorted {
    if $0.value != $1.value {
        return $0.value > $1.value
    } else {
        return $0.key < $1.key
    }
}
print("\nSorted dictionary by value descending, then key ascending:")
sortedScores.forEach { print("\($0.key) - \($0.value)") }

// MARK: Sorting strings by length, then alphabetically
//var fruits = ["apple", "banana", "cherry", "date"]
let sortedFruits = fruits.sorted {
    if $0.count != $1.count {
        return $0.count < $1.count // primary: length ascending
    } else {
        return $0 < $1             // secondary: alphabetically
    }
}
print("\nFruits sorted by length, then alphabetically:")
print(sortedFruits)
