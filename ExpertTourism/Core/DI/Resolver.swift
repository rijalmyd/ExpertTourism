//
//  AppModule.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 19/11/25.
//

import Swinject
import RealmSwift

class Resolver {
    static let shared = Resolver()
    private var container = Container()
    
    @MainActor func injectModules() {
        injectRemoteDataSource()
        injectLocalDataSource()
        injectRepositories()
        injectUseCases()
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}

extension Resolver {
    private func injectRemoteDataSource() {
        container.register(RemoteDataSourceProtocol.self) { _ in
            RemoteDataSource()
        }.inObjectScope(.container)
    }
}

extension Resolver {
    private func injectLocalDataSource() {
        container.register(LocalDataSourceProtocol.self) { resolver in
            LocalDataSource(realm: try? Realm())
        }.inObjectScope(.container)
    }
}

extension Resolver {
    private func injectRepositories() {
        container.register(TourismPlaceRepositoryProtocol.self) { resolver in
            TourismPlaceRepository(
                remoteDataSource: resolver.resolve(RemoteDataSourceProtocol.self)!,
                localDataSource: resolver.resolve(LocalDataSourceProtocol.self)!
            )
        }.inObjectScope(.container)
    }
}

extension Resolver {
    private func injectUseCases() {
        container.register(HomeUseCase.self) { resolver in
            HomeInteractor(
                tourismPlaceRepository: resolver.resolve(TourismPlaceRepositoryProtocol.self)!
            )
        }.inObjectScope(.container)
        container.register(DetailUseCase.self) { resolver in
            DetailInteractor(
                tourismPlaceRepository: resolver.resolve(TourismPlaceRepositoryProtocol.self)!
            )
        }.inObjectScope(.container)
        container.register(FavoriteUseCase.self) { resolver in
            FavoriteInteractor(
                tourismPlaceRepository: resolver.resolve(TourismPlaceRepositoryProtocol.self)!
            )
        }.inObjectScope(.container)
    }
}
