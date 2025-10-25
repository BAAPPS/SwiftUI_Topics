import Cocoa

// MARK: - split(separator:maxSplits:omittingEmptySubsequences:)
// Splits a collection into subsequences, separated by a given element.
// O(n), where n is the length of the collection.

let goal = "To get good at Swift,  I will practice and practice everyday"

let splitGoal = goal.split(separator: " ")
print(splitGoal)
// ["To", "get", "good", "at", "Swift,", "I", "will", "practice", "and", "practice", "everyday"]

let splitGoalMaxSplits = goal.split(separator: " ", maxSplits: 2)
print(splitGoalMaxSplits)
// ["To", "get", "good at Swift, I will practice and practice everyday"]

let splitGoalOmit = goal.split(separator: " ", omittingEmptySubsequences: false)
print(splitGoalOmit)
// ["To", "get", "good", "at", "Swift,", "", "I", "will", "practice", "and", "practice", "everyday"]

// MARK: - split(maxSplits:omittingEmptySubsequences:whereSeparator:)
// Splits a collection into subsequences around elements that satisfy a predicate.
// O(n), where n is the length of the collection.

print(goal.split(whereSeparator: { $0 == "," }))
// ["To get good at Swift", "  I will practice and practice everyday"]

// MARK: - joined()
// Concatenates the elements of a sequence of sequences into a single sequence.

let ranges = [0..<4, 7..<10, 12..<17]
for index in ranges.joined() where index % 2 == 0 {
    print(index, terminator: " ")
}

// MARK: - joined(separator:)
// Concatenates the elements of a sequence of sequences, inserting a separator between each.

let cast = ["Vivien", "Marlon", "Kim", "Karl"]
let list = cast.joined(separator: ", ")
print(list) // "Vivien, Marlon, Kim, Karl"

// Joining array of Int with [Int] instances
let nestedNumbers = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
let joined = nestedNumbers.joined(separator: [-1])
print(Array(joined)) // [1, 2, 3, -1, 4, 5, 6, -1, 7, 8, 9]

