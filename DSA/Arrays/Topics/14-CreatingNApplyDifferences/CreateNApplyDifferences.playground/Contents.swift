import Cocoa

// MARK: - applying(_:)
// Applies the given difference to this collection.
// O(n + c), where n is self.count and c is the number of changes contained by the parameter.

let oldArray = ["A", "B", "C"]
let newArray = ["A", "C", "D"]

// Compute the difference between the two arrays
let difference = newArray.difference(from: oldArray)

// Apply that difference to the original
if let updated = oldArray.applying(difference) {
    print(updated) // ["A", "C", "D"]
}

let numArrayOld: [Int] = [1, 2, 3, 4, 5]
let numArrayNew: [Int] = [1, 3, 4, 6, 5]

let numDifference = numArrayNew.difference(from: numArrayOld)

if let numUpdated = numArrayOld.applying(numDifference) {
    print("Reconstructed:" , numUpdated)
}

// MARK: - difference(from:)
// Returns the difference needed to produce this collection’s ordered elements from the given collection.
// Worst case performance is O(n * m), where n is the count of this collection and m is other.count. You can expect faster execution when the collections share many common elements, or if Element conforms to Hashable.

let oldArrayDifference = oldArray.difference(from: newArray)

print(oldArrayDifference)

// MARK: - difference(from:by:)
// Returns the difference needed to produce this collection’s ordered elements from the given collection, using the given predicate as an equivalence test.
// Worst case performance is O(n * m), where n is the count of this collection and m is other.count. You can expect faster execution when the collections share many common elements.

struct User: CustomStringConvertible {
    let id: Int
    let name: String
    
    var description: String { "(\(id), \(name))" }
}

let oldUsers = [
    User(id: 1, name: "Alice"),
    User(id: 2, name: "Bob"),
    User(id: 3, name: "Charlie")
]

let newUsers = [
    User(id: 1, name: "Alice A."),   // name changed
    User(id: 3, name: "Charlie"),
    User(id: 4, name: "Diana")
]

let newUsers2 = [
    User(id: 1, name: "Alice A."),
    User(id: 2, name: "Bob"),
    User(id: 3, name: "Charlie"),
    User(id: 4, name: "Diana")
]


let diff = newUsers.difference(from: oldUsers) { $0.id == $1.id }
print(diff)

let userNameChanged = newUsers2.difference(from: oldUsers) {$0.name == $1.name}

for change in diff {
    switch change {
    case .insert(let offset, let element, _):
        print("Inserted:", element.name, "at index", offset)
    case .remove(let offset, let element, _):
        print("Removed:", element.name, "at index", offset)
    }
}



if let updated = oldUsers.applying(diff) {
    print("Updated list:", updated.map(\.name))
}
// Output: ["Alice A.", "Charlie", "Diana"]


for change in userNameChanged {
    switch change {
    case .remove(_, let element, _):
        print("Old name removed:", element.name)
    case .insert(_, let element, _):
        print("New name inserted:", element.name)
    }
}

if let updatedUsername = oldUsers.applying(userNameChanged) {
    print("Username updated:", updatedUsername.map(\.name))
}
