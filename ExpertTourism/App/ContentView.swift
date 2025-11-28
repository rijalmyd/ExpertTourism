//
//  ContentView.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 11/11/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorite")
                }
            AboutMeView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("About Me")
                }
        }
    }
}

#Preview {
    ContentView()
}
