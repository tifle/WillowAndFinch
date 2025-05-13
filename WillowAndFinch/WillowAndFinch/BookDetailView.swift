//
//  BookDetailView.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book
    
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
                    VStack {
                        NavigationLink(destination: ReadingView()) {
                            Text("READ NOW")
                                .frame(width: 150, height: 45)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        
                            
                        Button(action: {
                            print("")
                        }) {
                            Text("READ LATER")
                                .frame(width: 150, height: 45)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(12)
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
                        Text("Publication Year: \(String(book.publication_year))")
                        
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
