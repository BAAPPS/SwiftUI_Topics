# SwiftData

---

## Project Overview

This folder contains mini-projects focused on **working with SwiftData** in SwiftUI.
Each project demonstrates how to **model, persist, and query data locally** using Apple’s SwiftData framework.

The goal is to gain confidence with:

* **Defining SwiftData models** that represent your app’s data
* **Performing CRUD operations** (Create, Read, Update, Delete)
* Using **SwiftData relationships and queries** for nested and linked data
* **Integrating SwiftData with SwiftUI views** for reactive and dynamic interfaces

By the end, you’ll be able to build **fully local data-driven apps** with robust and maintainable data layers.

---

## Technologies Used

* **Swift** (latest stable version)
* **SwiftUI**
* **SwiftData** for local persistence
* **Xcode** (latest stable version)
* **@Model, @Attribute, @Relationship** property wrappers for modeling
* SwiftData **querying, filtering, and sorting APIs**
* SwiftUI **state management** with `@Query`, `@State`, and `@Observable`

---

## Sub-Projects

Each sub-project focuses on a specific type of local data modeling challenge:

* [SwiftNote](./SwiftNote) → Build a note-taking app with SwiftData. Practice creating **notes, categories, and tags**, handling relationships, and syncing data with SwiftUI lists and detail views.

* [SwiftWatchlist](./SwiftWatchlist) → Build a movie watchlist app with SwiftData. Practice modeling movies, genres, tags, and ratings, implementing MVVM architecture, and managing navigation with NavigationStack for viewing, sorting, and adding new movies.

* [SwiftSettingsManager](./SwiftSettingsManager) → Build an app-wide **settings manager** using SwiftData and SwiftUI. 

Practice:
    * Creating **user preferences** for theme, accent color, and font size.
    * Using **environment keys** to pass theme and accent color throughout the app.
    * Implementing **ThemedView<Content: View>** for dynamic UI theming.
    * Building a reusable **NavBarView<Content: View>** with customizable back button, dynamic title, and consistent styling.
    * Binding SwiftData-backed settings to **Pickers, Toggles, and Sliders**.
    * Applying **live UI updates** and app-wide theming without restarting the app.
    * Managing **accessibility** for all interactive controls.


* [SwiftDataCommerce](./SwiftDataCommerce) → Build a **shopping app** using SwiftData and SwiftUI.

Practice:
    * Modeling products, categories, ratings, carts, and cart items.
    * Implementing **ProductCardView** and **ProductDetailsView** with dynamic data.
    * Managing a **shopping cart** with quantity limits, total price, and swipe-to-delete actions.
    * Using **TabBarView** and **TabContentView** for navigation between Home and Cart.
    * Applying **MVVM architecture** with environment objects for shared state.
    * Handling **async images**, formatting prices, and displaying ratings.
    * Implementing **full accessibility** for VoiceOver across buttons, tabs, lists, and interactive controls.
    * Applying **live UI updates** and smooth animations for quantity changes and cart interactions.

---

## Why This Challenge?

SwiftData is the **future of local persistence** in SwiftUI apps. By working with SwiftData, you:

* Learn how to define **robust data models** with relationships
* Practice **CRUD operations** in a real SwiftUI app
* Handle **querying, filtering, and sorting** efficiently
* Understand how to **reactively bind local data to SwiftUI views**
* Lay the foundation for **offline-first or hybrid apps**

This experience is critical for building apps that require **structured local storage** without relying on Core Data boilerplate.

---

<!--## What I Learned (General Takeaways)-->
<!---->
<!--* How to design **scalable SwiftData models**-->
<!--* Using **relationships** to link entities (one-to-many, many-to-many)-->
<!--* Performing **CRUD operations** in SwiftUI with SwiftData-->
<!--* Binding **queries directly to SwiftUI views** for reactive updates-->
<!--* Handling **optional values, defaults, and data validation**-->
<!--* Best practices for **clean folder and model organization** in SwiftData projects-->
<!---->
<!------->
