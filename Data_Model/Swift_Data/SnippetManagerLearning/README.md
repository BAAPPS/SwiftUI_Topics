# SnippetManagerLearning

---

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

---

## What I Learned

Through building **SnippetManagerLearning**, I gained hands-on experience with several SwiftUI, SwiftData, and app architecture concepts:

* **State Management & Bindable Data**: Learned how to use `@Bindable` and `@Environment` to connect views with a shared `ViewModel`, keeping UI and data in sync automatically.
* **Auto-save and Draft Management**: Implemented auto-save behavior and draft creation for new snippets, ensuring users never lose their work.
* **SwiftUI Layouts & Components**: Built complex layouts using `ScrollView`, `TextEditor`, `VStack`, `Picker`, and `NavigationStack`, creating a Notion-like snippet editing page.
* **Keyboard Handling in SwiftUI**: Managed dynamic keyboard behavior to resize text editors and keep content accessible while typing.
* **Markdown Rendering**: Created a custom Markdown parser to render live previews, including fenced code blocks, headers, lists, and embedded components.
* **SwiftData Persistence**: Defined models, performed CRUD operations, and explored how data can persist locally while maintaining reactive UI updates.
* **MVVM Architecture**: Separated business logic from UI, enabling cleaner, more maintainable, and scalable code.
* **User Experience Considerations**: Learned how to present monospaced fonts for code, live previews, language selection, and intuitive editing flows similar to Notion.
* **Reusable Views & Components**: Designed reusable, composable SwiftUI components (`EditableBlockView`, `CustomMarkdownView`) for modularity and future feature expansion.
* **Navigation & Context Awareness**: Gained experience with passing data between views via environment objects, navigation destinations, and optional bindings.

> Overall, this project reinforced the importance of **reactive data flow, modular architecture, and user-focused design** in SwiftUI apps while giving me a playground to experiment with advanced features like live Markdown rendering and draft management.

---

## What I Would Do Differently

* **Automatic Language Detection**: Instead of manually selecting a programming language, implement heuristics or lightweight syntax analysis to automatically detect Swift, Python, JavaScript, etc.
* **Enhanced Snippet Organization**: Introduce folder-like vaults, nested categories, or tagging systems to manage large numbers of snippets more effectively.
* **Improved Markdown Support**: Extend the custom parser to handle tables, images, links, inline code, and additional Markdown features for richer previews.
* **Undo/Redo & Versioning**: Add support for undo/redo operations or snapshot versioning for snippets, making editing safer and more robust.
* **Unit and UI Testing**: Integrate XCTest to validate persistence, parsing, and UI behavior, ensuring long-term maintainability.
* **Cross-Platform Support**: Expand the app to iPad and macOS with multi-column layouts, drag-and-drop snippets, and optimized editing experiences.
* **Cloud Sync & Multi-Device Access**: Implement iCloud or CloudKit syncing to access snippets seamlessly across devices.
* **Performance Optimization**: Optimize large snippet lists and Markdown rendering for smooth scrolling and minimal lag, especially with hundreds of code blocks.
* **Enhanced User Experience**: Add features like snippet favorites, quick search, copy-to-clipboard shortcuts, and customizable themes for better usability.

> These improvements would make the app feel more production-ready, while still keeping it modular and flexible for experimentation with new SwiftUI and SwiftData features.

---


## App Showcase


### Snippet List

Browse all your saved snippets in a clean, scrollable list. Each snippet shows the **title**, **programming language**, and **creation date** for quick reference. Swipe to delete snippets or tap on a snippet to view details.

![Snippet List](https://github.com/user-attachments/assets/dd290076-0c72-45bb-bd2f-387c1c3c72c5)

---

### Snippet Detail

View each snippet in a **Notion-like detail page** with live Markdown rendering. The detail page displays:

* Snippet title and language
* Markdown content preview
* Code blocks rendered with proper formatting
* Option to edit the snippet using the pencil toolbar

![Snippet Detail](https://github.com/user-attachments/assets/9d1a7d4e-aaac-4d48-8a11-eca4973f8cd8)


### Snippet Editor

Edit or create new snippets in a **rich text editing environment**:

* `TextEditor` for title and code blocks
* Live Markdown preview
* Language selection with a segmented picker
* Auto-save functionality ensures no work is lost
* Editable blocks to switch between paragraph, header, code, or component types

![Snippet Editor](https://github.com/user-attachments/assets/a90b650e-ceea-42d7-91e3-511a350a0666)


### Live Markdown Preview

See your Markdown updates in **real time** while editing:

* Code blocks wrapped in fenced ``` syntax
* Headers, lists, and embedded components render immediately
* Custom parser ensures full control over rendering

![Markdown Preview](https://github.com/user-attachments/assets/7803fa12-9cd9-4160-9054-3908b8ca7d2f)

