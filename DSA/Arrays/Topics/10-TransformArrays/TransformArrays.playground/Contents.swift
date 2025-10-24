import Cocoa

// MARK: - flatMap(_:)
// Flattens arrays or repeats elements
// O(n + m) where n = original array length, m = total elements in result

let numbersArrays = [[1], [2], [3], [4]]
let numbersArrayFlatted = numbersArrays.flatMap { $0 }
print("Flattened array:", numbersArrayFlatted) // [1, 2, 3, 4]

let numbersArrayRepeated = numbersArrayFlatted.flatMap { Array(repeating: $0, count: $0) }
print("Repeated elements:", numbersArrayRepeated) // [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]

// MARK: - compactMap(_:)
// Extract non-nil results from transformation
let usernamesArrayDict: [[String: Any]] = [
    ["id": 1, "username": "Tim"],
    ["id": 2, "username": "Timmy"],
    ["id": 3, "username": "Alex"],
    ["id": 4, "username": "Kevin"]
]

let usernames = usernamesArrayDict.compactMap { $0["username"] as? String }
print("Usernames:", usernames)

// MARK: - reduce(_:_:)
// Sliding window sums (O(n*k) naive)
func slidingWindowSum(_ array: [Int], _ windowSize: Int) -> [Int] {
    guard windowSize > 0, windowSize <= array.count else { return [] }
    var sums: [Int] = []
    for i in 0...(array.count - windowSize) {
        let window = array[i..<(i + windowSize)]
        sums.append(window.reduce(0, +))
    }
    return sums
}

// Optimized sliding window sums (O(n))
func slidingWindowOptimizedSum(_ array: [Int], _ windowSize: Int) -> [Int] {
    guard windowSize > 0, windowSize <= array.count else { return [] }
    var sums: [Int] = []
    var windowSum = array[0..<windowSize].reduce(0, +)
    sums.append(windowSum)
    
    for i in windowSize..<array.count {
        windowSum += array[i] - array[i - windowSize]
        sums.append(windowSum)
    }
    
    return sums
}

// Sliding window with custom step
func slidingWindowSumsStep(_ array: [Int], windowSize: Int, step: Int) -> [Int] {
    guard windowSize > 0, windowSize <= array.count else { return [] }
    var sums: [Int] = []
    var i = 0
    while i + windowSize <= array.count {
        let window = array[i..<(i + windowSize)]
        sums.append(window.reduce(0, +))
        i += step
    }
    return sums
}

// Examples
let nums = [1, 2, 3, 4, 5, 6]
print("Sliding window sum (size 3, step 2):", slidingWindowSumsStep(nums, windowSize: 3, step: 2))

// MARK: - reduce(into:_:)
// Frequency counts
let letters = "abracadabra"
let letterCount = letters.reduce(into: [Character: Int]()) { counts, letter in
    counts[letter, default: 0] += 1
}
print("Letter frequencies:", letterCount)

let numbers = [1, 2, 3, 4, 5, 2, 3, 1]
let numberFreq = numbers.reduce(into: [Int: Int]()) { counts, num in
    counts[num, default: 0] += 1
}
print("Number frequencies:", numberFreq)

// Grouping by a key
struct User { let name: String; let age: Int }
let usersArray = [User(name: "Alice", age: 20),
                  User(name: "Bob", age: 25),
                  User(name: "Charlie", age: 20)]

let groupedByAge = usersArray.reduce(into: [Int: [String]]()) { dict, user in
    dict[user.age, default: []].append(user.name)
}
print("Grouped by age:", groupedByAge)

// Transform + accumulate
let transformed = numbers.reduce(into: []) { arr, n in
    if n % 2 == 0 { arr.append(n * 10) }
}
print("Transformed even numbers:", transformed)

// Transform and aggregate
let squares = numbers.reduce(into: [Int:Int]()) { dict, num in
    dict[num] = num * num
}
print("Squares:", squares)

// Dictionary from two arrays
let keys = ["a", "b", "c"]
let values = [1, 2, 3]
let dict = zip(keys, values).reduce(into: [String:Int]()) { d, pair in
    let (key, value) = pair
    d[key] = value
}
print("Zipped dictionary:", dict)

// Flattening nested arrays
let nested = [[1, 2], [3, 4], [5]]
let flat = nested.reduce(into: [Int]()) { result, arr in
    result.append(contentsOf: arr)
}
print("Flattened nested array:", flat)

// Counting pairs of elements
struct WordPair: Hashable, CustomStringConvertible {
    let word: String
    let length: Int
    var description: String { "(\(word), \(length))" }
}
let words = ["apple", "bat", "car", "apple", "bat"]
let pairCounts = words.reduce(into: [WordPair:Int]()) { counts, word in
    let pair = WordPair(word: word, length: word.count)
    counts[pair, default: 0] += 1
}
print("Word pairs count:", pairCounts)

// Grouping by computed key
let nums1 = [1, 2, 3, 4, 5, 6]
let groupedOddEven = nums1.reduce(into: [String: [Int]]()) { dict, num in
    let key = (num % 2 == 0) ? "even" : "odd"
    dict[key, default: []].append(num)
}
print("Grouped odd/even:", groupedOddEven)

// Nested grouping by first letter and length
struct FirstLetterLength: Hashable, CustomStringConvertible {
    let first: String
    let length: Int
    var description: String { "(\(first), \(length))" }
}
let words2 = ["apple", "bat", "banana", "ball", "ant"]
let nestedGrouped = words2.reduce(into: [FirstLetterLength: [String]]()) { dict, word in
    let key = FirstLetterLength(first: String(word.first!), length: word.count)
    dict[key, default: []].append(word)
}
print("Nested grouped:", nestedGrouped)

