# Arrays & ArrayUtils in Swift

This folder is dedicated to **learning and practicing Arrays in Swift**, along with creating a reusable **ArrayUtils** toolkit for common operations. It’s designed for both **learning Swift fundamentals** and **building mini projects** that reinforce array manipulation.

---

## 📑 Table of Contents

1. [Overview](#-overview)
<!--2. [Array Topics Toolkit](#-array-topics-toolkit)-->
<!--3. [Functional Patterns Covered](#-functional-patterns-covered)-->
<!--4. [Mini Project Ideas](#-mini-project-ideas)-->
<!--5. [Suggested Workflow](#-suggested-workflow)-->
<!--6. [Notes](#-notes)-->
<!--7. [References](#-references)-->

---

## 📌 Overview

**Arrays** are one of the most fundamental data structures in programming. In Swift, arrays are **ordered collections** of elements of the same type.

Key characteristics:

* Ordered: Elements are accessed by index
* Mutable / Immutable: `var` arrays can be modified, `let` arrays cannot
* Generic: Can store any type (`[Int]`, `[String]`, `[CustomClass]`)

This folder focuses on:

1. **Deep diving into array concepts**
2. **Practicing functional programming patterns**: `map`, `filter`, `reduce`, `sort`
3. **Building mini projects** to apply array utilities

<!------->
<!---->
<!--## 🛠Array Topics Toolkit-->
<!---->
<!--`ArrayUtils.swift` contains reusable Swift functions and extensions for arrays, including:-->
<!---->
<!--### Example Functions-->
<!---->
<!--```swift-->
<!--// Sum all elements-->
<!--func sum(_ array: [Int]) -> Int {-->
<!--    return array.reduce(0, +)-->
<!--}-->
<!---->
<!--// Filter even numbers-->
<!--func filterEven(_ array: [Int]) -> [Int] {-->
<!--    return array.filter { $0 % 2 == 0 }-->
<!--}-->
<!---->
<!--// Square all numbers-->
<!--func square(_ array: [Int]) -> [Int] {-->
<!--    return array.map { $0 * $0 }-->
<!--}-->
<!---->
<!--// Sort array ascending-->
<!--func sortAscending(_ array: [Int]) -> [Int] {-->
<!--    return array.sorted()-->
<!--}-->
<!---->
<!--// Find maximum-->
<!--func maxValue(_ array: [Int]) -> Int? {-->
<!--    return array.max()-->
<!--}-->
<!--```-->
<!---->
<!------->
<!---->
<!--### 📈 Functional Patterns Covered-->
<!---->
<!--| Pattern         | Purpose                               | Example                       |-->
<!--| --------------- | ------------------------------------- | ----------------------------- |-->
<!--| `map`           | Transform each element                | Square all numbers            |-->
<!--| `filter`        | Select elements by condition          | Keep only even numbers        |-->
<!--| `reduce`        | Aggregate values into a single result | Sum of all elements           |-->
<!--| `sorted`        | Sort arrays ascending/descending      | Order tasks by priority       |-->
<!--| `contains`      | Check if element exists               | Is 5 in array?                |-->
<!--| `first(where:)` | Find first element matching condition | First task with high priority |-->
<!---->
<!------->
<!---->
<!--## 🏗 Mini Project Ideas-->
<!---->
<!--| Project                    | What it Teaches                      | Swift + DSA Focus                         |-->
<!--| -------------------------- | ------------------------------------ | ----------------------------------------- |-->
<!--| **Task Filter & Sort App** | Filter, sort, map tasks              | Arrays, Dictionary, map/filter/reduce     |-->
<!--| **Number Stats Tracker**   | Sum, average, min, max, squares      | Arrays, functional patterns               |-->
<!--| **Flashcard Quiz Order**   | Shuffle, filter unanswered questions | Arrays, `shuffled()`, functional patterns |-->
<!---->
<!------->
<!---->
<!--## 📝 Suggested Workflow-->
<!---->
<!--1. **Playground Deep Dive**-->
<!---->
<!--   * Implement array operations and test functions-->
<!--   * Experiment with `map`, `filter`, `reduce`, and sorting-->
<!---->
<!--2. **Mini Project Implementation**-->
<!---->
<!--   * Apply the ArrayUtils functions in a small SwiftUI app-->
<!--   * Display results visually (e.g., task list or number stats)-->
<!---->
<!--3. **LeetCode / Practice Problems**-->
<!---->
<!--   * Start with Easy problems using arrays-->
<!--   * Apply `ArrayUtils` functions instead of writing new logic each time-->
<!---->
<!------->
<!---->
<!--## 🔧 Notes-->
<!---->
<!--* Arrays in Swift are **value types**, so mutations on copies don’t affect the original array unless declared as `inout` or using `var`-->
<!--* Combining functional patterns (`map` → `filter` → `reduce`) makes array processing concise and readable-->
<!--* Practicing arrays builds a **strong foundation** for more advanced topics like **Linked Lists, Stacks, Queues, and Graphs**-->
<!---->
<!------->
<!---->
<!--## 📚 References-->
<!---->
<!--* [Swift Array Documentation](https://developer.apple.com/documentation/swift/array)-->
<!--* [Hacking with Swift – Arrays](https://www.hackingwithswift.com/quick-start/swiftui/arrays)-->
<!--* [Swift by Sundell – Functional Array Methods](https://www.swiftbysundell.com/articles/functional-swift/)-->
<!---->
<!------->
<!---->
