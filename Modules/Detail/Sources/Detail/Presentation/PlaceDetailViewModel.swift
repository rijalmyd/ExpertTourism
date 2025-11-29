//
//  PlaceDetailViewModel.swift
//  Detail
//
//  Created by Rijal Muhyidin on 20/11/25.
//

import Foundation
import SwiftUI
import Combine
import Core

public class PlaceDetailViewModel: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let addFavoriteUseCase: AddFavoriteTourismPlaceUseCase
    private let checkFavoriteUseCase: CheckFavoriteTourismPlaceUseCase
    private let getTourismPlaceUseCase: GetTourismPlaceUseCase
    private let removeFavoriteUseCase: RemoveFavoriteTourismPlaceUseCase
    
    @Published var tourismPlace: TourismPlaceModel?
    @Published var isLoading = false
    @Published var errorMessage: String = ""
    @Published var isFavorite = false
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false

    public init(
        addFavoriteUseCase: AddFavoriteTourismPlaceUseCase,
        checkFavoriteUseCase: CheckFavoriteTourismPlaceUseCase,
        getTourismPlaceUseCase: GetTourismPlaceUseCase,
        removeFavoriteUseCase: RemoveFavoriteTourismPlaceUseCase
    ) {
        self.addFavoriteUseCase = addFavoriteUseCase
        self.checkFavoriteUseCase = checkFavoriteUseCase
        self.getTourismPlaceUseCase = getTourismPlaceUseCase
        self.removeFavoriteUseCase = removeFavoriteUseCase
    }
    
    func getTourismPlace(id: Int) {
        isLoading = true
        getTourismPlaceUseCase.getTourismPlace(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { [weak self] place in
                self?.tourismPlace = place
                self?.checkFavoriteStatus(for: place.id)
            })
            .store(in: &cancellables)
    }
    
    private func checkFavoriteStatus(for id: Int) {
        checkFavoriteUseCase.isFavoriteTourismPlace(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: {  [weak self] status in
                self?.isFavorite = status
            })
            .store(in: &cancellables)
    }
    
    func toggleFavorite() {
        guard let place = tourismPlace else { return }
        
        let publisher = isFavorite
            ? removeFavoriteUseCase.removeFavoriteTourismPlace(id: place.id)
            : addFavoriteUseCase.addFavoriteTourismPlace(from: place)
        
        publisher
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        self.errorMessage = String(describing: completion)
                        self.showAlert = true
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] _ in
                    guard let self = self else { return }
                    self.isFavorite.toggle()

                    self.alertMessage = self.isFavorite
                        ? "Successfully added to favorite"
                        : "Removed from favorite"

                    self.showAlert = true
                }
            )
            .store(in: &cancellables)
    }
}
