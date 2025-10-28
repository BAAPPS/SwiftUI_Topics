# TVBShowTracker (Exposure Project)

A Swift Playground project designed as an **exposure exercise** to track and organize TVB drama data using JSON parsing, `Codable`, and data structure techniques. This project combines multiple Swift and DSA concepts — from **array fundamentals** to **advanced patterns** like **Sliding Window** and **Two Pointers** — in a single, exploratory learning experience.

> ⚠️ **Note:** This project is primarily for **exposure**. It demonstrates real-world usage of Swift arrays, JSON decoding, and DSA patterns, but the goal is to familiarize the concepts rather than master each pattern. Subsequent mini-projects will focus on **single-topic exercises** for deeper learning.

---

## Table of Contents

1. [Overview](#overview)
2. [Goals](#goals)
3. [Key Topics Covered](#key-topics-covered)
4. [JSON Structure](#json-structure)
5. [Project Features](#project-features)
6. [DSA Integration](#dsa-integration)

---

## Overview

**TVBShowTracker** helps you practice:

* Decoding complex JSON into Swift models.
* Filtering, sorting, and transforming arrays of shows and episodes.
* Applying algorithmic patterns in real-world-like data.

You’ll work with a sample dataset of TVB shows including **genres**, **cast**, **schedule**, and **episodes**, making it ideal for practicing **data modeling**, **decoding**, and **array manipulation**.

---

## Goals

* Parse TVB show data using `Codable`.

* Practice advanced array operations:

  * Filtering and sorting
  * Mapping and reducing
  * Searching and comparing

* Apply **DSA patterns** such as:

  * **Two Pointers** – for finding relationships between episodes.
  * **Sliding Window** – for analyzing sequences of episodes.

* Strengthen **real-world parsing** and **algorithmic thinking** skills.

---

## Key Topics Covered

| Concept                    | Description                                                           |
| -------------------------- | --------------------------------------------------------------------- |
| `Codable`                  | Encode and decode JSON into Swift structures.                         |
| `Array` Operations         | Includes `map`, `filter`, `reduce`, `sorted`, and index manipulation. |
| `indices` & `enumerated()` | Efficient array traversal and debugging.                              |
| **Two Pointers**           | Optimize comparisons or searches in arrays.                           |
| **Sliding Window**         | Analyze continuous subsets of episodes or shows.                      |
| JSON Parsing               | Decode nested objects and arrays.                                     |
| Data Modeling              | Define `ShowModel` and `EpisodeModel` structs.                        |

---

## JSON Structure

Each JSON object represents a **TVB show**:

```json
{
  "title": "Only You",
  "subtitle": "Only You 只有您",
  "year": "2011",
  "genres": ["Romance"],
  "description": "An unrelenting and boastful woman...",
  "thumb_image_url": "https://...",
  "banner_image_url": "https://...",
  "schedule": "30 Episodes",
  "cast": ["Kevin Cheng", "Yoyo Mung", "Louise Lee"],
  "episodes": [
    {
      "title": "Episode 01",
      "url": "https://...",
      "thumbnail_url": "https://..."
    }
  ]
}
```

---

## Project Features

* ✅ Decode TVB JSON into Swift models.
* ✅ Display cast, genres, and episode counts.
* ✅ Filter episodes by keyword or number.
* ✅ Sort shows alphabetically or by release year.
* ✅ Apply **DSA-inspired array algorithms** to analyze episode sequences.

---

## DSA Integration

| Pattern                  | Usage Example                                                                                   |
| ------------------------ | ----------------------------------------------------------------------------------------------- |
| **Sliding Window**       | Analyze consecutive episode thumbnails (e.g., detect missing images in 5 consecutive episodes). |
| **Two Pointers**         | Compare episode URLs or find duplicate titles efficiently.                                      |
| **Sorting & Searching**  | Organize episodes or locate latest releases.                                                    |
| **Filtering**            | Extract specific genres or shows featuring a given cast member.                                 |
| **Indices Manipulation** | Efficient iteration and comparison using `indices` and `enumerated()`.                          |

---

## Learning Reflection

This project acts as a **comprehensive exposure** to Swift arrays and DSA patterns:

* ✅ Creating & inspecting arrays
* ✅ Accessing & modifying elements
* ✅ Slicing & combining arrays
* ✅ Searching, filtering, and mapping
* ✅ JSON decoding & encoding
* ✅ Applying **Sliding Window** and **Two Pointers**

> Use this project to **explore** patterns and understand the flow of data. Later mini-projects should focus on **single topics** for deeper mastery.

