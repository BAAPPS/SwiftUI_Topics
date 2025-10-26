import Cocoa

// MARK: - startIndex
// The position of the first element in a nonempty array.

let numbers = [10, 20, 30, 40, 50, 60, 80, 90, 100]
print(numbers.startIndex)

// MARK: - endIndex
// The array’s “past the end” position—that is, the position one greater than the last valid subscript argument.

if let i = numbers.firstIndex(of: 30) {
    print(numbers[i ..< numbers.endIndex])
}

// MARK: - index(after:)
// Returns the position immediately after the given index.

if let i = numbers.firstIndex(of: 40) {
    print(numbers.index(after: i))
}

// MARK: - index(before:)
// Returns the position immediately before the given index.

if let i = numbers.firstIndex(of: 40){
    print(numbers.index(before: i))
}

// MARK: - index(_:offsetBy:)
// Returns an index that is the specified distance from the given index.

let i = numbers.index(numbers.startIndex, offsetBy: 4)
print(numbers[i]) // Output: 50


// MARK: -  index(_:offsetBy:limitedBy:)
// Returns an index that is the specified distance from the given index, unless that distance is beyond a given limiting index.
// O(1)

if let k = numbers.index(numbers.startIndex, offsetBy: 10, limitedBy: numbers.endIndex) {
    print(numbers[k]) // Output: nil
    
}

if let j = numbers.index(numbers.startIndex, offsetBy: 6, limitedBy: numbers.endIndex){
    print(numbers[j ]) // Output: 80
}




//  MARK: - Sliding Window with index(_:offsetBy:limitedBy:)
// Demonstrates how to use Collection.index(_:offsetBy:) to implement a sliding window pattern.
// Complexity: O(n), where n is the number of elements in the array.
var startIndex = numbers.startIndex
let windowSize = 4
while true {
    // Calculate the end index by offsetting startIndex
    if let endIndex = numbers.index(startIndex, offsetBy: windowSize, limitedBy: numbers.endIndex)  {
        // Slice the window
        let window = numbers[startIndex..<endIndex]
        print("Window:", Array(window))
        
        if endIndex == numbers.endIndex { break }
        
        // Move the window forward by 1
        startIndex = numbers.index(after: startIndex)
    }
}

// MARK: - formIndex(after:)
// Advances the given index (in place)

var index = numbers.startIndex

print("Start index points to:", numbers[index]) // 10

numbers.formIndex(after: &index)
print("After formIndex:", numbers[index]) // 20

numbers.formIndex(after: &index)
print("Now index points to:", numbers[index]) // 30

var formIndexI = numbers.startIndex
while formIndexI < numbers.endIndex {
    print("Element:", numbers[formIndexI])
    numbers.formIndex(after: &formIndexI)
}


// MARK: - formIndex(before:)
// Replaces the given index with its predecessor.
// Useful for reverse traversal algorithms (e.g. reverse iterators, linked list backtracking).


// let numbers = [10, 20, 30, 40, 50, 60, 80, 90, 100]

var formIndexB = numbers.endIndex

numbers.formIndex(before: &formIndexB)

print("Reverse traversal using formIndex(before:)")
while formIndexB > numbers.startIndex {
    print(numbers[formIndexB])
    numbers.formIndex(before: &formIndexB)
}

print(numbers[formIndexB])


// MARK: - formIndex(before:) + formIndex(after:) for Two-Pointer Technique
// Find all pairs in a sorted array that sum to a given target using manual index movement.

let target = 100

var left = numbers.startIndex
var right = numbers.index(before: numbers.endIndex) // last valid index

print("Pairs that sum to \(target):")

while left < right {
    let sum = numbers[left] + numbers[right]
    
    if sum == target {
        print("(\(numbers[left]), \(numbers[right]))")
        // Move both pointers inward
        numbers.formIndex(after: &left)
        numbers.formIndex(before: &right)
    } else if sum < target {
        // Increase the sum by moving left pointer forward
        numbers.formIndex(after: &left)
    } else {
        // Decrease the sum by moving right pointer backward
        numbers.formIndex(before: &right)
    }
}


// MARK: - Singly Linked List Using formIndex(after:)

// A basic singly linked list node.
final class Node<Element> {
    var value: Element
    var next: Node<Element>?
    
