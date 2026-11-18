# Journal

A simple journaling app for iOS, built with SwiftUI using the MVVM pattern.

## App Name

**Journal**

## Purpose

Journal lets users write and organize their personal diary entries in one place. The project was built to practice SwiftUI fundamentals: layout, navigation, state management, and clean architecture with MVVM, following a provided Sketch design.

## Main Features

- **Add and edit journals** with a title and text, with a discard-changes alert when closing with unsaved edits.
- **Bookmark** your favorite journals.
- **Swipe to delete** with a confirmation alert.
- **Search and sort** journals by title, entry date, or bookmark.

## What I Learned

| Topic | Where it is used |
|---|---|
| SwiftUI Layout | `VStack`, `HStack`, `ZStack`, `List` |
| Navigation & Toolbar | `NavigationStack`, `.sheet`, `.toolbar` |
| State Management | `@State`, `@Binding`, `@ObservedObject`, `@StateObject` |
| MVVM Pattern | `Entry` (Model), `JournalViewModel` (ViewModel), Views |
| Search & Filter | `filteredEntries` in the ViewModel |
| List Interactions | `.swipeActions`, discard and delete alerts |
| Form Editing | `TextField`, `TextEditor`, save and cancel flow |
| User Experience | Empty state, keyboard dismiss, alerts |

## Project Structure

```
Journal
├── model
│   └── Entry.swift
├── ViewModel
│   └── JournalViewModel.swift
├── view
│   ├── ContentView.swift
│   ├── EntryCardView.swift
│   ├── AddEntryView.swift
│   ├── EditEntryView.swift
│   └── splashIcon.swift
├── theme.swift
├── Assets
└── MyApp.swift
```

## Architecture (MVVM)

- **Model:** `Entry` defines a single journal (title, text, date, bookmark).
- **ViewModel:** `JournalViewModel` holds the list and all the logic (add, update, delete, bookmark, search, sort).
- **View:** the screens only display data and call the ViewModel.

## Requirements

- Xcode (latest)
- iOS 17 or later

## How to Run

1. Clone the repository.
2. Open the project in Xcode.
3. Select an iPhone simulator.
4. Press Run (⌘ + R).

## Author

Mays
