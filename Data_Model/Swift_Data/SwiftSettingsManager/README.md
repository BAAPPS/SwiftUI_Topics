# SwiftSettingsManager

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

**SwiftSettingsManager** is a SwiftUI learning project designed to explore **SwiftData** for model-based persistence, combined with dynamic UI updates and theme management.
The app simulates a real-world settings page where users can adjust preferences like **theme**, **accent color**, **font size**, and **notification settings**. All changes are persisted using SwiftData and reflected instantly in the UI.

This project emphasizes clean architecture using **MVVM**, reactive SwiftUI views, and modern iOS design patterns.

---

## Technologies Used

| Technology                   | Purpose                                               |
| ---------------------------- | ----------------------------------------------------- |
| **SwiftUI**                  | Declarative UI framework for building modern iOS apps |
| **SwiftData**                | Apple’s persistence framework for model-based storage |
| **MVVM Architecture**        | Clean separation of logic and presentation            |
| **@Observable / @Published** | Reactive state management for SwiftUI views           |
| **NavigationStack**          | Modern navigation handling in SwiftUI                 |

---

## Features

* **Theme Selection** – Switch between Light, Dark, and System themes.
* **Accent Color Selection** – Pick your preferred accent color from predefined options.
* **Font Size Adjustment** – Change the font size of preview text dynamically.
* **Notification Toggle** – Enable or disable notifications, stored persistently.
* **Automatic Persistence** – All settings are stored using **SwiftData** and survive app restarts.
* **Reactive UI** – Changes are reflected instantly without needing to reload the app.
* **Clean MVVM Structure** – Model, ViewModel, and View separation for maintainability.

---

## Why This Challenge?

This challenge was chosen to:

* Explore **SwiftData**, Apple’s modern persistence framework, in a realistic scenario.
* Understand how **reactive SwiftUI views** respond to model changes.
* Implement **dynamic app themes and preferences**, a core feature in many iOS apps.
* Practice **MVVM architecture** in a lightweight, manageable project.
* Learn to structure a small SwiftUI project in a **scalable, maintainable way**.

---
<!---->
<!--## What I Learned-->
<!---->
<!--* How to define **SwiftData models** and persist data efficiently.-->
<!--* How to fetch, observe, and update data with **@Query** and **@Environment(.modelContext)**.-->
<!--* How to bind SwiftData-backed settings to SwiftUI controls (Pickers, Toggles, Sliders).-->
<!--* How to implement **live UI updates** using SwiftUI and reactive state.-->
<!--* Best practices for **MVVM in SwiftUI** and separating business logic from UI.-->
<!--* Strategies for **app-wide theming** and user preference management.-->
<!---->
<!------->
<!---->
<!--## What I Would Do Differently-->
<!---->
<!--* Implement **multiple user profiles** so each user can have separate settings.-->
<!--* Add **CloudKit sync** for cross-device persistence.-->
<!--* Expand theme management to **live preview** without restarting the app.-->
<!--* Include **custom color palettes** for greater personalization.-->
<!--* Add unit tests to verify persistence and theme application logic.-->
<!---->
<!------->
<!---->
<!--## App Showcase-->
<!---->
<!--### Theme Selection-->
<!---->
<!--Easily switch between **System**, **Light**, or **Dark** themes.-->
<!--![Theme Selection](https://github.com/user-attachments/assets/theme-selection-placeholder.png)-->
<!---->
<!--### Accent Color-->
<!---->
<!--Pick your favorite accent color to personalize the app.-->
<!--![Accent Color Picker](https://github.com/user-attachments/assets/accent-color-placeholder.png)-->
<!---->
<!--### Font Size Adjustment-->
<!---->
<!--Adjust font size dynamically and see immediate preview changes.-->
<!--![Font Size Slider](https://github.com/user-attachments/assets/font-size-placeholder.png)-->
<!---->
<!--### Notification Toggle-->
<!---->
<!--Enable or disable notifications for your profile.-->
<!--![Notifications Toggle](https://github.com/user-attachments/assets/notifications-placeholder.png)-->
<!---->
<!--### Persistent Settings-->
<!---->
<!--All changes are automatically stored and persist after app restarts.-->
<!---->
