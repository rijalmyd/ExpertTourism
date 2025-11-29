//
//  LocalDataSource.swift
//  Favorite
//
//  Created by Rijal Muhyidin on 29/11/25.
//

import Core
import Combine
import RealmSwift

public protocol FavoriteLocalDataSourceProtocol: AnyObject {
    func getFavoriteTourismPlaces() -> AnyPublisher<[TourismPlaceEntity], Error>
}

public class FavoriteLocalDataSource: FavoriteLocalDataSourceProtocol {
    
    private let realm: Realm?
    
    public init(realm: Realm?) {
        self.realm = realm
    }
    
    public func getFavoriteTourismPlaces() -> AnyPublisher<[TourismPlaceEntity], Error> {
        return Future<[TourismPlaceEntity], Error> { completion in
            if let realm = self.realm {
                let places: Results<TourismPlaceEntity> = {
                    realm.objects(TourismPlaceEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(places.toArray(ofType: TourismPlaceEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}
