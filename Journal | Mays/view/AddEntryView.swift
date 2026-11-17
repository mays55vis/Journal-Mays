import SwiftUI
import Combine

struct AddEntryView: View {
    @ObservedObject var viewModel: JournalViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var text = ""
    @State private var showDiscardAlert = false

    private var hasChanges: Bool {
        !title.isEmpty || !text.isEmpty
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
                        viewModel.add(title: title, text: text)
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

                TextField("", text: $title, prompt: Text("Title").foregroundStyle(.secondary))
                    .font(.headingM)

                Text(Date().formatted(.dateTime.day(.twoDigits).month(.twoDigits).year()))
                    .font(.captionS)
                    .foregroundStyle(.secondary)

                ZStack(alignment: .topLeading) {
                    TextEditor(text: $text)
                        .font(.bodyM)
                        .scrollContentBackground(.hidden)
                        .padding(.horizontal, -5)

                    if text.isEmpty {
                        Text("Type your Journal...")
                            .font(.bodyM)
                            .foregroundStyle(.secondary)
                            .padding(.top, 8)
                            .allowsHitTesting(false)
                    }
                }
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
    AddEntryView(viewModel: JournalViewModel())
}
