//
// SearchView.swift
// WillowAndFinch
//
// Created by Tiffany Le on 5/13/25.
//

import SwiftUI

enum SortOption: String, CaseIterable {
  case titleAZ = "Title A–Z"
  case titleZA = "Title Z–A"
  case authorAZ = "Author A–Z"
  case authorZA = "Author Z–A"
}
struct SearchView: View {
  @State private var books: [Book] = []
  @State private var searchText: String = ""
  @State private var sortOption: SortOption = .titleAZ
  // Filter and sort combined
  var filteredAndSortedBooks: [Book] {
    let filtered = books.filter {
      searchText.isEmpty ||
      $0.title.localizedCaseInsensitiveContains(searchText) ||
      $0.author.localizedCaseInsensitiveContains(searchText)
    }
    switch sortOption {
    case .titleAZ:
      return filtered.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
    case .titleZA:
      return filtered.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedDescending }
    case .authorAZ:
      return filtered.sorted { $0.author.localizedCaseInsensitiveCompare($1.author) == .orderedAscending }
    case .authorZA:
      return filtered.sorted { $0.author.localizedCaseInsensitiveCompare($1.author) == .orderedDescending }
    }
  }
  var body: some View {
    NavigationView {
        ZStack {
              Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all) // Fill the entire background
            VStack {
                // Title Page
                Text("All Books")
                    .font(.custom("Georgia", size: 30))
                    .bold()
                    .foregroundColor(Color("TextColor"))
                    .padding(.top, 20)
                    .padding(.leading)
                // Search Bar
                TextField("Search by title or author...", text: $searchText)
                    .font(.custom("Avenir", size: 16))
                    .padding(10)
                    .background(Color(.white))
                    .cornerRadius(10)
                    .padding(.horizontal)
                // Sort Picker
                Picker("Sort By", selection: $sortOption) {
                    ForEach(SortOption.allCases, id: \.self) { option in
                        Text(option.rawValue)
                            .font(.custom("Avenir", size: 16))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                // Book List --> Results of Search/Filter
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(filteredAndSortedBooks) { book in
                            NavigationLink(
                                destination: BookDetailView(book: book)
                            ) {
                                VStack(alignment: .leading) {
                                    if let url = URL(string: book.imageURL) {
                                        AsyncImage(url: url) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                                    .frame(width: 100, height: 150)
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: 150)
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                            case .failure(_):
                                                Image("DefaultCover")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: 150)
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                            @unknown default:
                                                Image("DefaultCover")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: 150)
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                            }
                                        }
                                    }

                                    Text(book.title)
                                        .font(.custom("Georgia", size: 16))
                                        .bold()
                                        .foregroundColor(Color("TextColor"))
                                        .lineLimit(2)

                                    Text(book.author)
                                        .font(.custom("Avenir", size: 14))
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                            }
                            .buttonStyle(PlainButtonStyle()) // Prevents blue link highlight
                        }
                    }
                    .padding()
                }


            }
        }
    }
    .onAppear(perform: loadBooks)
  }
    private func loadBooks() {
        if let data = BookRecommendation.loadBookData() {
            var loadedBooks: [Book] = []
            for title in data.book_titles {
                let author = data.book_metadata[title]?.BookAuthor ?? "Unknown"
                let publication_year = data.book_metadata[title]?.YearOfPublication ?? 0
                let publisher = data.book_metadata[title]?.Publisher ?? "Unknown"
                let ImageURL = data.book_metadata[title]?.ImageURL ?? "Unknown"
                loadedBooks.append(Book(title: title, author: author, publication_year: publication_year, publisher: publisher, imageURL: ImageURL))
            }
            books = loadedBooks
        }
    }
}
#Preview {
  SearchView()
}
