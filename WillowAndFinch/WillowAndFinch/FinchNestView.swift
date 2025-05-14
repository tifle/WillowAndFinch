//
//  FinchNestView.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

// FOR BACKGROUND AND FOREGROUND
extension Color {
    static let sageGreen = Color(red: 0.53, green: 0.57, blue: 0.40)
    static let cafeBrown = Color(red: 0.42, green: 0.35, blue: 0.28)
    static let latteMilk = Color(red: 1, green: 0.96, blue: 0.91)
    static let warmBeige = Color(red: 0.906, green: 0.847, blue: 0.788)
}

struct FinchNestView: View {
    @EnvironmentObject var viewModel: FinchNestViewModel

    // creates view per book
    private func createSavedBookView(for book: Book) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(book.title)
                .font(.custom("Georgia", size: 16))
                .foregroundColor(Color("TextColor"))
                .padding(.bottom, 2)
            
            Text("by \(book.author)")
                .font(.custom("Avenir", size: 14))
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.latteMilk)
        .cornerRadius(8)
        .padding(.horizontal)
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                // background color for content area
                VStack(spacing: 0) {
                    Color.sageGreen.frame(height: 110)
                    Color("BackgroundColor")
                }
                .edgesIgnoringSafeArea(.top)

                // CONTENT
                VStack(alignment: .leading, spacing: 20) {
                    // TITLE W/ BACKGROUND
                    Text("Your Nest")
                        .font(.custom("Georgia", size: 30))
                        .bold()
                        .foregroundColor(Color("BackgroundColor"))
                        .padding()
                        .padding(.top, -15)

                    // CURRENTLY READING section
                    Text("    Currently Reading")
                        .font(.custom("Georgia", size: 20))
                        .bold()
                        .foregroundColor(Color("TextColor"))

                    // BOOK LINKS (example)
                    VStack(alignment: .leading, spacing: 0) {
                        NavigationLink(
                            destination: ReadingView(),
                            label: {
                                HStack {
                                    Text("The Yellow Wallpaper")
                                        .font(.custom("Georgia", size: 16))
                                        .foregroundColor(Color("TextColor"))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.latteMilk)
                            }
                        )

                        Divider()
                    }
                    .cornerRadius(8)
                    .padding(.horizontal)

                    // SAVED FOR LATER section
                    Text("    Saved for Later")
                        .font(.custom("Georgia", size: 20))
                        .bold()
                        .foregroundColor(Color("TextColor"))
                        .padding(.top, 8)
                    

                    // dynamic list of saved books
                    ForEach(viewModel.savedBooks) { book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            HStack {
                                createSavedBookView(for: book)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color("latteMilk"))
                            .cornerRadius(10)
                        }
                    }

                    Spacer()
                    // Logo / Home Page
                    HStack {
                        Spacer()
                        Image("nest")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                        Spacer()
                    }
                    .padding(.bottom)
                    .padding(.leading)
                }
                .padding(.bottom, 25)

                Spacer()
            }
            .background(Color("TabColor"))
        }
    }
}

#Preview {
    FinchNestView()
        .environmentObject(FinchNestViewModel()) // Add environment object in the preview
}
