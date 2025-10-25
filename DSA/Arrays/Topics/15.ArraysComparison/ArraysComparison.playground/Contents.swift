import Cocoa

// MARK: - Swift Array Equality
// Demonstrates different ways to compare arrays in Swift:
// 1. == operator
// 2. != operator
// 3. elementsEqual(_:)
// 4. elementsEqual(_:by:) with custom predicate

// MARK: Using == operator
// Checks if two arrays contain the same elements in the same order.
// Requires the elements to conform to Equatable.

let array1: [Int] = [1, 2, 3]
let array2: [Int] = [1, 2, 3]
let array3: [Int] = [1, 2]

print(array1 == array2) // true
print(array1 == array3) // false

// MARK: Using != operator
// Checks if two arrays do NOT contain the same elements.

print(array1 != array3) // true

// MARK: Using elementsEqual(_:)
// Checks if two sequences contain the same elements in the same order.
// Complexity: O(m), where m is the length of the shorter sequence.

print(array1.elementsEqual(array2)) // true
print(array1.elementsEqual(array3)) // false

// MARK: Using elementsEqual(_:by:)
// Checks equality using a custom equivalence predicate.
// Useful for comparing custom objects or ignoring certain properties.

struct User {
    let id: Int
    let name: String
}

let usersOld = [
    User(id: 1, name: "Alice"),
    User(id: 2, name: "Bob")
]

let usersNew = [
    User(id: 1, name: "Alice A."), // name changed
    User(id: 2, name: "Bob")
]

// Compare arrays by 'id' only, ignoring name
let areEqualById = usersOld.elementsEqual(usersNew) { $0.id == $1.id }
print("Users equal by id:", areEqualById) // true

// MARK: Explanation
// 1. `==` checks full equality, requiring Equatable conformance.
// 2. `elementsEqual(_:)` checks order-sensitive equality for sequences.
// 3. `elementsEqual(_:by:)` allows custom logic for determining equality.
//    - Example: Compare only `id` while ignoring `name` changes.

// MARK: Tips
// - Use `==` or `!=` for standard types ([Int], [String], etc.).
// - Use `elementsEqual(_:)` for generic sequences or slices.
// - Use `elementsEqual(_:by:)` for custom objects or partial equality checks.
// - Remember: elementsEqual is **order-sensitive**. For order-independent comparison, consider sorting or using sets.

// MARK: - starts(with:)
// Returns true if the beginning elements of a sequence match another sequence.
// Complexity: O(m), where m is the length of the shorter sequence.

struct UserEquatable: CustomStringConvertible, Equatable {
    let id: Int
    let name: String
    
    var description: String { "(\(id), \(name))" }
    
