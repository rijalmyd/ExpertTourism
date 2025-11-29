//
//  AppModule.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 19/11/25.
//

import Swinject
import RealmSwift
import Home
import Detail
import Favorite

class Resolver {
    static let shared = Resolver()
    private var container = Container()
    private let realm = try? Realm()
    
    @MainActor func injectModules() {
        injectHomeModule()
        injectFavoriteModule(realm: realm)
        injectDetailModule(realm: realm)
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}

extension Resolver {
    private func injectHomeModule() {
        container.register(HomeRemoteDataSourceProtocol.self) { _ in
            HomeRemoteDataSource()
        }.inObjectScope(.container)
        
        container.register(HomeRepositoryProtocol.self) { resolver in
            HomeRepository(
                remoteDataSource: resolver.resolve(HomeRemoteDataSourceProtocol.self)!
            )
        }.inObjectScope(.container)
        
        container.register(GetTourismPlacesUseCase.self) { resolver in
            GetTourismPlacesInteractor(
                homeRepository: resolver.resolve(HomeRepositoryProtocol.self)!
            )
        }.inObjectScope(.container)
        
        container.register(HomeViewModel.self) { resolver in
            HomeViewModel(
                getTourismPlacesUseCase: resolver.resolve(GetTourismPlacesUseCase.self)!
            )
        }.inObjectScope(.container)
    }
}

extension Resolver {
    private func injectFavoriteModule(realm: Realm?) {
        container.register(FavoriteLocalDataSourceProtocol.self) { _ in
            FavoriteLocalDataSource(realm: realm)
        }.inObjectScope(.container)
        
        container.register(FavoriteRepositoryProtocol.self) { resolver in
            FavoriteRepository(
                localDataSource: resolver.resolve(FavoriteLocalDataSourceProtocol.self)!
            )
        }.inObjectScope(.container)
        
        container.register(GetFavoriteTourismPlacesUseCase.self) { resolver in
            GetFavoriteTourismPlacesInteractor(
                favoriteRepository: resolver.resolve(FavoriteRepositoryProtocol.self)!
            )
        }.inObjectScope(.container)
        
        container.register(FavoriteViewModel.self) { resolver in
            FavoriteViewModel(
                getFavoriteTourismPlacesUseCase: resolver.resolve(GetFavoriteTourismPlacesUseCase.self)!
            )
        }.inObjectScope(.container)
    }
}

extension Resolver {
    private func injectDetailModule(realm: Realm?) {
        container.register(DetailRemoteDataSourceProtocol.self) { _ in
            DetailRemoteDataSource()
        }.inObjectScope(.container)
        
        container.register(DetailLocalDataSourceProtocol.self) { _ in
            DetailLocalDataSource(realm: realm)
        }.inObjectScope(.container)
        
        container.register(DetailRepositoryProtocol.self) { resolver in
            DetailRepository(
                remoteDataSource: resolver.resolve(DetailRemoteDataSourceProtocol.self)!,
                localDataSource: resolver.resolve(DetailLocalDataSourceProtocol.self)!
            )
        }.inObjectScope(.container)
        
        container.register(AddFavoriteTourismPlaceUseCase.self) { resolver in
            AddFavoriteTourismPlaceInteractor(
                detailRepository: resolver.resolve(DetailRepositoryProtocol.self)!
            )
        }.inObjectScope(.container)
        
        container.register(CheckFavoriteTourismPlaceUseCase.self) { resolver in
            CheckFavoriteTourismPlaceInteractor(
                detailRepository: resolver.resolve(DetailRepositoryProtocol.self)!
            )
        }.inObjectScope(.container)
        
        container.register(GetTourismPlaceUseCase.self) { resolver in
            GetTourismPlaceInteractor(
                detailRepository: resolver.resolve(DetailRepositoryProtocol.self)!
            )
        }.inObjectScope(.container)
        
        container.register(RemoveFavoriteTourismPlaceUseCase.self) { resolver in
            RemoveFavoriteTourismPlaceInteractor(
                detailRepository: resolver.resolve(DetailRepositoryProtocol.self)!
            )
        }.inObjectScope(.container)
        
        container.register(PlaceDetailViewModel.self) { resolver in
            PlaceDetailViewModel(
                addFavoriteUseCase: resolver.resolve(AddFavoriteTourismPlaceUseCase.self)!,
                checkFavoriteUseCase: resolver.resolve(CheckFavoriteTourismPlaceUseCase.self)!,
                getTourismPlaceUseCase: resolver.resolve(GetTourismPlaceUseCase.self)!,
                removeFavoriteUseCase: resolver.resolve(RemoveFavoriteTourismPlaceUseCase.self)!
            )
        }.inObjectScope(.container)
    }
}
