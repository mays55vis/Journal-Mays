import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = JournalViewModel()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                HStack {
                    Text("Journal")
                        .font(.headingL)
                        .foregroundColor(.textPrimary)

                    Spacer()

                    HStack(spacing: 20) {
                        Button { } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                        }
                        Button { viewModel.showAddSheet = true } label: {
                            Image(systemName: "plus")
                        }
                    }
                    .font(.system(size: 20))
                    .foregroundColor(.textPrimary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.surfaceCard)
                    .clipShape(Capsule())
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)

                if viewModel.filteredEntries.isEmpty {
                    Spacer()

                    VStack(spacing: 16) {
                        Image("card1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 130)

                        Text("Begin Your Journal")
                            .font(.headingM)
                            .foregroundColor(.textAccent)

                        Text("Craft your personal diary, tap the plus icon to begin")
                            .font(.bodySupporting)
                            .foregroundColor(.textPrimary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 60)
                    }

                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.filteredEntries) { entry in
                            Text(entry.title)
                                .font(.titleCard)
                                .foregroundColor(.textPrimary)
                                .listRowBackground(Color.surfaceCard)
                        }
                        .onDelete(perform: viewModel.delete)
                    }
                    .scrollContentBackground(.hidden)
                }

                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $viewModel.searchText)
                    Image(systemName: "mic.fill")
                }
                .font(.bodyM)
                .foregroundColor(.textSecondary)
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .background(Color.surfaceCard)
                .clipShape(Capsule())
                .padding(.horizontal, 24)
                .padding(.bottom, 8)
            }
        }
        .sheet(isPresented: $viewModel.showAddSheet) {
            AddEntryView(viewModel: viewModel)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
