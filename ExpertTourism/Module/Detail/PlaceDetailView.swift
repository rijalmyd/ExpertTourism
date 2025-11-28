//
//  DetailView.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 20/11/25.
//

import SwiftUI
import SDWebImageSwiftUI
import _MapKit_SwiftUI

struct PlaceDetailView: View {
    
    @StateObject var viewModel = PlaceDetailViewModel(
        detailUseCase: Resolver.shared.resolve(DetailUseCase.self),
        favoriteUseCase: Resolver.shared.resolve(FavoriteUseCase.self)
    )
    
    var id: Int
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                VStack {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            } else if !viewModel.errorMessage.isEmpty {
                VStack {
                    Spacer()
                    Text("Something went wrong!\nPlease try again later.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red)
                        .padding()
                    Spacer()
                }
                
            } else if let place = viewModel.tourismPlace {
                ScrollView {
                    LazyVStack {
                        WebImage(url: URL(string: place.image ?? ""))
                            .resizable()
                            .indicator(.activity)
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, minHeight: 256, alignment: .center)
                            .clipped()
                            .cornerRadius(8)
                            .padding()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(place.name)
                                .font(.title)
                                .fontWeight(.semibold)

                            HStack(alignment: .center, spacing: 6) {
                                Text(place.address ?? "-")
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)

                                Text("\(place.like)")
                                    .font(.caption)
                            }

                            Divider()
                                .padding(.vertical, 8)

                            Text(place.description ?? "")
                                .font(.body)
                            
                            Map(
                                initialPosition: MapCameraPosition.region(
                                    MKCoordinateRegion(
                                        center: CLLocationCoordinate2D(
                                            latitude: -2.5,
                                            longitude: 118
                                        ),
                                        span: MKCoordinateSpan(
                                            latitudeDelta: 40,
                                            longitudeDelta: 40
                                        )
                                    )
                                )
                            ) {
                                Marker(
                                    place.address ?? "",
                                    coordinate: CLLocationCoordinate2D(
                                        latitude: place.latitude ?? 0,
                                        longitude: place.longitude ?? 0
                                    )
                                )
                            }
                            .mapStyle(.imagery)
                            .frame(height: 200)
                            .cornerRadius(8)

                        }
                        .padding(.horizontal, 16)
                    }
                }
            } else {
                Text("No details available.")
                    .foregroundColor(.secondary)
            }
        }
        .onAppear {
            viewModel.getTourismPlace(id: id)
        }
        .navigationTitle(viewModel.tourismPlace?.name ?? "Detail")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if viewModel.tourismPlace != nil {
                    Button(action: {
                        viewModel.toggleFavorite()
                    }) {
                        Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.alertMessage))
        }
    }
}
