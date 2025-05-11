//
//  FinchNestView.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

extension Color {
    static let sageGreen = Color(red: 0.49, green: 0.55, blue: 0.40)
    static let lightGrayBackground = Color(red: 0.95, green: 0.95, blue: 0.97)
}

struct FinchNestView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
                // Title with background
                Text("Your Nest")
                    .font(.custom("Didot", size: 32))
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 0.49, green: 0.55, blue: 0.40))
                
                Text("    Currently Reading")
                    .font(.custom("Didot", size: 16))
                List {
                    NavigationLink("The Yellow Wallpaper", destination: ReadingView())
                    Text("Another Current Book")
                }
                
                Text("     Saved for Later")
                    .font(.custom("Didot Bold", size: 16))
                List {
                    Text("Book You Saved")
                        .font(.custom("Didot", size: 16))
                }
                
                Spacer()
            }
        }
    }

