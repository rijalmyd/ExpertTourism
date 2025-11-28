//
//  APICall.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 18/11/25.
//

import Foundation

struct API {
    static let baseURL = "https://tourism-api.dicoding.dev/"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    enum Gets: Endpoint {
        case list
        case detail(id: Int)
        
        public var url: String {
            switch self {
            case .list: return "\(API.baseURL)list"
            case .detail(let id): return "\(API.baseURL)detail/\(id)"
            }
        }
    }
}
