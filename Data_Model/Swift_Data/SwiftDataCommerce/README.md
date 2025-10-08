
# SwiftDataCommerce

---

## Table of Contents

* [Project Overview](#project-overview)
* [Technologies Used](#technologies-used)
* [Features](#features)
* [Why This Challenge?](#why-this-challenge)
<!--* [What I Learned](#what-i-learned)-->
<!--* [What I Would Do Differently](#what-i-would-do-differently)-->
<!--* [App Showcase](#app-showcase)-->

---

## Project Overview

**SwiftDataCommerce** is a lightweight, offline-first e-commerce demo app built entirely with **SwiftUI** and **SwiftData**.
It simulates a full shopping experience — browsing products, adding items to a cart, and checking out — all powered by **locally stored JSON data** from the [FakeStore API](https://fakestoreapi.com/).

The goal of this project is to demonstrate **how to design real-world data relationships using SwiftData**, practice **modeling many-to-many and one-to-many relationships**, and learn **how to query, persist, and manage relational data** efficiently on-device.

This app doesn’t require an internet connection — it loads sample JSON into SwiftData on first launch, creating a fully local experience for experimenting with:

* SwiftData CRUD operations
* Query filtering, sorting, and aggregation
* Relationship management (`User`, `Product`, `CartItem`, `Order`)
* Offline persistence patterns

---

## Technologies Used

| Technology             | Purpose                                              |
| ---------------------- | ---------------------------------------------------- |
| **SwiftUI**            | Declarative UI framework for modern iOS interfaces   |
| **SwiftData**          | Apple’s ORM-like persistence layer for model storage |
| **FakeStore API JSON** | Realistic product data for local seeding             |
| **MVVM Architecture**  | Clean separation of business logic and presentation  |
| **Xcode Previews**     | Rapid iteration for UI and model testing             |

---

## Features

### Core Functionality

* **Product Browser** – Displays all products from locally stored FakeStore JSON
* **Cart System** – Add or remove items, track quantities, and calculate totals
* **User Profiles** – Each user maintains their own cart and order history
* **Order History** – Simulates checkout flow by converting cart items to completed orders
* **Offline-First Storage** – Works completely offline using SwiftData persistence

### Technical Highlights

* **One-to-Many and Many-to-Many Relationships**
  * `User` ↔ `CartItem` ↔ `Product`
  * `User` ↔ `Order` ↔ `OrderItem` ↔ `Product`
  
* **SwiftData Queries**
  * Sorting by price, filtering by user or category
  * Dynamic UI updates powered by `@Query`
  
* **Seeding Local Data**
  * Loads `products.json` from the bundle and persists it in SwiftData on first launch
  
* **Data Mutation**
  * Add, remove, or clear cart items with automatic persistence updates

---

## Why This Challenge?

I built **SwiftDataCommerce** to go beyond tutorials and **learn relational modeling hands-on**.
While many SwiftData examples focus on single-entity CRUD apps, I wanted to simulate a real database scenario that includes **relationships**, **data seeding**, and **offline persistence** — closer to what a production app would do.

The FakeStore dataset offered a great way to work with authentic e-commerce data without requiring a live API connection.
It also made it easier to test **decoding, seeding, and schema evolution** workflows.

---

<!--## What I Learned-->
<!---->
<!--* ✅ How to design **one-to-many** and **many-to-many** data models in SwiftData-->
<!--* ✅ How to decode remote JSON and seed it locally on first launch-->
<!--* ✅ How to use `@Query` with predicates and sorting for dynamic views-->
<!--* ✅ How to manage **delete rules**, **relationships**, and **context mutations**-->
<!--* ✅ How to create an **offline-first architecture** using SwiftData as the single source of truth-->
<!--* ✅ How to structure a modular SwiftUI + MVVM app for scalability-->
<!---->
<!------->
<!---->
<!--## What I Would Do Differently-->
<!---->
<!--* Implement **image caching** for better product loading performance-->
<!--* Add **pagination** and **search filtering** for large datasets-->
<!--* Introduce a **background sync system** to refresh data periodically-->
<!--* Add **schema migrations** to test SwiftData’s model versioning in real scenarios-->
<!--* Expand the system to support **multiple users** and authentication simulation-->
<!---->
<!------->
<!---->
<!--## App Showcase-->
<!---->
<!--### 🛒 Product Browser-->
<!---->
<!--Browse all locally stored FakeStore products with details and pricing.-->
<!---->
<!--![Product List](https://github.com/user-attachments/assets/abc12345-productlist)-->
<!---->
<!------->
<!---->
<!--### 🧍 User Cart-->
<!---->
<!--Add or remove products, adjust quantities, and view total price — all persisted automatically.-->
<!---->
<!--![Cart View](https://github.com/user-attachments/assets/def67890-cart)-->
<!---->
<!------->
<!---->
<!--### 📦 Order History-->
<!---->
<!--Simulate checkout flow, review past orders, and observe relational queries in action.-->
<!---->
<!--![Order History](https://github.com/user-attachments/assets/ghi90123-orders)-->
<!---->
<!------->
<!---->
<!--### 🎨 Theme Selection-->
<!---->
<!--Easily switch between **System**, **Light**, or **Dark** themes.-->
<!---->
<!--![Theme Selection](https://github.com/user-attachments/assets/7fee0957-fae8-447a-9fbc-4e147da6968d)-->
<!---->
