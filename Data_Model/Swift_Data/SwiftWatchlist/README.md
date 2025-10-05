# SwiftWatchlist

A clean and modern iOS app built with **SwiftUI** and **SwiftData** that lets users track, organize, and manage their favorite movies — all in one place.


## Table of Contents

* [Project Overview](#project-overview)
* [Technologies Used](#technologies-used)
* [Features](#features)
* [Why This Challenge?](#why-this-challenge)
* [What I Learned](#what-i-learned)
* [What I Would Do Differently](#what-i-would-do-differently)
* [App Showcase](#app-showcase)

---

## Project Overview

**SwiftWatchlist** helps users build and manage a personal movie or TV show collection.
It was designed to explore **SwiftData persistence**, **MVVM architecture**, and **modern SwiftUI navigation patterns**, while maintaining a clean, minimal, and responsive interface.

The app serves as a playground for experimenting with:

* Persistent data models using SwiftData
* Dynamic navigation using `NavigationStack` and `navigationDestination()`
* Scalable SwiftUI view composition

---

## Technologies Used

| Technology            | Purpose                                                    |
| --------------------- | ---------------------------------------------------------- |
| **SwiftUI**           | Declarative UI framework for building modern iOS apps      |
| **SwiftData**         | Apple’s persistence framework for model-based storage      |
| **MVVM Architecture** | Clean separation of logic and presentation                 |
| **Kingfisher**        | Lightweight library for loading and caching remote images  |
| **Xcode 16+**         | Used for building, debugging, and previewing SwiftUI views |

---

## Features

### Add New Movie

Create and save a movie with title, release year, genres, and an optional review.

* Simple and accessible form layout
* Automatically persists with **SwiftData**
* Real-time updates in movie list upon saving

### Star Rating System

Rate movies on a scale of 0–10 and visualize them with a **star-based rating** in the detail view.

* Dynamic rating display in both list and detail views
* Optional review text input for personal notes

### Sort Movies

Toggle sorting between **ascending** and **descending** order by movie title.

* One-tap toolbar button to reorder the grid or list
* Animated transition between states for a smooth experience

### Switch Between Grid and List View

Easily switch your preferred layout view mode with a tap:

* Grid View → Visual, poster-first layout
* List View → Detailed textual layout with rating and release info


### Watchlist Tracking

Track what you’ve watched or plan to watch, categorized by **status**:

* “To Watch” and “Watched” sections
* Persistent data stored locally via SwiftData

---

## Why This Challenge?

I built **SwiftWatchlist** to strengthen my understanding of:

* Designing SwiftData models that reflect real-world relationships
* Applying **MVVM** to SwiftUI projects for scalability
* Creating adaptive UI layouts that respond to user state
* Managing **navigation and environment data** between multiple SwiftUI views

---

## What I Learned

* How to use **SwiftData** for local storage and reactive updates
* Structuring **environment-based view models** in SwiftUI
* Handling **`NavigationStack` scoping** to ensure destination consistency
* Designing custom data entry forms and managing focus states
* Designing Star Rating System

---

## What I Would Do Differently

* Implement search and filter features
* Add cloud sync support with **CloudKit**
* Expand to TV shows with episodic tracking
* Integrate TMDb API for auto-fetching poster and movie info

---

## App Showcase

Here’s a visual walkthrough of the core features in **SwiftWatchlist**:

### Add a New Movie

Quickly add movies with title, release year, genres, rating, etc.

![Add Movie View](https://github.com/user-attachments/assets/836a89e3-eb7a-4c91-adf9-e7c3511f94bc)


### Sort Movies

Toggle sorting order and switch between grid and list modes instantly.

![Sort and List View](https://github.com/user-attachments/assets/4c15ff48-2eef-4735-bb0d-60c3be6d3aff)

![Sort and Grid View](https://github.com/user-attachments/assets/ee9ed7ab-28c9-42b2-b7ba-83516e23324a)


### Watchlist

Track what you’ve completed and what’s next to watch.

![Watchlist View](https://github.com/user-attachments/assets/88161ac5-22cd-4845-9e97-afdec6d8747f)


### Movie Detail View

See the full details of your desired movie.


![Movie Detail View](https://github.com/user-attachments/assets/09bb3e37-3c79-4ee3-8027-f901ac5d27f2)
