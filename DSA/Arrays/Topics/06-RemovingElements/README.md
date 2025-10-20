# Swift Array Removal Methods Reference

This Playground demonstrates various ways to remove elements from arrays in Swift, along with their complexity and behavior.

---

## Table of Contents
1. [remove(at:)](#removeat)
2. [removeFirst()](#removefirst)
3. [removeFirst(_:)](#removefirstn)
4. [removeLast()](#removelast)
5. [removeLast(_:)](#removelastn)
6. [removeSubrange(_:)](#removesubrange)
7. [removeAll(where:)](#removeallwhere)
8. [popLast()](#poplast)

---

## `remove(at:)`

Removes and returns the element at the specified index.
**Complexity:** O(n), because elements after the removed item need to be shifted.

```swift
var usernames: [String] = ["Alex", "Tom", "Jerry", "Gilbert"]
let removedUsername = usernames.remove(at: 2)
print("Removed username: \(removedUsername)") // Output: Jerry
print("Updated usernames: \(usernames)")     // Output: ["Alex", "Tom", "Gilbert"]
```

---

## `removeFirst()`

Removes and returns the first element of the collection.
**Complexity:** O(n), as remaining elements are shifted.

```swift
var transformers = ["Optimus Prime", "Megatron", "Bumblebee", "Starscream"]
let firstTransformer = transformers.removeFirst()
print("Removed first transformer: \(firstTransformer)") // Output: "Optimus Prime"
print("Updated transformers: \(transformers)") // Output: ["Megatron", "Bumblebee", "Starscream"]
```

---

## `removeFirst(_:)`

Removes the specified number of elements from the start of the collection.
**Complexity:** O(n), where n is the length of the collection.

```swift
var starwars = ["Luke", "Han", "Chewbacca", "Rey", "Finn"]
starwars.removeFirst(3)
print("Updated Star Wars characters: \(starwars)") // Output: ["Rey", "Finn"]
```

---

## `removeLast()`

Removes and returns the last element of the collection.
**Complexity:** O(1), because only the last element is accessed and removed.

```swift
var starwars2 = ["Luke", "Han", "Chewbacca", "Rey", "Finn"]
let lastCharacter = starwars2.removeLast()
print("Removed last character: \(lastCharacter)") // Output: "Finn"
print("Updated array: \(starwars2)") // Output: ["Luke", "Han", "Chewbacca", "Rey"]
```

---

## `removeLast(_:)`

Removes the specified number of elements from the end of the collection.
**Complexity:** O(k), where k is the number of elements being removed.

```swift
starwars2.removeLast(2)
print("Updated array after removing 2 elements from the end: \(starwars2)") // Output: ["Luke", "Han"]
```

---

## `removeSubrange(_:)`

Removes elements in a specified subrange.
**Complexity:** O(n), where n is the length of the collection.

```swift
var transformers1 = ["Optimus Prime", "Megatron", "Bumblebee", "Starscream"]

// Remove elements in the range 1..<3 ("Megatron" and "Bumblebee")
transformers1.removeSubrange(1..<3)
print("Updated array after removing subrange: \(transformers1)") // Output: ["Optimus Prime", "Starscream"]
```

---

## `removeAll(where:)`

Removes all elements that satisfy a given predicate.
**Complexity:** O(n), where n is the length of the collection.

```swift
var transformers2 = ["Optimus Prime", "Megatron", "Bumblebee", "Starscream"]

// Remove all elements that contain lowercase "b"
transformers2.removeAll(where: { $0.contains("b") })
// Output: ["Optimis Prime", "Megatron", "Starscream"]

var bannedIDS = [1110, 1130, 1140, 1200, 1234]

// Remove elements starting with "11"
bannedIDS.removeAll(where: { String($0).hasPrefix("11") })
print(bannedIDS) // Output: [1200, 1234]
```

---

## `popLast()`

Removes and returns the last element of the collection as an optional.
Returns `nil` if the array is empty.
**Complexity:** O(1)

```swift
if let lastTransformer = transformers2.popLast() {
    print("Removed last element: \(lastTransformer)") // Outputs: Starscream
}
```

---
