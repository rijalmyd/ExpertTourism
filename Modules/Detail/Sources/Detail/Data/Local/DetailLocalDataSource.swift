//
//  LocalDataSource.swift
//  Detail
//
//  Created by Rijal Muhyidin on 29/11/25.
//

import Foundation
import RealmSwift
import Combine
import Core

public protocol DetailLocalDataSourceProtocol: AnyObject {
    func addFavoriteTourismPlace(from tourismPlace: TourismPlaceEntity) -> AnyPublisher<Bool, Error>
    func isFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error>
    func removeFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error>
}

public class DetailLocalDataSource: DetailLocalDataSourceProtocol {
    
    private let realm: Realm?
    
    public init(realm: Realm?) {
        self.realm = realm
    }
    
    public func addFavoriteTourismPlace(from tourismPlace: TourismPlaceEntity) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(tourismPlace, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func isFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                let place: TourismPlaceEntity? = realm.object(ofType: TourismPlaceEntity.self, forPrimaryKey: id)
                completion(.success(place != nil))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func removeFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        if let place: TourismPlaceEntity = realm.object(ofType: TourismPlaceEntity.self, forPrimaryKey: id) {
                            realm.delete(place)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}
