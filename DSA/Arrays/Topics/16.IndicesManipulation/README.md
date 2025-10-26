# Swift Indices Manipulation 

This playground demonstrates **advanced Swift indexing**, including `startIndex`, `endIndex`, `index(after:)`, `index(before:)`, `formIndex`, `offsetBy`, `distance(from:to:)`, and practical applications in arrays, singly linked lists, and doubly linked lists. It also includes sliding window patterns, two-pointer techniques, and generic binary search.

---

## Table of Contents

1. [Array Indices](#array-indices)  

    1.1 [startIndex](#startindex)  
    
    1.2 [endIndex](#endindex)  
    
    1.3 [index(after:)](#indexafter)  
    
    1.4 [index(before:)](#indexbefore)  
    
    1.5 [index(_:offsetBy:)](#indexoffsetby) 
     
    1.6 [index(_:offsetBy:limitedBy:)](#indexoffsetbylimitedby) 
     
2. [Sliding Window with Index](#sliding-window-with-index)  

3. [FormIndex Usage](#formindex-usage)  

    3.1 [formIndex(after:)](#formindexafter)  
    
    3.2 [formIndex(before:)](#formindexbefore)  
    
    3.3 [Two-Pointer Technique](#two-pointer-technique) 
     
4. [Singly Linked List](#singly-linked-list)  

5. [Doubly Linked List](#doubly-linked-list)  

    5.1 [Bidirectional Traversal](#bidirectional-traversal)
      
    5.2 [Offset & Sliding Window](#offset-sliding-window) 
     
6. [Distance and Middle Element](#distance-and-middle-element) 

7. [Binary Search](#binary-search)  

---

## Array Indices

### startIndex
The position of the first element in a nonempty array.

```swift
let numbers = [10, 20, 30, 40, 50, 60, 80, 90, 100]
print(numbers.startIndex) // 0
````

### endIndex

The array’s “past the end” position.

```swift
if let i = numbers.firstIndex(of: 30) {
    print(numbers[i ..< numbers.endIndex]) // [30, 40, 50, 60, 80, 90, 100]
}
```

### index(after:)

Returns the position immediately after the given index.

```swift
if let i = numbers.firstIndex(of: 40) {
    print(numbers.index(after: i)) // 4
}
```

### index(before:)

Returns the position immediately before the given index.

```swift
if let i = numbers.firstIndex(of: 40){
    print(numbers.index(before: i)) // 2
}
```

### index(_:offsetBy:)

Returns an index offset by a specified distance.

```swift
let i = numbers.index(numbers.startIndex, offsetBy: 4)
print(numbers[i]) // 50
```

### index(_:offsetBy:limitedBy:)

Offsets index but respects a limiting index.

```swift
if let k = numbers.index(numbers.startIndex, offsetBy: 10, limitedBy: numbers.endIndex) {
    print(numbers[k]) // nil
}

if let j = numbers.index(numbers.startIndex, offsetBy: 6, limitedBy: numbers.endIndex){
    print(numbers[j ]) // 80
}
```

---

## Sliding Window with index(_:offsetBy:limitedBy:)

```swift
var startIndex = numbers.startIndex
let windowSize = 4
while true {
    if let endIndex = numbers.index(startIndex, offsetBy: windowSize, limitedBy: numbers.endIndex) {
        let window = numbers[startIndex..<endIndex]
        print("Window:", Array(window))
        if endIndex == numbers.endIndex { break }
        startIndex = numbers.index(after: startIndex)
    }
}
```

**Complexity:** O(n)

---

## formIndex Usage

### formIndex(after:)

Advances an index in place.

```swift
var index = numbers.startIndex
numbers.formIndex(after: &index)
print(numbers[index]) // 20
```

### formIndex(before:)

Moves an index backward, useful for reverse traversal.

```swift
var formIndexB = numbers.endIndex
numbers.formIndex(before: &formIndexB)

while formIndexB > numbers.startIndex {
    print(numbers[formIndexB])
    numbers.formIndex(before: &formIndexB)
}
```

### Two-Pointer Technique

Find pairs in a sorted array that sum to a target.

```swift
let target = 100
var left = numbers.startIndex
var right = numbers.index(before: numbers.endIndex)

while left < right {
    let sum = numbers[left] + numbers[right]
    if sum == target {
        print("(\(numbers[left]), \(numbers[right]))")
        numbers.formIndex(after: &left)
        numbers.formIndex(before: &right)
    } else if sum < target {
        numbers.formIndex(after: &left)
    } else {
        numbers.formIndex(before: &right)
    }
}
```

---

## Singly Linked List

```swift
final class Node<Element> {
    var value: Element
    var next: Node<Element>?
    init(_ value: Element, next: Node<Element>? = nil) {
        self.value = value
        self.next = next
    }
}

struct LinkedList<Element>: Collection {
    struct Index: Comparable {
        fileprivate var node: Node<Element>?
        static func == (lhs: Index, rhs: Index) -> Bool { lhs.node === rhs.node }
        static func < (lhs: Index, rhs: Index) -> Bool { lhs.node !== rhs.node }
    }
    
    private var head: Node<Element>?
    private var tail: Node<Element>?
    
    init() {}
    
    mutating func append(_ value: Element) {
        let newNode = Node(value)
        if let tailNode = tail {
            tailNode.next = newNode
        } else { head = newNode }
        tail = newNode
    }
    
    var startIndex: Index { Index(node: head) }
    var endIndex: Index { Index(node: nil) }
    
    func index(after i: Index) -> Index { Index(node: i.node?.next) }
    func formIndex(after i: inout Index) { i.node = i.node?.next }
    func formIndex(before i: inout Index) {
        i.node = i.node?.next // forward-only for singly linked list
    }
    
    subscript(position: Index) -> Element { position.node!.value }
}
```

---

## Doubly Linked List

### Node & List Definition

```swift
final class DoublyNode<Element> {
    var value: Element
    var next: DoublyNode?
    weak var previous: DoublyNode?
    init(value: Element) { self.value = value }
}

struct DoublyLinkedList<Element> {
    private var head: DoublyNode<Element>?
    private var tail: DoublyNode<Element>?
    
    init(_ elements: [Element]) {
        for element in elements { append(element) }
    }
    
    mutating func append(_ value: Element) {
        let newNode = DoublyNode(value: value)
        if let tail = tail {
            tail.next = newNode
            newNode.previous = tail
            self.tail = newNode
        } else { head = newNode; tail = newNode }
    }
}
```

### Bidirectional Traversal

```swift
extension DoublyLinkedList: BidirectionalCollection {
    struct Index: Comparable {
        var node: DoublyNode<Element>?
        static func == (lhs: Index, rhs: Index) -> Bool { lhs.node === rhs.node }
        static func < (lhs: Index, rhs: Index) -> Bool {
            var current = lhs.node
            while let next = current?.next {
                if next === rhs.node { return true }
                current = next
            }
            return false
        }
    }
    
    var startIndex: Index { Index(node: head) }
    var endIndex: Index { Index(node: nil) }
    
    func index(after i: Index) -> Index { Index(node: i.node?.next) }
    func index(before i: Index) -> Index { i.node?.previous.map { Index(node: $0) } ?? Index(node: tail) }
    func formIndex(after i: inout Index) { i.node = i.node?.next }
    func formIndex(before i: inout Index) { i.node = i.node?.previous ?? tail }
    
    func distance(from start: Index, to end: Index) -> Int {
        var current = start.node
        var count = 0
        while current !== end.node { current = current?.next; count += 1 }
        return count
    }
    
    subscript(position: Index) -> Element { position.node!.value }
}
```

---

### Sliding Window, Offset, Distance

```swift
var doublyList2 = DoublyLinkedList([10, 20, 30, 40, 50])
var index4 = doublyList2.startIndex
doublyList2.formIndex(&index4, offsetBy: 2)
print(doublyList2[index4]) // 30

var indexStart = doublyList2.startIndex
var indexEnd = indexStart
doublyList2.formIndex(&indexEnd, offsetBy: 3, limitedBy: doublyList2.endIndex)
print(Array(doublyList2[indexStart..<indexEnd])) // Window size 3
```

---

### Middle Element

```swift
let midIndex = doublyList2.index(doublyList2.startIndex,
                                 offsetBy: doublyList2.distance(from: doublyList2.startIndex, to: doublyList2.endIndex)/2)
print("Middle element:", doublyList2[midIndex])
```

**Time complexity:** O(n) for linked list, O(1) for arrays.

---

### Binary Search

```swift
func binarySearch<C: RandomAccessCollection>(_ collection: C, target: C.Element) -> C.Index? where C.Element: Comparable {
    var start = collection.startIndex
    var end = collection.endIndex
    while start < end {
        let midOffset = collection.distance(from: start, to: end) / 2
        let mid = collection.index(start, offsetBy: midOffset)
        if collection[mid] == target { return mid }
        else if collection[mid] < target { start = collection.index(after: mid) }
        else { end = mid }
    }
    return nil
}
```

**Usage Examples:**

```swift
let numbersArr = [10, 20, 30, 40, 50, 60, 70, 80, 90]
binarySearch(numbersArr, target: 50) // Found at index 4
binarySearch(numbersArr, target: 25) // nil
```

