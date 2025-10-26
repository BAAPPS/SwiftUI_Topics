import Cocoa


// MARK: - Automatic encode(to:) using Codable
// Swift automatically synthesizes encode(to:) for Codable types.
struct User: Codable {
    let id: Int
    let name: String
}

// MARK: Encoding example
let user = User(id: 1, name: "Alice")

do {
    let jsonData = try JSONEncoder().encode(user)
    let jsonString = String(data: jsonData, encoding: .utf8)!
    print("Automatic encoding:", jsonString) // {"id":1,"name":"Alice"}
    
    // MARK: Decoding example
    let decodedUser = try JSONDecoder().decode(User.self, from: jsonData)
    print("Decoded user:", decodedUser.name) // Alice
} catch {
    print("Error encoding/decoding:", error)
}

// MARK: - Manual encode(to:) implementation
// Use manual encode(to:) when you need custom behavior:
// - Transforming values
// - Ignoring properties
// - Renaming keys

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

// MARK: Key Takeaways
/*
 1. Codable automatically generates encode(to:) for most types.
 2. Manual encode(to:) is only necessary for custom transformations.
 3. Always handle errors with do-catch or try? for safety.
 4. Combine with Decodable to support full serialization and deserialization.
*/

// MARK: - Manual init(from:) Implementation
// Use manual init(from:) when you want custom decoding behavior
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
