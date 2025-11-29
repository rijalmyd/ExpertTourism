//
//  HomeViewModel.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 20/11/25.
//

import Foundation
import Combine
import Core

public class HomeViewModel: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let getTourismPlacesUseCase: GetTourismPlacesUseCase
    
    @Published var tourismPlaces = [TourismPlaceModel]()
    @Published var isLoading = false
    @Published var errorMessage: String = ""
    
    public init(getTourismPlacesUseCase: GetTourismPlacesUseCase) {
        self.getTourismPlacesUseCase = getTourismPlacesUseCase
    }
    
    func getTourismPlaces() {
        isLoading = true
        getTourismPlacesUseCase.getTourismPlaces()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { [weak self] tourismPlaces in
                self?.tourismPlaces = tourismPlaces
            })
            .store(in: &cancellables)
    }
}
