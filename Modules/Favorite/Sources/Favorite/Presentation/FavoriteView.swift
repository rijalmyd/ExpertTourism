//
//  FavoriteView.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 20/11/25.
//

import Core
import SwiftUI

public struct FavoriteView<Destination: View>: View {
    
    @StateObject public var viewModel: FavoriteViewModel
    let action: (_ id: Int) -> Destination
    
    public init(viewModel: FavoriteViewModel, action: @escaping (_ id: Int) -> Destination) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.action = action
    }
    
    public var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    VStack {
                        Spacer()
                        ProgressView("Loading places...")
                            .font(.caption2)
                            .progressViewStyle(CircularProgressViewStyle(tint: .green))
                            .scaleEffect(1.5)
                        Spacer()
                    }
                } else if !viewModel.errorMessage.isEmpty {
                    VStack {
                        Spacer()
                        Text("Something went wrong!\nPlease try again later.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.red)
                            .padding()
                        Spacer()
                    }
                } else if viewModel.tourismPlaces.isEmpty {
                    VStack {
                        Spacer()
                        Text("No favorite place found.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.red)
                            .padding()
                        Spacer()
                    }
                } else {
                    TourismPlaceItemList(
                        places: viewModel.tourismPlaces,
                        action: self.action
                    )
                }
            }
            .navigationBarTitle("Favorite", displayMode: .inline)
            .onAppear {
                viewModel.getFavoriteTourismPlaces()
            }
        }
    }
}

