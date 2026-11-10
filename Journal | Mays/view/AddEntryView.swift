import SwiftUI
import Combine

struct AddEntryView: View {
    @ObservedObject var viewModel: JournalViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var text = ""

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 16) {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.destructive)

                    Spacer()

                    Button("Save") {
                        viewModel.add(title: title, text: text)
                        dismiss()
                    }
                    .foregroundColor(.primaryAccent)
                    .disabled(title.isEmpty)
                }
                .font(.bodyM)

                TextField("Title", text: $title)
                    .font(.titleCard)
                    .foregroundColor(.textPrimary)

                TextEditor(text: $text)
                    .font(.bodyM)
                    .foregroundColor(.textPrimary)
                    .scrollContentBackground(.hidden)
                    .background(Color.surfaceCard)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                Spacer()
            }
            .padding(24)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AddEntryView(viewModel: <#JournalViewModel#>)
}
