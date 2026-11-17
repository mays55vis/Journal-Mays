import SwiftUI
import Combine

struct EditEntryView: View {
    @ObservedObject var viewModel: JournalViewModel
    @Environment(\.dismiss) private var dismiss

    let entry: Entry
    @State private var title: String
    @State private var text: String
    @State private var showDiscardAlert = false

    init(viewModel: JournalViewModel, entry: Entry) {
        self.viewModel = viewModel
        self.entry = entry
        _title = State(initialValue: entry.title)
        _text = State(initialValue: entry.text)
    }

    private var hasChanges: Bool {
        title != entry.title || text != entry.text
    }

    var body: some View {
        ZStack {
            Color(.secondarySystemBackground).ignoresSafeArea()

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Button {
                        if hasChanges {
                            showDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundStyle(.primary)
                            .frame(width: 44, height: 44)
                            .background(Color(.systemGray5))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Button {
                        viewModel.update(entry, title: title, text: text)
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.primaryAccent)
                            .clipShape(Circle())
                    }
                    .disabled(title.isEmpty)
                    .opacity(title.isEmpty ? 0.4 : 1)
                }

                TextField("Title", text: $title)
                    .font(.headingM)

                Text(entry.date.formatted(.dateTime.day(.twoDigits).month(.twoDigits).year()))
                    .font(.captionS)
                    .foregroundStyle(.secondary)

                TextEditor(text: $text)
                    .font(.bodyM)
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal, -5)
            }
            .padding(24)
        }
        .alert(
            "Are you sure you want to discard changes on this journal?",
            isPresented: $showDiscardAlert
        ) {
            Button("Discard Changes", role: .destructive) {
                dismiss()
            }
            Button("Keep Editing", role: .cancel) { }
        }
    }
}

#Preview {
    EditEntryView(
        viewModel: JournalViewModel(),
        entry: Entry(title: "Great Day", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.")
    )
}
