# IGDBAPI_Model

---

## Project Overview
This project explores working with the [IGDB (Internet Games Database) API](https://api-docs.igdb.com/#examples) to fetch and model video game data.  
The focus is on building **Swift data models** that can handle IGDB’s **complex, nested JSON responses**, and then displaying that data in SwiftUI views.  

This project demonstrates how to connect to a real-world API that requires **OAuth authentication**, parse the data, and present it in a user-friendly way.

---

## Technologies Used
- **Swift** (latest stable version)  
- **SwiftUI**  
- **Xcode** (latest stable version)  
- `URLSession` with **async/await** for API requests  
- `Codable` for JSON decoding  
- **OAuth 2.0 authentication** for API access  

---

## Features
- Authenticate with IGDB using OAuth 2.0 and client credentials  
- Fetch game data including:  
  - Game titles, cover art, and genres  
  - Release dates and platforms  
  - Developers and publishers  
- Decode deeply nested JSON into Swift models using `Codable`  
- Display data in **SwiftUI lists, grids, and detail views**  
- Handle optional and missing fields gracefully  
- Reusable SwiftUI components for clean UI structure  

---

## Why This Challenge?
This project provides hands-on experience with:

* Data modeling using real-world APIs and local JSON  
* Handling nested JSON structures and multiple related entities  
* SwiftUI layouts for dynamic and adaptive interfaces  
* Accessibility best practices and reusable UI components  
* Creating a smooth, interactive browsing experience similar to modern media apps  

---

## What I Learned

* How to **integrate a third-party API** with OAuth authentication in Swift.
* Techniques for **decoding complex, nested JSON** with optional fields.
* Building **dynamic SwiftUI layouts** including grids and lists.
* Using **reusable components** (`IconTextRow`, etc.) for clean code.
* Accessibility considerations for **VoiceOver** and screen readers.
* Managing **state and view updates** with `@Environment` and observable models.

---

## What I Would Do Differently

* Implement **caching** to reduce repeated network requests and improve performance.
* Add **pagination or infinite scrolling** for large game datasets.
* Use **SwiftData or CoreData** to persist game data locally.
* Refactor some components for **better modularity and testability**.
* Improve **error handling** and user feedback for network failures.

---

## App Showcase


### Games Grid View

- Explore all games in a 2x2 grid layout, showing cover art and titles.

![Games Grid View](https://github.com/user-attachments/assets/fe9413c3-94ea-459f-a21f-cf8a63d65ea2)


### Games List View

- Browse games in a scrollable list, with thumbnails and quick navigation.

![Games Grid View](https://github.com/user-attachments/assets/fd8dab82-59c7-4bfb-b589-84111a41a844)


### Games Details View

- View detailed information including cover, genres, release date, summary, and external link.

![Games Details View](https://github.com/user-attachments/assets/ae044b86-ce65-4533-aab1-8a65dba6ddc8)
