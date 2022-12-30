//
//  AssetModel.swift
//  
//
//  Created by Murilo Araujo on 30/12/22.
//

import Foundation

public struct AssetModel: Codable, Hashable {
    public let id: Int
    public let name: String
    public let created_at: String
    public let updated_at: String
}
