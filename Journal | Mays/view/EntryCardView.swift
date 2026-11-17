import SwiftUI

struct EntryCardView: View {
    let entry: Entry
    let onBookmark: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                Text(entry.title)
                    .font(.titleCard)
                    .foregroundColor(.textAccent)

                Spacer()

                Button(action: onBookmark) {
                    Image(systemName: entry.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 26))
                        .foregroundColor(.primaryAccent)
                }
                .buttonStyle(.plain)
            }

            Text(entry.date.formatted(.dateTime.day(.twoDigits).month(.twoDigits).year()))
                .font(.captionM)
                .foregroundStyle(.secondary)

            Text(entry.text)
                .font(.bodyL)
                .multilineTextAlignment(.leading)
                .lineLimit(5)
                .padding(.top, 14)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .contentShape(RoundedRectangle(cornerRadius: 32))
    }
}

#Preview {
    EntryCardView(
        entry: Entry(
            title: "My Birthday",
            text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros.",
            isBookmarked: true
        ),
        onBookmark: { }
    )
    .padding(24)
}