    static func == (lhs: UserEquatable, rhs: UserEquatable) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

let usersOldEquatable = [
    UserEquatable(id: 1, name: "Alice"),
    UserEquatable(id: 2, name: "Bob"),
    UserEquatable(id: 3, name: "Charlie")
]

let prefixUsersEquatable = [
    UserEquatable(id: 1, name: "Alice"),
    UserEquatable(id: 2, name: "Bob"),
]

let prefixUsersEquatable2 = [
    UserEquatable(id: 1, name: "Alice"),
    UserEquatable(id: 2, name: "Bob"),
    UserEquatable(id: 3, name: "Fharlie")
]


// Check if usersOld starts with prefixUsers
let startsWithPrefix = usersOldEquatable.starts(with: prefixUsersEquatable)
print("usersOld starts with prefixUsers:", startsWithPrefix) // Output: true
let startsWithPrefix2 = usersOldEquatable.starts(with: prefixUsersEquatable2)
print("usersOld starts with prefixUsers:", startsWithPrefix2) // Output: false


// MARK: - starts(with:by:)
// Returns true if the beginning elements of a sequence match another sequence using a custom predicate.
// Complexity: O(m), where m is the length of the shorter sequence.

struct User2 {
    let id: Int
    let name: String
}

let usersOld2 = [
    User2(id: 1, name: "Alice"),
    User2(id: 2, name: "Bob"),
    User2(id: 3, name: "Charlie")
]

let prefixUsers2 = [
    User2(id: 1, name: "Alice A."), // name changed
    User2(id: 2, name: "Bob")
]

let prefixUsers3 = [
    User2(id: 2, name: "Bob"),
    User2(id: 1, name: "Alice A.")
]

// Check if usersOld starts with prefixUsers using only `id` as identity
let startsWithIdOnly = usersOld2.starts(with: prefixUsers2) { $0.id == $1.id }

print("usersOld starts with prefixUsers by id only:", startsWithIdOnly) // Output: true

let startsWithIdOnly2 = usersOld2.starts(with: prefixUsers3) { $0.id == $1.id }
 
print("usersOld starts with prefixUsers by id only:", startsWithIdOnly2) // Output: false
// Order matters as it only compares the beginning elements in the same order.

// MARK: - lexicographicallyPrecedes(_:)
// Returns true if the sequence comes **before another sequence** in lexicographical (dictionary) order.
// Complexity: O(m), where m is the length of the shorter sequence.

let numbers1 = [1, 2, 3]
let numbers2 = [1, 2, 4]
let numbers3 = [1, 2, 3, 0]

// Compare arrays
print("numbers1 lexicographically precedes numbers2:", numbers1.lexicographicallyPrecedes(numbers2))
// Output: true, because 3 < 4 at the first differing element

print("numbers2 lexicographically precedes numbers1:", numbers2.lexicographicallyPrecedes(numbers1))
// Output: false, because numbers2 > numbers1

print("numbers1 lexicographically precedes numbers3:", numbers1.lexicographicallyPrecedes(numbers3))
// Output: true, because numbers1 is shorter but all elements match the start

// MARK: Strings Example
let word1 = "apple"
let word2 = "apricot"

print("word1 precedes word2:", word1.lexicographicallyPrecedes(word2))
// Output: true, because 'l' < 'r' at the first differing character

print("word2 precedes word1:", word2.lexicographicallyPrecedes(word1))
// Output: false

// MARK: Custom Objects Example
struct User3: Comparable {
    let id: Int
    let name: String
    
    // We define < based on id
    static func < (lhs: User3, rhs: User3) -> Bool {
        return lhs.id < rhs.id
    }
}

let usersA = [
    User3(id: 1, name: "Alice"),
    User3(id: 2, name: "Bob")
]

let usersB = [
    User3(id: 1, name: "Alice"),
    User3(id: 3, name: "Charlie")
]

print("usersA lexicographically precedes usersB:", usersA.lexicographicallyPrecedes(usersB))
// Output: true, because 2 < 3 at the first differing element

print("usersB lexicographically precedes usersA:", usersB.lexicographicallyPrecedes(usersA))
// Output: false


// MARK: - lexicographicallyPrecedes(_:by:) with Cars
// Compare sequences lexicographically using a custom predicate.

struct Car {
    let make: String
    let year: Int
}

let garageA = [
    Car(make: "Toyota", year: 2018),
    Car(make: "Honda", year: 2020)
]

let garageB = [
    Car(make: "Toyota", year: 2018),
    Car(make: "Honda", year: 2022)
]

// Compare arrays by year
let precedesByYear = garageA.lexicographicallyPrecedes(garageB) { $0.year < $1.year }
print("garageA lexicographically precedes garageB by year:", precedesByYear)
// Output: true, because 2020 < 2022 at the first differing element

// Compare arrays by make (dictionary order)
let precedesByMake = garageA.lexicographicallyPrecedes(garageB) { $0.make < $1.make }
print("garageA lexicographically precedes garageB by make:", precedesByMake)
// Output: false, because the first differing 'make' is the same; comparison continues, all equal, so the shorter sequence precedes (both same length, false)

let precedesByMakeThenYear = garageA.lexicographicallyPrecedes(garageB) {
    if $0.make != $1.make { return $0.make < $1.make }
    return $0.year < $1.year
}

print(precedesByMakeThenYear) // true
