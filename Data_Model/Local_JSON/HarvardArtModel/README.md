# HarvardArtModel

---

## Project Overview

**HarvardArtModel** is a SwiftUI project that models and displays art data from the Harvard Art Museums API. The app decodes local JSON files representing art objects, including details such as title, artist, date, medium, and images. Users can browse artworks in a fullscreen layout and view detailed information for each piece.

---

## Technologies Used

* **Swift** (latest stable version)
* **SwiftUI**
* **Xcode** (latest stable version)
* Local JSON files (exported from Harvard Art Museums API)
* `Codable` protocol for encoding and decoding

---

## Features

* Decode and model art objects from JSON data
* Display artwork images in a responsive fullscreen layout (TikTok-like vertical scrolling)
* Show detailed information for selected artworks (title, artist, dates, format, and copyright)
* SwiftUI-based navigation with reusable components (`IconTextRow`, `SnapPagingView`)
* Accessibility-friendly design, including VoiceOver labels for images and buttons
* Handles optional data gracefully (e.g., missing dates or copyright information)

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

* How to structure a SwiftUI project with a clean MVVM-like approach
* Decoding JSON into Swift models, including handling optional and nested fields
* Implementing vertical paging with a custom `SnapPagingView`
* Creating reusable, accessible components like `IconTextRow`
* Managing environment objects with `@Observable` and `@Environment`
* Handling optional data elegantly in SwiftUI views

---

## What I Would Do Differently

* Fetch live data from the Harvard Art Museums API instead of using only local JSON
* Add caching and lazy image loading for performance with large datasets
* Implement search and filter options for artworks
* Add animations for smoother transitions and enhanced user experience
* Include more advanced accessibility features such as Dynamic Type support and improved VoiceOver hints

---

## App Showcase

Explore the app in action, highlighting its clean layout, fullscreen image browsing, and detailed information views:

* **Fullscreen Artwork Browsing**
  Vertical paging allows users to swipe through artwork images seamlessly.
  
![Fullscreen Artwork Browsing](https://github.com/user-attachments/assets/8ef8e216-486d-4b68-8a2a-183ef61be48a)

* **Detailed Artwork View**
  Tap the info button to see full artwork details, including title, artist, format, dates, and copyright. All components are accessible and readable by VoiceOver.


![Detailed Artwork View](https://github.com/user-attachments/assets/41d80d2a-5b07-4738-9535-6a6029b45511)

* **Accessible Components**
  Reusable components like `IconTextRow` make the app easier to maintain and fully accessible.

