# Sliding Window Concepts 

A collection of **mini Swift Playground projects** that demonstrate the **Sliding Window** technique — a core algorithmic pattern for working with **subarrays**, **substrings**, and **continuous data sequences** efficiently.

Each playground focuses on one concept or problem pattern, building up from fundamentals to real-world applications.

---

## Table of Contents

1. [Overview](#overview)
2. [Goals](#goals)
3. [Folder Structure](#folder-structure)
4. [Concept Progression](#concept-progression)
5. [Learning Outcomes](#learning-outcomes)

---

## Overview

The **Sliding Window** technique allows you to efficiently process contiguous chunks of data (like subarrays or substrings) without recomputing results from scratch.
Instead of using nested loops, you “slide” a window of variable or fixed size across the collection, updating only the parts that change.

---

## Goals

* Understand **how** and **why** the sliding window pattern works.
* Practice implementing both **fixed-size** and **variable-size** windows.
* Build strong intuition through **small, focused playgrounds**.
* Apply the concept to both **array-based** and **string-based** problems.

---

## Folder Structure

```
SlidingWindowConcepts/
│
├── Basics/
│   ├── PrintSubarrays.playground
└── README.md
```

<!--```-->
<!--SlidingWindowConcepts/-->
<!--│-->
<!--├── Basics/-->
<!--│   ├── PrintSubarrays.playground-->
<!--│   ├── WindowAverages.playground-->
<!--│-->
<!--├── FixedSize/-->
<!--│   ├── MaxSumSubarray.playground-->
<!--│   ├── MinAverageSubarray.playground-->
<!--│-->
<!--├── VariableSize/-->
<!--│   ├── SmallestSubarrayWithSum.playground-->
<!--│   ├── LongestSubarrayUnderLimit.playground-->
<!--│-->
<!--├── Strings/-->
<!--│   ├── LongestUniqueSubstring.playground-->
<!--│   ├── FindAllAnagrams.playground-->
<!--│-->
<!--└── README.md-->
<!--```-->

Each `.playground` contains:

* A short **problem statement**
* **Example input/output**
* **Swift implementation**
* **Time complexity** analysis
* Optional **debug prints** to visualize the window’s movement

---

## Concept Progression

| Folder           | Focus                                  | Example Problems                                         |
| ---------------- | -------------------------------------- | -------------------------------------------------------- |
| **Basics**       | Learn how windows move and overlap     | Print subarrays, rolling averages                        |
| **FixedSize**    | Fixed window length                    | Max sum subarray, min average subarray                   |
| **VariableSize** | Expand/shrink window dynamically       | Smallest subarray ≥ sum, longest subarray ≤ limit        |
| **Strings**      | Apply to characters instead of numbers | Longest substring without repeating chars, find anagrams |

---

## Learning Outcomes

By completing these mini projects, I'll':

* Grasp **window expansion and contraction** logic.
* Learn how to maintain **running sums, counts, or frequency maps** efficiently.
* Transition smoothly into related DSA topics like **Two Pointers** and **Prefix Sums**.
* Build intuition for real-world algorithm problems on **LeetCode** and **interview challenges**.

---

<!--## 🧭 Pro Tip-->
<!---->
<!--Keep each playground small and focused — one concept per file.-->
<!--Comment your thought process with:-->
<!---->
<!--```swift-->
<!--// MARK: - Sliding Window Example-->
<!--// Problem: Find maximum sum of any contiguous subarray of size k-->
<!--// Time: O(n)-->
<!--// Space: O(1)-->
<!--```-->
<!---->
<!--This makes each mini project a reusable DSA flashcard for future reference.-->
<!---->
<!------->
