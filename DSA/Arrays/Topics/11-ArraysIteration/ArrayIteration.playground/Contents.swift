import Cocoa

// MARK: - forEach
/*
 `forEach` iterates over each element in a sequence (Array, Dictionary, Set, etc.)
 Executes a closure for every element in order.
 
 Key points:
 - Similar to `for-in` loop
 - Cannot use `break` or `continue`
 - Ideal for side-effect operations (printing, appending, updating)
*/

// MARK: Arrays
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


// MARK:  Dictionaries

// Simple dictionary operation
var dict: [Int: Int] = [:]
numbers.forEach { num in
    dict[num] = num + num
}
print("Dict (unordered):", dict)

// Sorted dictionary output
let ordered = dict.sorted { $0.key < $1.key }
ordered.forEach { key, value in
    print("Sorted dict -> \(key): \(value)")
}

// Another example
var dictNum: [Int: String] = [3: "Three", 1: "One", 2: "Two"]
dictNum.sorted { $0.key < $1.key }.forEach { key, value in
    print("\(key) -> \(value)")
}

// MARK: - 3. Sets (unordered collection)
let letters: Set<Character> = ["a", "b", "c"]
letters.forEach { char in
    print("Letter:", char)
}

// MARK: Chaining Operations
numbers.forEach { num in
    let square = num * num
    print("Square: \(square)")
    
    let cube = num * num * num
    print("Cube: \(cube)")
}


// MARK: Nested Arrays
let nestedNumbers = [[1, 2], [3, 4], [5]]
nestedNumbers.forEach { subArray in
    subArray.forEach { num in
        print("Nested number:", num)
    }
}

// MARK: - 6. Filtering within forEach (no early exit)
var evenNumbers: [Int] = []
numbers.forEach { num in
    if num % 2 == 0 {
        evenNumbers.append(num)
    }
}
print("Even numbers:", evenNumbers)

// MARK:  Notes & Best Practices
/*
 - Use `forEach` for side-effects, not for returning a transformed array (use map/filter/reduce instead)
 - Cannot break out of a forEach loop
 - Preserve order when iterating over Arrays, but Dictionaries and Sets are unordered
*/


// MARK: - enumerated()
// Returns a sequence of pairs (index, element) where index starts at 0
// O(1) per iteration

// let numbers: [Int] = [10, 20, 30, 40, 50]

// Simple iteration with enumerated
for (index, value) in numbers.enumerated() {
    print("Index \(index) -> Value \(value)")
}
// Output:
// Index 0 -> Value 10
// Index 1 -> Value 20
// Index 2 -> Value 30
// Index 3 -> Value 40
// Index 4 -> Value 50

// Using enumerated with forEach
numbers.enumerated().forEach { index, value in
    print("forEach: Index \(index) -> Value \(value)")
}

// Using enumerated to find first even number and its index
if let (index, value) = numbers.enumerated().first(where: { $0.element % 20 == 0 }) {
    print("First divisible by 20: Index \(index) -> Value \(value)")
}

// Using enumerated to modify an array (mapping with index)
let multipliedByIndex = numbers.enumerated().map { index, value in
    value * (index + 1)
}
print("Multiplied by (index+1):", multipliedByIndex)
// Output: [10, 40, 90, 160, 250]

// Enumerated with strings
let words = ["apple", "banana", "cherry"]
for (index, word) in words.enumerated() {
    print("\(index + 1). \(word.capitalized)")
}
// Output:
// 1. Apple
// 2. Banana
// 3. Cherry

// Nested arrays with enumerated
// let nestedNumbers = [[1, 2], [3, 4], [5]]
nestedNumbers.enumerated().forEach { outerIndex, subArray in
    subArray.enumerated().forEach { innerIndex, value in
        print("Outer \(outerIndex), Inner \(innerIndex) -> \(value)")
    }
}
