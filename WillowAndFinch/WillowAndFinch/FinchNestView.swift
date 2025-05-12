//
//  FinchNestView.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

extension Color {
    static let sageGreen = Color(red: 0.53, green: 0.57, blue: 0.40)
    static let cafeBrown = Color(red: 0.42, green: 0.35, blue: 0.28)
    static let latteMilk = Color(red: 1, green: 0.96, blue: 0.91)
    static let warmBeige = Color(red: 0.906, green: 0.847, blue: 0.788)
}

struct FinchNestView: View {
    var body: some View {
        ZStack(alignment: .top) {
            // Background color for entire content area
            VStack(spacing: 0) {
                Color.sageGreen.frame(height: 110)
                Color.cafeBrown
            }
            .edgesIgnoringSafeArea(.top)
            
            // Content
            VStack(alignment: .leading, spacing: 20) {
                // Title with background
                Text("Your Nest")
                    .font(.custom("Georgia", size: 30))
                    .bold()
                    .foregroundColor(.latteMilk)
                    .padding()
                    .padding(.top, -15)

                    .frame(maxWidth: .infinity,
                           alignment: .center)
                
                // Currently Reading section
                Text("    Currently Reading")
//                    .padding()
                    .font(.custom("Georgia", size: 20))
                    .bold()
                    .foregroundColor(.latteMilk)
                
                // Book links
                VStack(alignment: .leading, spacing: 0) {
                    NavigationLink(
                        destination: ReadingView(),
                        label: {
                            HStack {
                                Text("The Yellow Wallpaper")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.latteMilk)
                        }
                    )
                    
                    Divider()
                    
                    Text("Another Current Book")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Avenir", size: 16))
                        .background(Color.latteMilk)
                }
                .cornerRadius(8)
                .padding(.horizontal)
                
                // Saved for Later section
                Text("    Saved for Later")
                    .font(.custom("Georgia", size: 20))
                    .bold()
                    .foregroundColor(.latteMilk)
                    .padding(.top, 8)
                
                // Book saved
                Text("Book You Saved")
                    .font(.custom("Avenir", size: 16))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.latteMilk)
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding(.bottom, 49)
            
            Spacer()
        }.background(Color("BackgroundColor"))
    }
}

#Preview {
    FinchNestView()
}
