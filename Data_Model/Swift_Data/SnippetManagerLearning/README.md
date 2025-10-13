# SnippetManagerLearning

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

**SnippetManagerLearning** is a SwiftUI-based personal snippet manager designed primarily as a **learning project**. The app allows developers to:

* Paste and store code snippets.
* Automatically wrap code in fenced Markdown code blocks.
* Render live Markdown previews with syntax highlighting.
* Organize snippets by language, tags, and date.

> **Disclaimer:** This project is currently a **mini learning app** focused on experimenting with **SwiftData** and creating a **custom Markdown parser**. It is not intended as a production-ready app at this stage. However, the architecture and modular design allow it to be expanded into a full-featured snippet manager in the future.

This project serves both as a **practical tool** for referencing code snippets and as a **hands-on playground** to learn SwiftUI, SwiftData, and app architecture fundamentals. Creating your own Markdown parser ensures a **future-proof solution**, giving you full control over syntax, rendering, and extensibility.

---

## Technologies Used

| Technology                 | Purpose                                              |
| -------------------------- | ---------------------------------------------------- |
| **SwiftUI**                | Declarative UI framework for modern iOS interfaces   |
| **SwiftData**              | Apple’s ORM-like persistence layer for model storage |
| **Custom Markdown Parser** | Full control over Markdown syntax and rendering      |
| **MVVM Architecture**      | Clean separation of business logic and presentation  |
| **Xcode Previews**         | Rapid iteration for UI and model testing             |
| **Combine** *(optional)*   | Reactive programming for state changes               |

---

## Features

* **Paste and Save Snippets**: Multi-line text input with automatic Markdown code block wrapping.
* **Markdown Preview**: Live preview of pasted content rendered with your own Markdown parser.
* **Language Selection**: User-selectable programming language for code blocks.
* **SwiftData Persistence**: Snippets are stored locally for later reference.
* **Organizational Tags**: Assign categories or tags to snippets (future extension).
* **Search & Filter**: Quickly locate snippets by title, language, or tag (planned).
* **Copy / Share**: Copy snippet content to clipboard or export as `.md` (planned).
* **Extensible Design**: Future support for multi-device sync, favorites, and versioning.
* **Custom Markdown**: Support for headers (#, ##, ###), code blocks (```), lists (-), and shortcodes ([[Component]]) for embedding SwiftUI views.

---

## Why This Challenge?

This project was designed to solve a **personal developer problem**: maintaining a centralized, searchable reference for code snippets and notes. Unlike off-the-shelf apps like Notion or Obsidian, building your own snippet manager allows for:

* Deep understanding of SwiftUI and SwiftData internals.
* Hands-on experience with **parsing and rendering Markdown manually**.
* Exploration of real-world app architecture, state management, and user interaction.
* A foundation for building larger, more complex productivity apps.
* Future-proofing the codebase without relying on third-party Markdown libraries.

<!------->
<!---->
<!--## What I Learned-->
<!---->
<!--Through building **SnippetManagerLearning**, I gained experience with:-->
<!---->
<!--* **SwiftUI layouts and components**: `TextEditor`, `ScrollView`, `Picker`, `NavigationStack`.-->
<!--* **Markdown rendering**: Integrating MarkdownUI and handling fenced code blocks dynamically.-->
<!--* **Data persistence with SwiftData**: Defining models, CRUD operations, and state binding.-->
<!--* **MVVM principles**: Separating business logic from UI for modularity and scalability.-->
<!--* **User experience considerations**: Monospaced fonts for code, live previews, language selection.-->
<!--* **Future-proofing an app**: Designing the architecture to easily add features like tags, search, export, and cloud sync.-->
<!---->
<!------->
<!---->
<!--## What I Would Do Differently-->
<!---->
<!--* **Automatic language detection**: Instead of selecting language manually, use heuristics to detect Swift, Python, JS, etc.-->
<!--* **Better snippet organization**: Include folder-like vaults or nested categories for more complex workflows.-->
<!--* **Enhanced Markdown support**: Add support for tables, images, and custom styling in preview.-->
<!--* **Unit and UI Testing**: Integrate XCTest to test persistence, parsing, and UI flows.-->
<!--* **Cross-platform support**: Expand to iPad/macOS with multi-column layouts and drag-and-drop.-->
<!---->
<!------->

## App Showcase
<!---->
<!--### Product Browser-->
<!---->
<!--Browse all locally stored FakeStore products with details and pricing.-->
<!---->
<!--![Product List](https://github.com/user-attachments/assets/4480291a-ec75-41aa-910a-cec2301fdc99)-->
<!---->
<!---->
<!--### Product Details-->
<!---->
<!--Check each products details in depth with the ability to change **quantity** **Add to cart** functionality-->
<!---->
<!--![Product Details](https://github.com/user-attachments/assets/095a7ad2-f820-4b79-9792-72c984a3aadc)-->
<!---->
<!---->
<!--### User Cart-->
<!---->
<!--Add or remove products, adjust quantities, and view total price — all persisted automatically.-->
<!---->
<!--![Cart View](https://github.com/user-attachments/assets/3109ae61-5d23-40f5-83dc-bc82de418b85)-->
<!---->
<!---->
<!---->
<!---->
<!---->
