# NewsAPI_Model

---

## Project Overview
This subproject explores the [NewsAPI](https://newsapi.org/docs) by building a SwiftUI app that fetches, decodes, and displays live news data.  
The goal is to practice working with REST APIs in Swift, handling asynchronous requests with `async/await`, and presenting structured article data in a clean, interactive UI.

---

## Technologies Used
- **Swift** (latest stable version)  
- **SwiftUI**  
- **Xcode** (latest stable version)  
- `URLSession` with **async/await** for API requests  
- `Codable` for JSON decoding  
- **APIKey** for API access  

---

## Features
- 🔎 Searchable queries for top headlines and keyword-based results  
- 🌍 Explore news by country, category, or source  
- 📰 SwiftUI views for displaying article headlines, descriptions, and links  
- 📱 Adaptive layout for iPhone/iPad  
- ♿ Accessibility support with Dynamic Type, VoiceOver labels, and semantic UI components   

---

## Why This Challenge?
Working with NewsAPI provides an opportunity to:
- Practice integrating a real-world REST API into a SwiftUI app  
- Experiment with different request parameters (sources, categories, keywords)  
- Handle dynamic and sometimes inconsistent API data gracefully  
- Build a custom search bar to query endpoints interactively  
- Implement pagination with infinite scrolling for smoother content browsing  
- Design SwiftUI views that adapt to live, ever-changing content  

---

## What I Learned

* How to structure models with `Codable` for decoding nested JSON responses
* Using `async/await` with `URLSession` for cleaner and safer network calls
* Error handling for network failures and invalid responses
* Building reusable SwiftUI components for list-based content
* Implementing `matchedGeometryEffect` for smooth card-to-detail animations
* Adding drag-to-dismiss interactions for full-screen overlays
* Managing consistent corner radius and slide animations without flashing
* Improving accessibility and color consistency across all News-related views

---

## What I Would Do Differently

* Add caching for offline article access
* Improve error handling with user-friendly alerts
* Integrate image loading with `AsyncImage` or a custom caching solution
* Expand filtering with multiple criteria (e.g., keyword + category)
* Possibly explore pagination for loading more results
* Refactor overlay/gesture logic further for even smoother performance
* Consider theming to dynamically adjust colors based on user settings

---

## App Showcase

### All News View

- A scrollable feed displaying all articles with a clean, card-style layout.

- Users can tap on any article to expand it into a detailed view.

![All News View](https://github.com/user-attachments/assets/e9519729-1d19-455f-8f8c-5f41e2010c3a)

### Top Headline News View

- Shows curated top headlines for quick access to the most important news.

- Supports the same smooth card-to-detail interaction as the main feed.

![Top Headline News View](https://github.com/user-attachments/assets/98ea1eb7-3820-4e94-9a86-dec9db1199b0)


### News Detail View

- Expands a selected article with full content, images, and additional metadata.

- Features smooth matched geometry animation, swipe-to-dismiss sliding, and consistent corner radius.

![News Detail View](https://github.com/user-attachments/assets/ed46a49b-c23f-432c-905a-83b914d386bb)

---