    init(_ value: Element, next: Node<Element>? = nil) {
        self.value = value
        self.next = next
    }
}

// A LinkedList structure conforming to `Collection`.
struct LinkedList<Element>: Collection {
    // MARK: - Nested Types
    struct Index: Comparable {
        fileprivate var node: Node<Element>?
        
        static func == (lhs: Index, rhs: Index) -> Bool {
            return lhs.node === rhs.node
        }
        
        static func < (lhs: Index, rhs: Index) -> Bool {
            // Only for Collection conformance; order not really meaningful
            guard lhs != rhs else { return false }
            return true
        }
    }
    
    private var head: Node<Element>?
    private var tail: Node<Element>?
    
    init() {}
    
    
    mutating func append(_ value: Element) {
        let newNode = Node(value)
        if let tailNode = tail {
            tailNode.next = newNode
        }else {
            head = newNode
        }
        tail = newNode
    }
    
    var startIndex: Index {Index(node: head)}
    var endIndex: Index {Index(node: nil)}
    
    func index(after i: Index) -> Index {
        return Index(node: i.node?.next)
    }
    
    func formIndex(after i: inout Index) {
        // This is where "move to the next node" happens
        // like `current = current.next`
        i.node = i.node?.next
    }
    
    func formIndex(before i: inout Index) {
        if i.node == nil {
            i.node = tail
        } else {
            i.node = i.node?.next
        }
    }
    
    subscript(position: Index) -> Element {
        return position.node!.value
    }
}

// for   init() {}
var list = LinkedList<Int>()
list.append(10)
list.append(20)
list.append(30)


print("Forward traversal:")
for value in list {
    print(value)
}

// MARK: - Doubly Linked List with formIndex(after:) & formIndex(before:)

// MARK: DoublyNode Definition
final class DoublyNode<Element> {
    var value: Element
    var next: DoublyNode?
    weak var previous: DoublyNode? // weak to avoid retain cycles
    
    init(value: Element) {
        self.value = value
    }
}

// MARK:  DoublyLinkedList Definition
struct DoublyLinkedList<Element> {
    private var head: DoublyNode<Element>?
    private var tail: DoublyNode<Element>?
    
    init(_ elements: [Element]) {
        for element in elements {
            append(element)
        }
    }
    
    mutating func append(_ value: Element) {
        let newNode = DoublyNode(value: value)
        if let tail = tail {
            tail.next = newNode
            newNode.previous = tail
            self.tail = newNode
        } else {
            head = newNode
            tail = newNode
        }
    }
}

// MARK: Index Definition
extension DoublyLinkedList {
    struct Index: Comparable {
        var node: DoublyNode<Element>?
        
        static func == (lhs: Index, rhs: Index) -> Bool {
            lhs.node === rhs.node
        }
        
        static func < (lhs: Index, rhs: Index) -> Bool {
            var current = lhs.node
            while let next = current?.next {
                if next === rhs.node { return true }
                current = next
            }
            return false
        }
    }
}

// MARK: Collection Conformance
extension DoublyLinkedList: BidirectionalCollection {
    var startIndex: Index { Index(node: head) }
    var endIndex: Index { Index(node: nil) } // endIndex points past last element
    
    func index(after i: Index) -> Index {
        Index(node: i.node?.next)
    }
    
    func index(before i: Index) -> Index {
        if let prev = i.node?.previous {
            return Index(node: prev)
        } else {
            return Index(node: tail) // from endIndex to last element
        }
    }
    
    func formIndex(after i: inout Index) {
        i.node = i.node?.next
    }
    
    func formIndex(before i: inout Index) {
        if i.node == nil {
            i.node = tail
        } else {
            i.node = i.node?.previous
        }
    }
    
    func distance(from start: Index, to end: Index) -> Int {
        var current = start.node
        var count = 0
        while current !== end.node {
            current = current?.next
            count += 1
        }
        return count
    }

    
    
    subscript(position: Index) -> Element {
        position.node!.value
    }
}


var doublyList = DoublyLinkedList([10, 20, 30, 40, 50])

print("Forward traversal:")
for value in doublyList {
    print(value)
}

print("\nReverse traversal:")
var reverseIndex = doublyList.endIndex
doublyList.formIndex(before: &reverseIndex)

