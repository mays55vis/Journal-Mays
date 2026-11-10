import Foundation

struct Entry: Identifiable {
    let id = UUID()
    var title: String
    var text: String
    var date = Date()
    var isBookmarked = false
}
