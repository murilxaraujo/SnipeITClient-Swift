//
//  AssetModel.swift
//  
//
//  Created by Murilo Araujo on 30/12/22.
//

import Foundation

public struct Dates: Codable, Hashable {
    public let datetime: String
    public let formatted: String
}

public struct IDName: Codable, Hashable {
    public let id: Int
    public let name: String
}

public struct Actions: Codable, Hashable {
    public let update: Bool
    public let delete: Bool
    public let clone: Bool
    public let restore: Bool
}

public struct AssetModel: Codable, Hashable {
    public let id: Int
    public let name: String
    public let createdAtString: Dates
    public let updatedAtString: Dates
    public let category: IDName
    public let manufacturer: IDName
    public let modelNumber: String
    public let assetsCount: Int
    public let actions: Actions
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case createdAtString = "created_at"
        case updatedAtString = "updated_at"
        case category
        case manufacturer
        case modelNumber = "model_number"
        case assetsCount = "assets_count"
        case actions = "available_actions"
    }
}
