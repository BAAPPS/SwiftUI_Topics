# RemoteAPIs

---

## Project Overview

This folder contains mini-projects focused on working with **remote APIs** in SwiftUI.
Each project demonstrates how to **fetch, decode, and display data** from various APIs while practicing **networking, data modeling, and error handling**.

The goal is to gain confidence with:

* **`URLSession`** for network requests
* **Async/Await** for modern concurrency
* **`Codable`** for decoding JSON into strongly-typed Swift models
* Designing **robust data models** that map to API schemas

By the end, you'll be able to adapt your models and networking logic to any REST API structure.

---

## Technologies Used

* **Swift** (latest stable version)
* **SwiftUI** for building dynamic interfaces
* **Xcode** (latest stable version)
* **`URLSession`** for networking
* **`Codable`** & **`Decodable`** for JSON mapping
* **Async/Await** for asynchronous tasks
* **OAuth2 / API Key Authentication** depending on API requirements

---

## Sub-Projects

Each sub-project focuses on a specific API to practice **data modeling and networking patterns**:

* [IGDBAPI\_Model](./IGDBAPI_Model) → Explore the [IGDB (Internet Games Database) API](https://api-docs.igdb.com/#examples) for games, companies, and platforms. Includes authentication with OAuth2, nested JSON models, and filtering.

* [NewsAPI\_Model](./NewsAPI_Model) → Fetch and display news articles using the [NewsAPI](https://newsapi.org/docs). Practice modeling articles, sources, and optional fields.

* [Coverr\_Model](./Coverr_Model) → Fetch video assets from the [Coverr API](https://api.coverr.co/docs), model categories and video metadata, and display previews in SwiftUI.

<!--- [RAWGAPI_Model](./RAWGAPI_Model) → Explore the [RAWG Video Games Database API](https://rawg.io/apidocs) for games, genres, and platforms -->
---

## Why This Challenge?

Working with remote APIs teaches you how to:

* Interpret and navigate **API documentation**
* Build **data models** that match complex JSON schemas
* Handle **authentication**, **rate limits**, and **error responses**
* Work with **optional or missing fields** safely
* Create **scalable networking layers** for future projects

This experience is essential for building **real-world SwiftUI apps** that rely on external data sources.

---

## What I Learned (General Takeaways)

* How to structure **data models** to match remote JSON
* Handling **nested JSON** and arrays of objects
* Proper **decoding strategies** for optional or dynamic fields
* Implementing **async network requests** with proper error handling
* Mapping API data to **SwiftUI views** efficiently
* Best practices for **clean, reusable networking and model code**

---
