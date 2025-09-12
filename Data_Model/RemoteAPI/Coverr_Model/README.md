# Coverr_Model

---

## Project Overview

`Coverr_Model` is a learning-focused Swift project that integrates with the [Coverr Video API](https://api.coverr.co/docs).  
The main goal is to practice **data modeling**, **decoding JSON responses**, and **working with API keys** in a real-world SwiftUI app environment.  

The app fetches video metadata from the Coverr API (titles, descriptions, thumbnails, tags, etc.) and displays it in a simple SwiftUI interface. This project emphasizes **understanding API-driven workflows** while writing clean, robust models.

---

## Technologies Used
- **Swift** (latest stable version)  
- **SwiftUI** for the user interface  
- **Xcode** (latest stable version)  
- **URLSession** with `async/await` for API requests  
- **Codable** for JSON decoding  
- **API Key authentication** for Coverr API access  
- **SwiftData (optional)** for persistence and experimenting with data storage  

---

## Features
- 🔑 Securely use an API key with the Coverr API  
- 🌐 Fetch a list of videos based on search queries  
- 🖼 Display video thumbnails, titles, and metadata in a SwiftUI list or grid  
- 📄 Decode paginated JSON responses (with nested fields)  
- ⏳ Handle loading states and errors gracefully  
- 🗂 Example models for practicing SwiftData integration  

---

## Why This Challenge?
Most tutorials stick to “fake” APIs (like JSONPlaceholder). By using **Coverr’s real API with API keys**, I get hands-on practice with:  
- Handling authentication in requests  
- Decoding **nested, optional JSON fields**  
- Managing **paginated results**  
- Practicing **secure key storage** (e.g. Info.plist, environment variables)  

This helps bridge the gap between toy examples and **real-world app development**.

<!------->
<!---->
<!--## What I Learned-->
<!--- How to store and access an **API key** securely in a Swift project  -->
<!--- How to design `Codable` models for complex JSON responses  -->
<!--- Using `async/await` with `URLSession` for cleaner networking code  -->
<!--- Error handling for failed requests, missing fields, or invalid JSON  -->
<!--- How pagination works in REST APIs and how to model it  -->
<!--- Basic **SwiftData integration** for storing API results locally  -->
<!---->
<!------->
<!---->
<!--## What I Would Do Differently-->
<!--- Add **caching** for thumbnails and video metadata to improve performance  -->
<!--- Implement a **search UI** with debouncing for smoother user experience  -->
<!--- Expand error handling (e.g. rate limits, expired keys)  -->
<!--- Explore building a **video detail view** that plays the Coverr video inline  -->
<!--- Eventually abstract networking into a reusable service layer for testing  -->
<!---->
<!------->


<!--## App Showcase-->
<!---->
<!--### All News View-->
<!---->
<!--- A scrollable feed displaying all articles with a clean, card-style layout.-->
<!---->
<!--- Users can tap on any article to expand it into a detailed view.-->
<!---->
<!--![All News View](https://github.com/user-attachments/assets/e9519729-1d19-455f-8f8c-5f41e2010c3a)-->
<!---->
<!--### Top Headline News View-->
<!---->
<!--- Shows curated top headlines for quick access to the most important news.-->
<!---->
<!--- Supports the same smooth card-to-detail interaction as the main feed.-->
<!---->
<!--![Top Headline News View](https://github.com/user-attachments/assets/98ea1eb7-3820-4e94-9a86-dec9db1199b0)-->
<!---->
<!---->
<!--### News Detail View-->
<!---->
<!--- Expands a selected article with full content, images, and additional metadata.-->
<!---->
<!--- Features smooth matched geometry animation, swipe-to-dismiss sliding, and consistent corner radius.-->
<!---->
<!--![News Detail View](https://github.com/user-attachments/assets/ed46a49b-c23f-432c-905a-83b914d386bb)-->

