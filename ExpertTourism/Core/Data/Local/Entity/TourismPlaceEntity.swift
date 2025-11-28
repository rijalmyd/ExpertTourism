//
//  TourismPlaceEntity.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 18/11/25.
//

import Foundation
import RealmSwift

class TourismPlaceEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    @objc dynamic var like: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
