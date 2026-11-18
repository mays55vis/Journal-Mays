import SwiftUI
import Combine

enum SortOption {
    case date
    case bookmark
}

class JournalViewModel: ObservableObject {
    @Published var entries: [Entry] = []
    @Published var searchText = ""
    @Published var showAddSheet = false
    @Published var entryToEdit: Entry? = nil
    @Published var entryToDelete: Entry? = nil
    @Published var showDeleteAlert = false
    @Published var sortOption: SortOption = .date

    var filteredEntries: [Entry] {
        var result = entries

        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.text.localizedCaseInsensitiveContains(searchText)
            }
        }

        switch sortOption {
        case .date:
            result.sort { $0.date > $1.date }
        case .bookmark:
            result.sort {
                if $0.isBookmarked != $1.isBookmarked {
                    return $0.isBookmarked
                }
                return $0.date > $1.date
            }
        }

        return result
    }

    func add(title: String, text: String) {
        entries.append(Entry(title: title, text: text))
    }

    func update(_ entry: Entry, title: String, text: String) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index].title = title
            entries[index].text = text
        }
    }

    func toggleBookmark(_ entry: Entry) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index].isBookmarked.toggle()
        }
    }

    func askToDelete(_ entry: Entry) {
        entryToDelete = entry
        showDeleteAlert = true
    }

    func confirmDelete() {
        if let entry = entryToDelete {
            entries.removeAll { $0.id == entry.id }
        }
        entryToDelete = nil
    }
}
