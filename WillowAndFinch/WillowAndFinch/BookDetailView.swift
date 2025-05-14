//
//  BookDetailView.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book
    @State private var navigateToReading = false
    @State private var navigateToFinchNest = false
    @State private var shouldNavigate = false
    @State private var showAddedMessage = false
    @State private var showAlreadySavedAlert = false

    @EnvironmentObject var viewModel: FinchNestViewModel
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.latteMilk.ignoresSafeArea(edges: .bottom)
                Color.warmBeige.ignoresSafeArea(edges: .top)
                
                
                VStack{
                    if let url = URL(string: book.imageURL){
                        
                        AsyncImage(url: url) { phase in
                            switch phase {
                                
                            case .empty:
                                ProgressView()
                                    .frame(width: 400, height: 300)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    .frame(width: 400)
                            case .failure(_):
                                Image("DefaultCover")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    .frame(width: 400)
                                
                            @unknown default:
                                Image("DefaultCover")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    .frame(width: 400)
                            }
                        }
                        .padding(10)
                        .padding(.top)
                    }
                    //                Image("DefaultCover")
                    //                    .resizable()
                    //                    .scaledToFit()
                    //                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    //                    .frame(width: 400)
                    //
                    //                    .padding(10)
                    //
                    VStack(spacing: 5) {
                        Button(action: {
                                if book.textAvailable {
                                    navigateToReading = true
                                }
                            }) {
                                Text(book.textAvailable ? "READ NOW" : "TEXT UNAVAILABLE")
                                    .frame(width: 200, height: 40)
                                    .font(.custom("Avenir", size: 16))
                                    .bold()
                                    .background(book.textAvailable ? Color("Grass") : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }

                            NavigationLink(
                                destination: ReadingView(),
                                isActive: $navigateToReading,
                                label: { EmptyView() }
                            )
                            .hidden()

                        if shouldNavigate {
                            NavigationLink(destination: FinchNestView(), isActive: $shouldNavigate) {
                                EmptyView()
                            }
                        }

                        Button(action: {
                            if(viewModel.isBookSaved(book)){
                                showAlreadySavedAlert = true
                            }else{
                                showAddedMessage = true
                                viewModel.addSaved(book)
                                shouldNavigate = true
                            }
                        }) {
                            Text(viewModel.isBookSaved(book) ? "Saved" : "READ LATER")
                                .font(.custom("Avenir", size: 16))
                                .frame(width: 150, height: 45)
                                .background(viewModel.isBookSaved(book) ? Color.gray.opacity(0.5) : Color("MatchLatte"))
                                .foregroundColor(viewModel.isBookSaved(book) ? .black : .white)
                                .cornerRadius(12)
                        }
                        .alert(isPresented: $showAddedMessage) {
                            Alert(title: Text("Book Added"), message: Text("This book was added to your reading list."), dismissButton: .default(Text("OK")))
                        }
                        .alert(isPresented: $showAlreadySavedAlert) {
                            Alert(
                                title: Text("Book Already Added"),
                                message: Text("This book is already in your reading list."),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                        
                    }
                    .padding(10)
                    
                    
                    ScrollView{
                        Text(book.title)
                            .font(.custom("Georgia", size: 25))
                            .bold()
                        Text(book.author)
                            .font(.custom("Georgia", size: 18))
                            .italic()
                        Spacer(minLength: 30)
                        //                    Text("Potentially Summary?")
                        Text("Publisher: \(book.publisher)")
                            .font(.custom("Avenir", size: 14))
                        Text("Publication Year: \(String(book.publication_year))")
                            .font(.custom("Avenir", size: 14))
                        
                    }
                }
            }
        }
    }
}

//
#Preview {
    BookDetailView(book: Book(title: "1984", author: "George Orwell", publication_year: 1990, publisher: "Signet Book",  imageURL: "http://images.amazon.com/images/P/0451524934.01.LZZZZZZZ.jpg"))
}
