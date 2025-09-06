# OpenLibraryModel

---

## Project Overview
This project explores working with **real-world JSON data** by importing a dataset from the [OpenLibrary](https://openlibrary.org/developers/api).  
Instead of generating mock data, I downloaded a JSON response from OpenLibrary’s API and bundled it as a **local JSON file** inside the app.  

The goal is to practice creating **Swift data models** that can decode and represent **complex, nested JSON structures**, preparing me for working with live APIs in the future.

---

## Technologies Used
- **Swift** (latest stable version)  
- **SwiftUI**  
- **Xcode** (latest stable version)  
- Local JSON files (exported from OpenLibrary API)  
- `Codable` protocol for encoding and decoding  

---

## Features
- Load a **locally stored JSON file** copied from OpenLibrary’s API  
- Decode data into **Swift structs** with multiple levels of nesting  
- Handle **optional values** gracefully (since OpenLibrary responses often omit fields)  
- Display book details (title, author, publish year, etc.) in a clean SwiftUI view  
- Showcase reusability by reusing the **JSON loading logic** from the `LocalJSONModel` project  

---

## Why This Challenge?
- Real API responses are often **messy, nested, and inconsistent**  
- OpenLibrary’s JSON is a great example of real-world complexity (arrays, dictionaries, optional keys)  
- Practicing locally removes the complexity of networking while still giving experience with authentic data  
- Builds directly on top of my previous project (`LocalJSONModel`), making the learning curve gradual  

---

## What I Learned

* **Decoding JSON into Swift models** using the `Codable` protocol and handling optional values.
* **Building reusable UI components** (e.g., `IconTextRow`, color extensions, and modifiers for navigation/back button).
* **Working with `LazyVGrid`** to display dynamic book data in a clean, scrollable grid layout.
* **Using Kingfisher (`KFImage`)** to efficiently load and cache remote images.
* **Accessibility best practices** in SwiftUI:

  * Adding meaningful `.accessibilityLabel` and `.accessibilityHint` values.
  * Using `.accessibilityHidden(true)` to reduce noise.
  * Structuring elements so VoiceOver reads them in a logical order.
  
* **Navigation in SwiftUI** with `NavigationLink(value:)` and `.navigationDestination(for:)` to keep code more declarative.
* **Custom styling**:

  * Defining a color palette in a `Color+Extensions.swift` file.
  * Creating reusable UI patterns like the book info rows and overlay buttons.
  
* **String manipulation** by extending `String` with a `titleCased()` method to ensure consistent capitalization.

---

## What I Would Do Differently

* **Centralize layout logic**: Instead of calculating `columnWidth` inline, move that to a helper or environment value for cleaner code.
* **Improve image handling**: Create a custom view for book covers with consistent aspect ratios, so the sizing logic isn’t repeated in multiple places.
* **More test coverage**: Add unit tests for JSON decoding (e.g., ensuring optional fields like `author_name` or `subtitle` are handled gracefully).
* **Error handling**: Show placeholder views when images fail to load or when fields like `subtitle` are missing.
* **Accessibility testing**: Run through the app with VoiceOver more extensively to fine-tune the order of elements and hints.
* **Scalability**: Refactor the ViewModels so they can handle larger datasets or support pagination from the OpenLibrary API.
* **Design consistency**: Store icons and spacing values in a design system file (instead of scattering throughout views).

