//
//  BookDetailView.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

struct BookDetailView: View {
    var body: some View {
        ZStack{
            Color.latteMilk.ignoresSafeArea(edges: .bottom)
            Color.warmBeige.ignoresSafeArea(edges: .top)
            
                        
            VStack{
                Image("DefaultCover")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .frame(width: 200)
                
                    .padding(50)
                
                Text("Title")
                    .font(.custom("Georgia", size: 25))
                    .bold()
                Text("Author")
                    .font(.custom("Georgia", size: 18))
                    .italic()
                
//enter regular book.csv file to get this info + change cover from default
                ScrollView{
                    Spacer(minLength: 30)
                    Text("Potentially Summary?")
                    Text("Year of publication")
                    Text("Publisher")
                }
            }
        }
    }
}

#Preview {
    BookDetailView()
}
