# SwiftGymTracker

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

**SwiftGymTracker** is a lightweight fitness tracking app built with **SwiftUI** and **SwiftData**, designed to help users log and manage their workouts.

It allows users to:

* Add and edit **workouts** with dates and notes
* Attach multiple **exercises** (sets, reps, weights) per workout
* Automatically **sync progress across devices** with **CloudKit**

This project was built as a **capstone** to solidify my understanding of **data modeling**, **relationships**, and **CloudKit sync** in SwiftData before moving on to networking-focused projects.

---

## Technologies Used

| Technology                                 | Purpose                                                    |
| ------------------------------------------ | ---------------------------------------------------------- |
| **SwiftUI**                                | Declarative UI framework for modern iOS interfaces         |
| **SwiftData**                              | Apple’s ORM-like persistence layer for local model storage |
| **CloudKit**                               | Enables seamless data sync across iCloud-connected devices |
| **MVVM Architecture**                      | Separates UI from logic and data management                |
| **Swift Charts (optional)**                | Visualizes progress and workout trends                     |
| **Xcode Preprocessor Flags (`#if DEBUG`)** | Handles dev vs prod stores for testing                     |

---

## Features

* Add / Edit / Delete workouts
* Add exercises under each workout (sets, reps, weight)
* Auto-sync data between devices via iCloud
* Modern SwiftUI interface using reusable views
* SwiftData relationships (Workout ↔ Exercise)
* (Optional) Track total lifted weight over time with charts

---

## Why This Challenge?

I wanted a **real-world data-driven project** that went beyond simple CRUD — something that would:

* Reinforce **SwiftData relationships** and **delete rules**
* Teach how to **debug CloudKit sync issues**
* Prepare me for scaling real apps that persist and sync user data

It’s also a **perfect transition point** before diving into networking, since CloudKit introduces async syncing concepts similar to server-based APIs.

<!------->
<!---->
<!--## What I Learned-->
<!---->
<!--📘 **SwiftData Core Concepts**-->
<!---->
<!--* How to model `@Model` relationships and cascade deletes-->
<!--* Using `@Query` and predicates for dynamic data filtering-->
<!---->
<!--☁️ **CloudKit Sync**-->
<!---->
<!--* Setting up iCloud containers in Xcode-->
<!--* Handling sync delays and local caching-->
<!---->
<!--🎨 **SwiftUI Architecture**-->
<!---->
<!--* Clean MVVM separation-->
<!--* Reusable components (`WorkoutCardView`, `ExerciseRowView`)-->
<!--* Handling sheet presentations and navigation stacks-->
<!---->
<!--🧩 **Dev vs Prod Config**-->
<!---->
<!--* Using `#if DEBUG` for an in-memory store during testing-->
<!--* Switching to persistent CloudKit-enabled store in production-->
<!---->
<!------->
<!---->
<!--## What I Would Do Differently-->
<!---->
<!--* Add **error handling** and **loading states** for CloudKit sync-->
<!--* Improve **data visualization** with charts and summaries-->
<!--* Explore **CloudKit sharing** for multi-user workout tracking-->
<!--* Implement a **unit testing suite** for data and logic-->
<!---->
<!------->
<!---->
<!--## App Showcase-->
<!---->
<!---->
<!--### Snippet List-->
<!---->
<!--Browse all your saved snippets in a clean, scrollable list. Each snippet shows the **title**, **programming language**, and **creation date** for quick reference. Swipe to delete snippets or tap on a snippet to view details.-->
<!---->
<!--![Snippet List](https://github.com/user-attachments/assets/dd290076-0c72-45bb-bd2f-387c1c3c72c5)-->
<!---->
