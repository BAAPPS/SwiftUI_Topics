import Cocoa

// MARK: - contains(_:)
// Checks if a sequence contains a given element and returns a Boolean value.
// Complexity: O(n)
let bannedIDs = [1120, 1133, 2200, 3300, 1111, 2233, 3333]

// Simple checker
print(bannedIDs.contains(3333)) // true

for id in bannedIDs {
    if String(id).contains("33") {
        print("Banned ID: \(id)")
    }
}

// MARK: - contains(where:)
// Checks if a sequence contains an element that satisfies the given predicate.
// Returns Bool. Complexity: O(n)
let names = ["Alex", "Tom", "Thomas", "Sam", "Unx"]

let hasAlex = names.contains { $0 == "Alex" }
let hasTom = names.contains { $0 == "Tom" }
let hasBoth = hasAlex && hasTom

print("Names array contains Alex and Tom: \(hasBoth)")

// MARK: - allSatisfy(_:)
// Checks if every element satisfies the given predicate.
// Returns Bool. Complexity: O(n)
let requiredNames = ["Alex", "Tom"]
let hasAll = requiredNames.allSatisfy { names.contains($0) }
print("Array contains all required names: \(hasAll)")

// MARK: - first(where:)
// Returns the first element that satisfies the predicate (optional).
// Returns nil if no match. Complexity: O(n)
let users = ["Bob", "Alice", "Charlie", "Aaron"]
let numbers = [1, 50, 2, 4, 100, 3, 110, 150, 5]

if let startsWithA = users.first(where: { $0.hasPrefix("A") }) {
    print("First name starting with A: \(startsWithA)")
} else {
    print("No user found starting with A")
}

if let greaterThan110 = numbers.first(where: { $0 > 110 }) {
    print("Found number greater than 110: \(greaterThan110)")
}

if let divisibleBy2 = numbers.first(where: { $0 % 2 == 0 }) {
    print("First number divisible by 2: \(divisibleBy2)")
} else {
    print("No number divisible by 2 found.")
}

// MARK: - firstIndex(of:)
// Returns the first index of a specified value (optional).
// Returns nil if not found. Complexity: O(n)
var usernames = ["Alice", "Charlie", "Bob", "Aaron", "Bob", "Alice", "Charm", "Arrow"]

if let indexOfBob = usernames.firstIndex(of: "Bob") {
    print("Index of Bob: \(indexOfBob)")
    usernames[indexOfBob] = "Bobbie"
} else {
    print("Bob not found.")
}

print(usernames)

// MARK: - last(where:)
// Returns the last element that satisfies the predicate (optional).
// Returns nil if not found. Complexity: O(n)
if let lastBob = usernames.last(where: { $0 == "Bob" }) {
    print("Last Bob found: \(lastBob)")
}

if let endsWithW = usernames.last(where: { $0.hasSuffix("w") }) {
    print("Last name ending with w: \(endsWithW)")
}

// MARK: - lastIndex(of:)
// Returns the last index of a specified value (optional).
// Returns nil if not found. Complexity: O(n)
if let indexOfAlice = usernames.lastIndex(of: "Alice") {
    print("Last index of Alice: \(indexOfAlice)")
    usernames[indexOfAlice] = "Alex"
} else {
    print("Alice not found.")
}

print(usernames)

// MARK: - lastIndex(where:)
// Returns the last index where the element satisfies the predicate (optional).
// Returns nil if not found. Complexity: O(n)
if let i = usernames.lastIndex(where: { $0.hasSuffix("w") }) {
    print("\(usernames[i]) has last name ending with w")
}

// MARK: - min()
// Returns the minimum element (optional).
// Returns nil if sequence is empty. Complexity: O(n)
let heights = [7.5, 5.7, 4.3, 101.1, 8.5, 0.3, 64.9, 8.5]

if let lowestHeight = heights.min() {
    print("Lowest height: \(lowestHeight)")
}

// MARK: - min(by:)
// Returns the minimum element using a custom comparator (optional).
// Complexity: O(n)
let userRatings: [String: Int] = ["Alex": 5, "Tom": 6, "Thomas": 3, "Sam": 10, "Unx": 19, "Tommy": 5]

if let lowestRating = userRatings.min(by: { first, second in first.value < second.value }) {
    print("Lowest rating: \(lowestRating)")
}

// MARK: - max()
// Returns the maximum element (optional).
// Returns nil if sequence is empty. Complexity: O(n)
if let greatestHeight = heights.max() {
    print("Greatest height: \(greatestHeight)")
}

// MARK: - max(by:)
// Returns the maximum element using a custom comparator (optional).
// Complexity: O(n)
if let highestRating = userRatings.max(by: { first, second in first.value < second.value }) {
    print("Highest rating: \(highestRating)")
}

