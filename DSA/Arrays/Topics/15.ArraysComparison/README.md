# Swift Array Comparison Reference

This playground demonstrates **various ways to compare arrays and sequences in Swift**, including standard equality, order-sensitive checks, prefix matching, and lexicographical comparisons.  

It also includes examples with **custom structs** (`User`, `Car`) and **predicate-based comparisons** for flexible use cases.

---

## Table of Contents

- [Swift Array Equality](#swift-array-equality)

  - [Using `==` operator](#using--operator)
  
  - [Using `!=` operator](#using--operator-1)
  
  - [Using `elementsEqual(_:)`](#using-elementsequal)
  
  - [Using `elementsEqual(_:by:)`](#using-elementsequalby)
  
- [Prefix Matching](#prefix-matching)

  - [Using `starts(with:)`](#using-startswith)
  
  - [Using `starts(with:by:)`](#using-startswithby)
  
- [Lexicographical Comparison](#lexicographical-comparison)

  - [Using `lexicographicallyPrecedes(_:)`](#using-lexicographicallyprecedes)
  
  - [Using `lexicographicallyPrecedes(_:by:)`](#using-lexicographicallyprecedesby)

---

## Swift Array Equality

### Using `==` operator
Checks if two arrays contain the **same elements in the same order**.  
Requires elements to conform to `Equatable`.

```swift
let array1: [Int] = [1, 2, 3]
let array2: [Int] = [1, 2, 3]
let array3: [Int] = [1, 2]

print(array1 == array2) // true
print(array1 == array3) // false
````

### Using `!=` operator

Checks if two arrays **do not contain the same elements**.

```swift
print(array1 != array3) // true
```

### Using `elementsEqual(_:)`

Checks if two sequences contain the **same elements in the same order**.
Complexity: O(m), where m = length of the shorter sequence.

```swift
print(array1.elementsEqual(array2)) // true
print(array1.elementsEqual(array3)) // false
```

### Using `elementsEqual(_:by:)`

Checks equality using a **custom predicate**, useful for comparing custom objects or ignoring certain properties.

```swift
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
```

**Tips:**

* Use `==` / `!=` for standard types like `[Int]`, `[String]`.
* Use `elementsEqual(_:)` for generic sequences or slices.
* Use `elementsEqual(_:by:)` for custom objects or **partial equality checks**.
* **Order-sensitive**: sequences must have elements in the same order.

---

## Prefix Matching

### Using `starts(with:)`

Returns true if the **beginning elements** of a sequence match another sequence.

```swift
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
    UserEquatable(id: 2, name: "Bob")
]

let startsWithPrefix = usersOldEquatable.starts(with: prefixUsersEquatable)
print("usersOld starts with prefixUsers:", startsWithPrefix) // true
```

### Using `starts(with:by:)`

Uses a **custom predicate** to check the prefix.

```swift
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

let startsWithIdOnly = usersOld2.starts(with: prefixUsers2) { $0.id == $1.id }
print("usersOld starts with prefixUsers by id only:", startsWithIdOnly) // true
```

**Order matters**: the elements must match **exactly at the beginning**.

---

## Lexicographical Comparison

### Using `lexicographicallyPrecedes(_:)`

Returns true if the sequence comes **before another sequence in dictionary order**.

```swift
let numbers1 = [1, 2, 3]
let numbers2 = [1, 2, 4]

print("numbers1 lexicographically precedes numbers2:", numbers1.lexicographicallyPrecedes(numbers2)) // true
```

* Works element-wise.
* Shorter sequences precede longer sequences if all compared elements are equal.
* Can be used with arrays, strings, or any `Comparable` elements.

### Using `lexicographicallyPrecedes(_:by:)`

Uses a **custom predicate** for comparison, useful with structs.

```swift
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
print("garageA lexicographically precedes garageB by year:", precedesByYear) // true

// Compare arrays by make
let precedesByMake = garageA.lexicographicallyPrecedes(garageB) { $0.make < $1.make }
print("garageA lexicographically precedes garageB by make:", precedesByMake) // false

// Compare arrays by make first, then year
let precedesByMakeThenYear = garageA.lexicographicallyPrecedes(garageB) {
    if $0.make != $1.make { return $0.make < $1.make }
    return $0.year < $1.year
}
print(precedesByMakeThenYear) // true
```

**Tips:**

* Use this for **dictionary-order comparisons**.
* The predicate can include **multiple properties** to break ties.
* Order of elements is critical; comparison is **element-wise**.

