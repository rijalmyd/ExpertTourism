//
//  ContentView.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 11/11/25.
//

import SwiftUI
import Home
import Detail
import Favorite
import About

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomeView(
                viewModel: Resolver.shared.resolve(HomeViewModel.self),
                action: { id in
                    PlaceDetailView(
                        viewModel: Resolver.shared.resolve(PlaceDetailViewModel.self),
                        id: id
                    )
                }
            )
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            FavoriteView(
                viewModel: Resolver.shared.resolve(FavoriteViewModel.self),
                action: { id in
                    PlaceDetailView(
                        viewModel: Resolver.shared.resolve(PlaceDetailViewModel.self),
                        id: id
                    )
                }
            )
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
