import Cocoa

// MARK: - remove(at:)
// Removes and returns the element at the specified index.
// Complexity: O(n), because elements after the removed item need to be shifted.

var usernames: [String] = ["Alex", "Tom", "Jerry", "Gilbert"]
let removedUsername = usernames.remove(at: 2)
print("Removed username: \(removedUsername)") // Output: Jerry
print("Updated usernames: \(usernames)")     // Output: ["Alex", "Tom", "Gilbert"]

// MARK: - removeFirst()
// Removes and returns the first element of the collection.
// Complexity: O(n), as remaining elements are shifted.

var transformers = ["Optimus Prime", "Megatron", "Bumblebee", "Starscream"]
let firstTransformer = transformers.removeFirst()
print("Removed first transformer: \(firstTransformer)") // Output: "Optimus Prime"
print("Updated transformers: \(transformers)") // Output: ["Megatron", "Bumblebee", "Starscream"]

// MARK: - removeFirst(_:)
// Removes the specified number of elements from the start of the collection.
// Complexity: O(n), where n is the length of the collection.

var starwars = ["Luke", "Han", "Chewbacca", "Rey", "Finn"]
starwars.removeFirst(3)
print("Updated Star Wars characters: \(starwars)") // Output: ["Rey", "Finn"]

// MARK: - removeLast()
// Removes and returns the last element of the collection.
// Complexity: O(1), because only the last element is accessed and removed.

var starwars2 = ["Luke", "Han", "Chewbacca", "Rey", "Finn"]
let lastCharacter = starwars2.removeLast()
print("Removed last character: \(lastCharacter)") // Output: "Finn"
print("Updated array: \(starwars2)") // Output: ["Luke", "Han", "Chewbacca", "Rey"]

// MARK: - removeLast(_:)
// Removes the specified number of elements from the end of the collection.
// Complexity: O(k), where k is the number of elements being removed.

starwars2.removeLast(2)
print("Updated array after removing 2 elements from the end: \(starwars2)") // Output: ["Luke", "Han"]

// MARK: - removeSubrange(_:)
// Removes the elements in the specified subrange from the collection.
// Complexity: O(n), where n is the length of the collection.

var transformers1 = ["Optimus Prime", "Megatron", "Bumblebee", "Starscream"]

// Remove elements in the range 1..<3 (i.e., "Megatron" and "Bumblebee")
transformers1.removeSubrange(1..<3)
// transformers1.removeSubrange(1...2) also removes indices 1 and 2, same as 1..<3 (closed range)
print("Updated array after removing subrange: \(transformers1)")
// Output: ["Optimus Prime", "Starscream"]

// MARK: - removeAll(where:)
// Removes all elements that satisfy the given predicate
// Complexity: O(n), where n is the length of the collection.

var transformers2 = ["Optimus Prime", "Megatron", "Bumblebee", "Starscream"]

// Remove all elements that contain the lowercase letter "b" (case-sensitive)
transformers2.removeAll(where: { $0.contains("b") })
// Output: ["Optimis Prime", "Megatron", "Starscream"]

var bannedIDS = [1110, 1130, 1140, 1200, 1234]

// Remove any element that starts with "11"
bannedIDS.removeAll(where: { String($0).hasPrefix("11") })
print(bannedIDS) // Output: [1200, 1234]

// MARK: - popLast()
// Removes and returns the last element of the collection (optional).
// If the array is empty, popLast() returns nil without crashing
// Complexity: O(1)  because only the last element is accessed and removed.
if let lastTransformer = transformers2.popLast() {
    print("Removed last element: \(lastTransformer)") // Outputs: Starscream
}
