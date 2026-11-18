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

    private var canSave: Bool {
        !title.isEmpty && !text.isEmpty
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
                            .overlay(
                                Circle().stroke(Color.gray.opacity(0.35), lineWidth: 1)
                            )
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Button {
                        viewModel.add(title: title, text: text)
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
                    .disabled(!canSave)
                    .opacity(canSave ? 1 : 0.4)
                }

                TextField("", text: $title, prompt: Text("Title").foregroundStyle(.secondary))
                    .font(.headingL)
                    .padding(.top, 8)

                Text(Date().formatted(.dateTime.day(.twoDigits).month(.twoDigits).year()))
                    .font(.captionM)
                    .foregroundStyle(.secondary)

                ZStack(alignment: .topLeading) {
                    TextEditor(text: $text)
                        .font(.bodyL)
                        .scrollContentBackground(.hidden)
                        .padding(.horizontal, -5)

                    if text.isEmpty {
                        Text("Type your Journal...")
                            .font(.bodyL)
                            .foregroundStyle(.secondary)
                            .padding(.top, 8)
                            .allowsHitTesting(false)
                    }
                }
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
    AddEntryView(viewModel: JournalViewModel())
}
