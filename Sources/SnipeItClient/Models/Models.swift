//
//  File.swift
//  
//
//  Created by Murilo Araujo on 26/12/22.
//

import Foundation

public enum SortOrder: String {
    case asc = "asc"
    case desc = "desc"
}

public class AssetModels {
    public class Fetch {
        var limit = 50
        var offset = 0
        var search: String?
        var sort = SortOrder.asc
        
        public struct Response: Codable {
            public let total: Int
            public let rows: [AssetModel]
        }
        
        public init() {}
        
        public func with(limitOf limit: Int) -> Fetch {
            self.limit = limit
            return self
        }
        
        public func with(offSetOf offSet: Int) -> Fetch {
            self.offset = offSet
            return self
        }
        
        public func searching(for searchString: String) -> Fetch {
            self.search = searchString
            return self
        }
        
        public func sorting(in sort: SortOrder) -> Fetch {
            self.sort = sort
            return self
        }
        
        public func getResults() async throws -> Response {
            return try await SnipeIt.API.Request<Response>(path: "/models", method: .get).execute()
        }
    }
    
    public class Add: Codable {
        let name: String
        var model_number: String? = nil
        let category_id: Int32
        let manufacturer_id: Int32
        var eol: Int32? = nil
        
        public struct Response: Codable {
            let id: Int
            let name: String
            let created_at: String
            let updated_at: String
        }
        
        public init(name: String, categoryID: Int32, manufacturerID: Int32) {
            self.name = name
            category_id = categoryID
            manufacturer_id = manufacturerID
        }
        
        public func with(modelNumber: String) -> Add {
            model_number = modelNumber
            return self
        }
        
        public func with(eol: Int32) -> Add {
            self.eol = eol
            return self
        }
        
        public func getResult() async throws -> Response {
            return try await SnipeIt.API.Request<Response>(path: "/models", method: .post, body: self).execute()
        }
    }
}
