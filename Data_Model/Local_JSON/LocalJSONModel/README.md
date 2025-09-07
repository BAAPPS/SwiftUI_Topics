# LocalJSONModel

---

## Project Overview

This project is a focused exploration of working with **local JSON files** in SwiftUI.
The goal is to practice **encoding and decoding JSON data**, creating **Swift data models**, and displaying the information in a SwiftUI view.

This mini-project serves as a foundation for understanding **data modeling**, which is essential for both local and networked data handling in iOS apps.

---

## Technologies Used

* **Swift** (latest stable version)
* **SwiftUI**
* **Xcode** (latest stable version)
* Local JSON files for mock data
* `Codable` protocol for encoding and decoding

---

## Features

* Load data from a **local JSON file** bundled with the app
* Decode JSON into **Swift structs**
* Display data dynamically in a **List or Grid view**
* Handle optional or missing data gracefully
* Modular and reusable data model structures

---

## Why This Challenge?

Working with local JSON files is a **core skill for iOS development** because:

* It helps you understand how data flows from a file into your app
* Teaches safe decoding with `Codable`
* Prepares you for working with **remote JSON APIs** later
* Encourages clean **data modeling practices**

---

## What I Learned

* How to **decode complex JSON structures** into Swift models using `Codable`.
* The importance of **creating reusable and type-safe data models**.
* Building **dynamic SwiftUI views** that adapt to variable data.
* Handling optional or missing data gracefully to prevent runtime crashes.
* How to **connect UI components** with data models while keeping code clean and modular.

---

## What I Would Do Differently

* Implement **pagination or lazy loading** for large JSON datasets.
* Add **error handling UI** to show messages when JSON decoding fails.
* Refactor the project to include **ViewModels** for better separation of concerns.
* Add **unit tests** for decoding and UI rendering to ensure stability.
* Include **filtering or searching** in the list/grid for better usability.

---

## App Showcase

### List View of Shows

Displays a **scrollable list** of TV shows with title, subtitle, and thumbnail.
Handles missing or optional data gracefully while keeping a clean layout.

![Shows List View](https://github.com/user-attachments/assets/3ab7d6a9-8fda-47d3-8ff0-20c62cfb0c05)

### Detailed Show View

Tapping a show opens a **detail view** with episodes, description, genres, and banner image.
Demonstrates modular components like `IconTextRow` and proper handling of optional fields.

![Detailed Show View](https://github.com/user-attachments/assets/07a39de9-6311-4f8c-a67e-082b9c658f4b)

