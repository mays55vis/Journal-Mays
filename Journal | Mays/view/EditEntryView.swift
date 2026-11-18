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
                            .font(.system(size: 18, weight: .light))
                            .foregroundStyle(.primary)
                            .frame(width: 44, height: 44)
                            .background(Color(.systemBackground))
                            .clipShape(Circle())
                            .glassEffect(
                                in:Circle()
                            )

                            .overlay(
                                Circle().stroke(Color.gray.opacity(0.35), lineWidth: 1)
                            )
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Button {
                        viewModel.update(entry, title: title, text: text)
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundStyle(Color(.systemBackground))
                            .frame(width: 44, height: 44)
                            .background(Color.primaryAccent)
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .disabled(title.isEmpty)
                    .opacity(title.isEmpty ? 0.4 : 1)
                }

                TextField("Title", text: $title)
                    .font(.headingL)
                    .padding(.top, 8)

                Text(entry.date.formatted(.dateTime.day(.twoDigits).month(.twoDigits).year()))
                    .font(.captionM)
                    .foregroundStyle(.secondary)

                TextEditor(text: $text)
                    .font(.bodyL)
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal, -5)
                    .padding(.top, 12)
            }
            .padding(.horizontal, 24)
            .padding(.top, 28)
        }
        .tint(.primaryAccent)
        .presentationDragIndicator(.visible)
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
