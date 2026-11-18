import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: JournalViewModel

    init(viewModel: JournalViewModel = JournalViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()

                VStack(spacing: 0) {
                    HStack {
                        Text("Journal")
                            .font(.headingL)

                        Spacer()

                        HStack(spacing: 24) {
                            Menu {
                                Button("Sort by Bookmark") {
                                    viewModel.sortOption = .bookmark
                                }
                                Button("Sort by Entry Date") {
                                    viewModel.sortOption = .date
                                }
                            } label: {
                                Image(systemName: "line.3.horizontal.decrease")
                            }

                            Button { viewModel.showAddSheet = true } label: {
                                Image(systemName: "plus")
                            }
                        }
                        .font(.system(size: 22))
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 14)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(Capsule())
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    .padding(.bottom, 12)

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
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 60)
                        }

                        Spacer()
                    } else {
                        List {
                            ForEach(viewModel.filteredEntries) { entry in
                                EntryCardView(entry: entry) {
                                    viewModel.toggleBookmark(entry)
                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
                                .onTapGesture {
                                    viewModel.entryToEdit = entry
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button {
                                        viewModel.askToDelete(entry)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                    }
                                    .tint(.destructive)
                                }
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .scrollDismissesKeyboard(.interactively)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .bottom) {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                    TextField("Search", text: $viewModel.searchText)

                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
                .padding(.horizontal, 24)
                .padding(.bottom, 8)
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                }
            }
        }
        .sheet(isPresented: $viewModel.showAddSheet) {
            AddEntryView(viewModel: viewModel)
        }
        .sheet(item: $viewModel.entryToEdit) { entry in
            EditEntryView(viewModel: viewModel, entry: entry)
        }
        .alert("Delete Journal?", isPresented: $viewModel.showDeleteAlert) {
            Button("Cancel", role: .cancel) {
                viewModel.entryToDelete = nil
            }
            Button("Delete", role: .destructive) {
                viewModel.confirmDelete()
            }
        } message: {
            Text("Are you sure you want to delete this journal?")
        }
    }
}

#Preview("Empty") {
    ContentView()
}

#Preview("With entries") {
    let vm = JournalViewModel()
    vm.entries = [
        Entry(title: "My Birthday", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros.", isBookmarked: true),
        Entry(title: "Today's Journal", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros."),
        Entry(title: "Great Day", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros.")
    ]
    return ContentView(viewModel: vm)
}
