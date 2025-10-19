import Cocoa

// MARK: - Subscript

var codingLanguages = ["Java", "JavaScript", "Python", "C#", "C++"]

// MARK: Access or Modify Element at a Specified Index (O(1))

// Access element at index 1
let element1 = codingLanguages[1]
print("Element at index 1: \(element1)") // JavaScript

// Modify element at index 1
codingLanguages[1] = "Swift"
print("Modified codingLanguages: \(codingLanguages)") // ["Java", "Swift", "Python", "C#", "C++"]


// MARK: Element Slicing

// Slice from index 2 to the end (explicit)
let slicedLanguages = codingLanguages[2..<codingLanguages.endIndex]
print("ArraySlice after slicing: \(slicedLanguages)")
// Output: ["Python", "C#", "C++"]

// Slice from index 3 to the end using shortcut (closed range)
let slicedLanguagesShortcut = codingLanguages[3...]
print("ArraySlice after slicing (shortcut): \(slicedLanguagesShortcut)")
// Output: ["C#", "C++"]


// Convert ArraySlice back to Array if needed
let slicedLanguagesArray = Array(slicedLanguages)
print("Converted to Array: \(slicedLanguagesArray)")

// MARK: Finding Element Index After Slicing

// Safely find the index of "Swift" in the original array (O(n))
if let indexOfSwift = codingLanguages.firstIndex(of: "Swift") {
    print("Index of Swift: \(indexOfSwift)")
    print("Element at that index: \(codingLanguages[indexOfSwift])")
} else {
    print("Swift not found")
}

// MARK: Safely Access Elements of a Slice

print("ArraySlice: \(slicedLanguagesShortcut)")
// Output: ["C#", "C++"]

// MARK: Using startIndex to Access the First Element Safely

// ArraySlice preserves original indices
print("Slice startIndex: \(slicedLanguagesShortcut.startIndex)") // 3
print("Slice endIndex: \(slicedLanguagesShortcut.endIndex)")     // 5 (one past the last element)

// Access first element safely using startIndex
let firstElementInSlice = slicedLanguagesShortcut[slicedLanguagesShortcut.startIndex]
print("First element in slice: \(firstElementInSlice)") // "C#"

// MARK: Iterating Safely Over a Slice

print("\nIterating over ArraySlice safely:")
for i in slicedLanguagesShortcut.startIndex..<slicedLanguagesShortcut.endIndex {
    print("\(i): \(slicedLanguagesShortcut[i])")
}

// MARK: Optional: Convert to Array for zero-based indexing

let normalArray = Array(slicedLanguagesShortcut)
print("\nConverted to Array (zero-based indices):")
print(normalArray)         // ["C#", "C++"]
print(normalArray[0])      // "C#" (now zero-based)


// MARK: - First Element of the Collection
let numbers = [1, 2, 3, 4, 5]

// Safe access to first element (O(1) for Array)
if let firstElement = numbers.first {
    print("First element: \(firstElement)") // Output: 1
} else {
    print("Array is empty")
}

// MARK: - Last Element of the Collection
let names = ["Alice", "Bob", "Charlie"]

// Safe access to last element (O(1) for Array)
if let lastElement = names.last {
    print("Last element: \(lastElement)") // Output: "Charlie"
} else {
    print("Array is empty")
}

// MARK: - Random Element of the Collection (Default Generator)

// O(1) if collection conforms to RandomAccessCollection (like Array), otherwise O(n)
let randomName = names.randomElement() ?? "Unknown"
print("Random name (default generator): \(randomName)")

// MARK: - Random Element Using a Custom Generator

// Custom deterministic generator for repeatable random results
struct MyGenerator: RandomNumberGenerator {
    var state: UInt64 = 42 // seed
    
    mutating func next() -> UInt64 {
        state = 6364136223846793005 &* state &+ 1
        return state
    }
}

var myGen = MyGenerator()

// Pick a random element using custom generator
let deterministicRandomName = names.randomElement(using: &myGen) ?? "Unknown"
print("Random name (custom generator): \(deterministicRandomName)")

// Picking multiple random elements using the same generator
print("\nMultiple picks using custom generator:")
for _ in 1...5 {
    if let name = names.randomElement(using: &myGen) {
        print(name)
    }
}
