//
//  DataRequest.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 12.07.2022.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}


protocol DataRequest {
    associatedtype Response
    
    var method: HttpMethod { get }
    var scheme: String { get }
    var host: String { get }
    var headers: [String : String] { get }
    var queryItems: [String : String] { get }
    var path: String { get }
    func decode(_ data: Data) throws -> Response
}

// 3
extension DataRequest where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

extension DataRequest {
    var method: HttpMethod {
        return .get
    }

    var scheme: String {
        return APISettings.scheme
    }
    
    var host: String {
        return APISettings.host
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [:]
    }
    
    func createUrlString() -> String {
        return "\(scheme)://\(host)\(path)"
    }
}

