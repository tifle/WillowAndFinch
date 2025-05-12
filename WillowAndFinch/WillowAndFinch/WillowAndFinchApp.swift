//
//  WillowAndFinchApp.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/4/25.
//

import SwiftUI

@main
struct WillowAndFinchApp: App {
    
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(named: "TabColor")

        // Customize tab bar item font and color
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Avenir", size: 12)!,
            .foregroundColor: UIColor.label  // Or a custom color if you prefer
        ]

        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .selected)

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
