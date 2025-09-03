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

---

## What I Would Do Differently

---
