//
//  NewsWithSourcesRequest.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 14.08.2022.
//

import Foundation

struct NewsWithSourcesRequest : DataRequest {
    var page : Int
    var source : String
    
    init(_ page : Int, _ source : String){
        self.page = page
        self.source = source
    }
    
    var path: String {
        EndPointType.everything.rawValue
    }
    
    var queryItems: [String : String]{
        ["apiKey" : APISettings.news_api_key,
         "country" : APISettings.country,
         "pageSize": "\(10)",
         "page": "\(page)",
         "sources" : source,
        ]
    }
    
    func decode(_ data: Data) throws -> [EArticleModel] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try decoder.decode(ENewsModel.self, from: data)
        return response.articles
    }
}

