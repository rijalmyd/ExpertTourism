//
//  TourismPlaceMapper.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 18/11/25.
//

extension [TourismPlaceResponse] {
    func toDomain() -> [TourismPlaceModel] {
        return self.map { response in
            response.toDomain()
        }
    }
}

extension TourismPlaceResponse {
    func toDomain() -> TourismPlaceModel {
        return TourismPlaceModel(
            id: self.id ?? 0,
            name: self.name ?? "",
            description: self.description,
            image: self.image,
            address: self.address,
            latitude: self.latitude,
            longitude: self.longitude,
            like: self.like ?? 0
        )
    }
}

extension [TourismPlaceEntity] {
    func toDomain() -> [TourismPlaceModel] {
        return self.map { entity in
            entity.toDomain()
        }
    }
}

extension TourismPlaceEntity {
    func toDomain() -> TourismPlaceModel {
        return TourismPlaceModel(
            id: self.id,
            name: self.name,
            description: self.desc,
            image: self.image,
            address: self.address,
            latitude: self.latitude,
            longitude: self.longitude,
            like: self.like
        )
    }
}

extension TourismPlaceModel {
    func toEntity() -> TourismPlaceEntity {
        let entity = TourismPlaceEntity()
        entity.id = self.id
        entity.name = self.name
        entity.desc = self.description ?? ""
        entity.image = self.image ?? ""
        entity.address = self.address ?? ""
        entity.latitude = self.latitude ?? 0
        entity.longitude = self.longitude ?? 0
        entity.like = self.like
        return entity
    }
}
