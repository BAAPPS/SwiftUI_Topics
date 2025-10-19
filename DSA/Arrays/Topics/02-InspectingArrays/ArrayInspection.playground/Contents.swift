import Cocoa

// MARK: - Checking if a Collection is Empty

let games = ["Battlefield 6", "Call of Duty: Modern Warfare", "Grand Theft Auto V", "Elden Ring", "Dark Souls III"]
let id = [1, 2, 3, 4, 5]

// MARK: Generic function to check if an array is nil or empty (O(1))

func isEmptyArray<T>(_ array: [T]?) -> Bool {
    guard let array = array else {
        return true // Nil arrays are considered empty
    }
    return array.isEmpty
}

// MARK:  Check if a String is nil or empty (O(1))

func isEmptyString(_ string: String?) -> Bool {
    guard let string = string else {
        return true // Nil strings are considered empty
    }
    return string.isEmpty
}

// Examples
let name1: String? = "CodersKnowledge"
let name2: String? = nil
let name3: String? = ""

print(isEmptyString(name1)) // Outputs: false
print(isEmptyString(name2)) // Outputs: true
print(isEmptyString(name3)) // Outputs: true

// MARK: - Basic / worse-case check using count

print(games.count == 0 ? "Empty" : "Not Empty") // Outputs: Not Empty

// MARK: - Preferred / safer check using helper function

print(isEmptyArray(games)) // Outputs: false
print(!isEmptyArray(id)) // Outputs: true

// MARK: - Count vs Capacity

var numbers: [Int] = []

print("\nInitial state:")
print("Count: \(numbers.count), Capacity: \(numbers.capacity)") // 0, 0

for i in 1...10 {
    numbers.append(i)
    print("After appending \(i): Count = \(numbers.count), Capacity = \(numbers.capacity)")
}

// MARK: - Preallocating Capacity for Performance

var largeArray = [Int]()
largeArray.reserveCapacity(20) // Preallocate space for 20 elements
print("\nAfter reserving capacity:")
print("Count: \(largeArray.count), Capacity: \(largeArray.capacity)")

for i in 1...20 {
    largeArray.append(i)
}
print("After adding 20 elements: Count = \(largeArray.count), Capacity = \(largeArray.capacity)")
