# SwiftNote

---

## 📖 Table of Contents
- [Project Overview](#project-overview)
- [Technologies Used](#technologies-used)
- [Features](#features)
- [Why This Challenge?](#why-this-challenge)
- [What I Learned](#what-i-learned)
- [What I Would Do Differently](#what-i-would-do-differently)
- [App Showcase](#app-showcase)

---

## Project Overview

SwiftNote is a lightweight personal note-taking app built with **SwiftUI** and **SwiftData**.  
It is designed as a learning project to explore modern data modeling, persistence, and CRUD operations in iOS development.  

The app allows users to quickly create, edit, and organize notes while keeping data persistent across app launches.  

---

## Technologies Used

- **SwiftUI** – Declarative framework for building responsive UIs  
- **SwiftData** – Modern Apple framework for data persistence  
- **MVVM Architecture** – Clean separation of views and business logic  
- **Xcode 16+** – Development environment for building and running the app  

---

## Features

- Create, edit, and delete notes  
- Mark notes as favorites for quick access  
- Persistent storage with SwiftData (notes saved automatically)  
- Notes displayed in a responsive, sectioned list  
- Notes sorted by creation date  
- **Favorites View** to quickly access important notes  
- **Animated action buttons** for favorite, edit, and delete  
- **Sample data** for SwiftUI previews  

---

## Why This Challenge?

This project was created to:

* Practice **SwiftData** CRUD operations
* Explore data modeling for persistent storage
* Build a **scalable project structure** for learning purposes
* Combine **UI and data logic** in a small, real-world app
* Experiment with **animated toolbar and action buttons**  

---

## What I Learned

* Designing SwiftData `@Model` entities for persistent storage  
* Implementing **Create, Read, Update, Delete** functionality in SwiftUI  
* Querying, filtering, and sorting data with SwiftData APIs  
* Organizing project folders for scalable learning projects  
* Integrating SwiftUI views with persistent data  
* Refactoring UI components (ex:`NoteActionButtonsView`) for reusability  
* Implementing previews using **sample data** (`Note.sampleNotes`)  
* Creating a **Favorites view** with filtered notes  

---

## What I Would Do Differently

* Implement a **search bar** to filter notes  
* Add **tags or categories** for better note organization  
* Integrate **iCloud sync** for cross-device access  
* Refine the **UI** with themes, animations, and better accessibility  
* Add **swipe actions** for edit and delete directly in the list  

---

## App Showcase

Here’s a visual walkthrough of the key features in **SwiftNote**

---

### 📝 Add Note

Easily create a new note with a clean, simple interface.

![Add Note View](https://github.com/user-attachments/assets/6841e0f9-e6f8-4a6e-8da4-6f36f5e6d01b)

---

### ✏️ Edit Note

Update your existing notes with ease. Edit titles, content, or note types.

![Edit Note View](https://github.com/user-attachments/assets/6a255d1b-4422-40c9-bb7d-1e190f40b11f)

---

### ⭐ Explore Favorite Notes

Quickly access all your favorite notes in one place.

![Explore Favorite Note View](https://github.com/user-attachments/assets/1b1b0aa7-a8d4-4dde-ac60-26298a8e563a)

---

### 🔧 Edit Favorite Note

Toggle favorite status or make changes directly from your favorites list.

![Edit Favorite Note View](https://github.com/user-attachments/assets/79b35938-df9c-4305-b218-9b296afccf5c)

---

### 🗂 Edit Mode

Select and manage multiple notes at once with edit mode functionality.

![Edit Mode Note View](https://github.com/user-attachments/assets/29a6257d-d897-41c4-8434-44b375d42878)

---

### 📚 All Notes View

Browse and search through all your notes in a single, organized view.

![Notes View](https://github.com/user-attachments/assets/669ed266-79dd-425d-ab8f-c33cbdea6fc9)
