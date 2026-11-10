import SwiftUI
import Combine

class JournalViewModel: ObservableObject {
    @Published var entries: [Entry] = []
    @Published var searchText = ""
    @Published var showAddSheet = false

    var filteredEntries: [Entry] {
        if searchText.isEmpty {
            return entries
        }
        return entries.filter { $0.title.contains(searchText) }
    }

    func add(title: String, text: String) {
        entries.append(Entry(title: title, text: text))
    }

    func delete(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
    }
}
