# Coverr_Model

---

## Project Overview

`Coverr_Model` is a learning-focused Swift project that integrates with the [Coverr Video API](https://api.coverr.co/docs).  
The main goal is to practice **data modeling**, **decoding JSON responses**, and **working with API keys** in a real-world SwiftUI app environment.  

The app fetches video metadata from the Coverr API (titles, descriptions, thumbnails, tags, etc.) and displays it in a simple SwiftUI interface. This project emphasizes **understanding API-driven workflows** while writing clean, robust models.  

> ⚠️ **Note:** This project is for personal learning and experimentation with the Coverr API and is **not intended for production use**.

---

## Technologies Used
- **Swift** (latest stable version)  
- **SwiftUI** for the user interface  
- **Xcode** (latest stable version)  
- **URLSession** with `async/await` for API requests  
- **Codable** for JSON decoding  
- **API Key authentication** for Coverr API access  
- **SwiftData (optional)** for persistence and experimenting with data storage  
- **NWPathMonitor (Network framework)** to monitor real-time network connectivity

---

## Features
- 🔑 Securely use an API key with the Coverr API  
- 🌐 Fetch a list of videos based on search queries  
- 🖼 Display video thumbnails, titles, and metadata in a SwiftUI list or grid  
- 📄 Decode paginated JSON responses (with nested fields)  
- ⏳ Handle loading states and errors gracefully  
- 🗂 Example models for practicing SwiftData integration  
- 📶 Network Awareness: Detect online/offline states using NWPathMonitor and handle gracefully

---

## Why This Challenge?
Most tutorials stick to “fake” APIs (like JSONPlaceholder). By using **Coverr’s real API with API keys**, I get hands-on practice with:  
- Handling authentication in requests  
- Decoding **nested, optional JSON fields**  
- Managing **paginated results**  
- Practicing **secure key storage** (e.g. Info.plist, environment variables)  

This helps bridge the gap between toy examples and **real-world app development**.

---

## What I Learned

* How to store and access an **API key** securely in a Swift project
* How to design `Codable` models for **complex, nested JSON responses**
* Using `async/await` with `URLSession` for cleaner and safer networking
* **Monitoring network connectivity** with `NWPathMonitor` and adapting UI accordingly
* Error handling for failed requests, missing fields, or invalid JSON
* How **pagination works** in REST APIs and how to model it effectively
* Basic **SwiftData integration** for storing API results locally
* Building a **TikTok-style vertical scrolling feed** for video content
* Creating a **custom tab bar** with icons, labels, and animated selection states

---

## What I Would Do Differently

* Add **caching** for thumbnails and video metadata to improve performance and reduce network usage
* Implement a **search UI with debouncing** for smoother user experience
* Expand error handling (e.g., API rate limits, expired keys, offline scenarios)
* Build a **video detail view** that plays Coverr videos inline
* Abstract networking into a **reusable service layer** for easier testing and maintainability
* Enhance the **TikTok-style feed** with smooth transitions, preloading, and pull-to-refresh
* Make the **custom tab bar** more reusable and visually polished across different screens


---

## App Showcase

### All Videos Tab – TikTok Style View

The primary feed displays videos in full-screen, vertical scrolling style (like TikTok). Users can swipe up or down to navigate between videos seamlessly.

![TikTok Style View](https://github.com/user-attachments/assets/3329e87e-b5aa-496c-b957-1e787faf3f4c)

### All Videos Tab – Minimized Style View

This view displays videos in a smaller, un-clipped format. It’s ideal for keeping the entire video visible.

![Minimized Style View](https://github.com/user-attachments/assets/a51f7d68-96ab-4b85-a22b-b8fa3409b9ca)


### Collections View

Organizes videos into curated collections. Users can browse collections and access all videos within a particular collection. This view also supports pagination and seamless video loading per collection.

![Collections View](https://github.com/user-attachments/assets/91131cd5-5e9d-4825-a6ac-dcf88aa3e812)

### Video Detail View

Displays detailed information about a selected video, including title, description, tags, etc. Accessible via the info button on each video.

![Video Detail View](https://github.com/user-attachments/assets/dd75bda7-d1be-4b27-9edf-22309bf8f948)

