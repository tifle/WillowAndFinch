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

        let textColor = UIColor(named: "TextColor") ?? .label
        let normalFont = UIFont(name: "Avenir", size: 11)!
        let boldFont = UIFont.boldSystemFont(ofSize: 11) // Bold font
        let selectedColor = UIColor(named: "Grass")

        // Title text attributes
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: textColor,
            .font: normalFont
        ]
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: textColor,
            .font: boldFont // Bold font for selected tab
        ]

        // Icon color attributes
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = textColor
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = selectedColor

        // Global tint
        UITabBar.appearance().tintColor = selectedColor
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }



    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