while reverseIndex.node != nil {
    print(doublyList[reverseIndex])
    doublyList.formIndex(before: &reverseIndex)
}


// MARK: - formIndex(_:offsetBy:)
// Offsets the given index by the specified distance.
// O(1) if the collection conforms to RandomAccessCollection; otherwise, O(k), where k is the absolute value of distance.

var doublyList2 = DoublyLinkedList([10, 20, 30, 40, 50])

var index4 = doublyList2.startIndex
doublyList2.formIndex(&index4, offsetBy: 2)
print("Offset:", doublyList2[index4]) // 30


// MARK: - formIndex(_:offsetBy:limitedBy:)
//Offsets the given index by the specified distance, or so that it equals the given limiting index.

// MARK: Sliding Window
// Suppose you have an array of numbers and you want all windows of size 3:

let numbers2 = [10, 20, 30, 50, 60, 80, 90]

var startIndex2 = numbers2.startIndex

while startIndex2 < numbers2.endIndex {
    var end = startIndex2
    numbers2.formIndex(&end, offsetBy: 3, limitedBy: numbers2.endIndex)
    
    let window = numbers2[startIndex2..<end]
    
    print("Window:", Array(window))
    
    startIndex2 = numbers2.index(after: startIndex2) // slide by 1
}


// MARK: K-th Element or Step Size
// If you want every 3rd element
var index5 = numbers2.startIndex
while index5 < numbers2.endIndex {
    print(numbers2[index5])
    numbers2.formIndex(&index5, offsetBy: 3, limitedBy: numbers2.endIndex)
}

// MARK: - distance(from:to:)
// Returns the number of steps from startIndex to endIndex.

// MARK: Sliding Window Size
//Suppose you have a linked list and you want to know if a window of size 3 is valid

var doublyList3 = DoublyLinkedList([10, 20, 30, 40, 50])
var indexStart = doublyList3.startIndex
var indexEnd = indexStart
doublyList3.formIndex(&indexEnd, offsetBy: 3, limitedBy: doublyList3.endIndex)

if doublyList3.distance(from: indexStart, to: indexEnd) == 3 {
    let window = doublyList3[indexStart..<indexEnd]
    print("Window of size 3:", Array(window))
}

// MARK: Find LL / DLL middle index
// O(n)
// Should use slow/fast pointer approach, which is a single pass O(n) but without two traversals
let midIndex = doublyList3.index(doublyList3.startIndex, offsetBy: doublyList3.distance(from: doublyList3.startIndex, to: doublyList3.endIndex)/2)
print("Middle element:", doublyList3[midIndex])


// MARK: Binary Search
// Can  be used to find midpoints, e.g., in a linked list or array:

// MARK: Generic Binary Search using distance and index(_:offsetBy:)
// O(log n) for RandomAccessCollection
func binarySearch<C: RandomAccessCollection>(
    _ collection: C,
    target: C.Element
) -> C.Index? where C.Element: Comparable {
    
    var start = collection.startIndex
    var end = collection.endIndex
    
    while start < end {
        let midOffset = collection.distance(from: start, to: end) / 2
        let mid = collection.index(start, offsetBy: midOffset)
        
        if collection[mid] == target {
            return mid
        } else if collection[mid] < target {
            start = collection.index(after: mid)
        } else {
            end = mid
        }
    }
    return nil
}


// MARK: Find target in array

let numbersArr = [10, 20, 30, 40, 50, 60, 70, 80, 90]

if let index = binarySearch(numbersArr, target: 50) {
    print("Found 50 at index:", index)
} else {
    print("50 not found")
}

if let index = binarySearch(numbersArr, target: 25) {
    print("Found 25 at index:", index)
} else {
    print("25 not found")
}

// MARK: Searching in an array of strings

let fruits = ["apple", "banana", "cherry", "date", "fig"]
if let index = binarySearch(fruits, target: "cherry") {
    print("Found cherry at index:", index) // 2
}


// MARK: Searching in an array slice

let arr = [1, 3, 5, 7, 9, 11, 13]
let slice = arr[2..<6] // [5, 7, 9, 11]

if let index = binarySearch(slice, target: 9) {
    print("Found 9 at slice index:", index) // 4 (index relative to original array)
}
