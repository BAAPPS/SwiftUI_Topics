# Swift Codable

This playground demonstrates how to encode and decode custom Swift types using `Codable`, `Encodable`, and `Decodable`. It covers both **automatic synthesis** and **manual implementations** for custom behavior.

---

## Table of Contents

1. [Overview](#overview)
2. [Automatic Encoding with Codable](#automatic-encoding-with-codable)
3. [Automatic Decoding with Codable](#automatic-decoding-with-codable)
4. [Manual `encode(to:)` Implementation](#manual-encodeto-implementation)
5. [Manual `init(from:)` Implementation](#manual-initfrom-implementation)
6. [Key Takeaways](#key-takeaways)

---

## Overview

Swift’s `Codable` protocol is a combination of `Encodable` and `Decodable`. It allows conversion of custom types into external representations such as JSON and back.  

- **Encodable**: Defines how to convert your type into an external representation.  
- **Decodable**: Defines how to create your type from an external representation.  
- **Codable**: Combines both protocols for two-way serialization.

---

## Automatic Encoding with Codable

Swift can automatically generate `encode(to:)` for most types that conform to `Codable`.

```swift
struct User: Codable {
    let id: Int
    let name: String
}

let user = User(id: 1, name: "Alice")

do {
    let jsonData = try JSONEncoder().encode(user)
    let jsonString = String(data: jsonData, encoding: .utf8)!
    print("Automatic encoding:", jsonString) // {"id":1,"name":"Alice"}
} catch {
    print("Encoding failed:", error)
}
````

* **Benefit**: No need to write custom encoding logic for simple types.
* **Output**: JSON string with all properties.

---

## Automatic Decoding with Codable

Similarly, Swift automatically generates `init(from:)` for decoding JSON into your type.

```swift
do {
    let decodedUser = try JSONDecoder().decode(User.self, from: jsonData)
    print("Decoded user:", decodedUser.name) // Alice
} catch {
    print("Decoding failed:", error)
}
```

* **Benefit**: Simplifies deserialization for most straightforward types.
* **Requirement**: JSON keys must match property names, and types must match.

---

## Manual `encode(to:)` Implementation

Manual `encode(to:)` is useful when you need:

* Transformations (e.g., uppercase names)
* Ignoring properties
* Custom key names

```swift
struct Users: Encodable {
    let id: Int
    let name: String
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name.uppercased(), forKey: .name) // transform example
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

let users = Users(id: 2, name: "Bob")

do {
    let encodedData = try JSONEncoder().encode(users)
    let encodedString = String(data: encodedData, encoding: .utf8)!
    print("Manual encoding with transform:", encodedString) // {"id":2,"name":"BOB"}
} catch {
    print("Encoding failed:", error)
}
```

---

## Manual `init(from:)` Implementation

Manual decoding allows you to customize how JSON is parsed into your type:

```swift
struct Users2: Decodable {
    let id: Int
    let name: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        
        // Transform name to uppercase while decoding
        let rawName = try container.decode(String.self, forKey: .name)
        name = rawName.uppercased()
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

let jsonString2 = """
{
    "id": 2,
    "name": "Bob"
}
"""
let jsonData2 = jsonString2.data(using: .utf8)!

do {
    let customDecodedUser = try JSONDecoder().decode(Users2.self, from: jsonData2)
    print("Decoded user (manual transform):", customDecodedUser.name) // BOB
} catch {
    print("Custom decoding failed:", error)
}
```

* **Use case**: Validate or transform data during decoding.
* **Output**: Transformed properties (e.g., uppercase names).

---

## Key Takeaways

1. `Codable` simplifies encoding/decoding for most types.
2. Manual `encode(to:)` and `init(from:)` give you full control over serialization and deserialization.
3. Always handle errors using `do-catch` or `try?` for safety.
4. Combining `Encodable` and `Decodable` allows full round-trip conversion between JSON and Swift objects.
5. Useful for networking, persistence, and data interchange.



