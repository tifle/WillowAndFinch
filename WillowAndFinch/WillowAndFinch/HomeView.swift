//
//  HomeView.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var recommender = BookRecommendation.shared
    
    var body: some View {
        // Navigation View
            NavigationView {
                // Vertical Stack
                VStack(alignment: .leading) {
                    // Logo / Home Page
                    HStack {
                        Spacer()
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                        Spacer()
                    }
                    .padding(.top)
                    Text("Welcome to Willow & Finch")
                        .font(.custom("Georgia", size: 25))
                        .foregroundColor(Color("TextColor"))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom)
                    
                    ScrollView(.vertical){
                        Text("Recommended")
                            .font(.custom("Georgia", size: 20))
                            .foregroundColor(Color("TextColor"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .bold()
                            .padding()
                        
                        if recommender.recommendedBooks.isEmpty {
             
                            NavigationLink(destination: RecommendationView()) {
                                Text("Generate recommendations")
                                    .frame(width: 230, height: 30)
                                    .background(Color.sageGreen)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                        } else {
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(recommender.recommendedBooks, id: \.title) { book in
                                        
                                        /*
                                        if let url = URL(string: book.imageURL) {
                                            
                                            AsyncImage(url: url) { phase in
                                                switch phase {
                                                case .empty:
//                                                    Text("EMPTY")
                                                    ProgressView()
                                                        .frame(width: 50, height: 300)
                                                case .success(let image):
//                                                    Text("SUCCESS")
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                        .clipShape(RoundedRectangle(cornerRadius: 25))
                                                        .frame(width: 50)
                                                case .failure(_):
//                                                    Text("DEFULT")
                                                    Image("DefaultCover")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .clipShape(RoundedRectangle(cornerRadius: 25))
                                                        .frame(width: 50)
                                                    
                                                @unknown default:
//                                                    Text("OG DEFAULT")
                                                    Image("DefaultCover")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .clipShape(RoundedRectangle(cornerRadius: 25))
                                                        .frame(width: 50)
                                                }
                                            }
                                        
                                        }*/
                                        
                                        Text(book.imageURL)
                                        
                                    }
                                }
                            }
                            NavigationLink(destination: RecommendationView()) {
                                Text("Generate more")
                                    .frame(width: 140, height: 30)
                                    .background(Color.sageGreen)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                
                            }
                        }
                        Text("New Releases")
                            .font(.custom("Georgia", size: 20))
                            .foregroundColor(Color("TextColor"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .bold()
                            .padding(.top, 50)
                        
                        ScrollView(.horizontal) {
                            HStack{
                                Image("WingsOfStarlight")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("SunriseOnTheReaping")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("EmilyWilde")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("MarkTwain")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("OnyxStorm")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("GirlWhoFellBeneathTheSea")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("OneGoldenSummer")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("EverythingIsTuberculosis")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("NextDay")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                        }
                        
                        Text("Staff's Choice")
                            .font(.custom("Georgia", size: 20))
                            .foregroundColor(Color("TextColor"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .bold()
                            .padding(.top, 50)
                        
                        
                        ScrollView(.horizontal) {
                            HStack{
                                Image("TheWager")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("Cinder")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("MagicTreeHouse")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("GentlemanInMoscow")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("MeBeforeYou")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("HungerGames")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("Illuminae")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("MidnightLibrary")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image("SixOfCrows")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                        }
                    }
            }
                .background(Color("BackgroundColor").ignoresSafeArea(edges: .top))
                .background(Color("TabColor"))
        }
    }
}

#Preview {
    HomeView()
}
