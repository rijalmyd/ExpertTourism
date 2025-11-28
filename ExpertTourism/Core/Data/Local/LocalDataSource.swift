//
//  LocalDataSource.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 18/11/25.
//

import Foundation
import RealmSwift
import Combine

protocol LocalDataSourceProtocol: AnyObject {
    func getFavoriteTourismPlaces() -> AnyPublisher<[TourismPlaceEntity], Error>
    func addFavoriteTourismPlace(from tourismPlace: TourismPlaceEntity) -> AnyPublisher<Bool, Error>
    func isFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error>
    func removeFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error>
}

class LocalDataSource: LocalDataSourceProtocol {
    
    private let realm: Realm?
    
    init(realm: Realm?) {
        self.realm = realm
    }
    
    func getFavoriteTourismPlaces() -> AnyPublisher<[TourismPlaceEntity], any Error> {
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
    
    func addFavoriteTourismPlace(from tourismPlace: TourismPlaceEntity) -> AnyPublisher<Bool, any Error> {
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
    
    func isFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                let place: TourismPlaceEntity? = realm.object(ofType: TourismPlaceEntity.self, forPrimaryKey: id)
                completion(.success(place != nil))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func removeFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, any Error> {
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

extension Results {
    
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
