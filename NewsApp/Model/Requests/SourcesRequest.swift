//
//  SourcesRequest.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 17.07.2022.
//

import Foundation

struct SourcesRequest : DataRequest {
    let category : THCategories
    let language : String
    let country : String

    init(category: THCategories, language : String = APISettings.language,country : String = APISettings.country){
        self.category = category
        self.language = language
        self.country = country
    }

    var path: String {
        EndPointType.sources.rawValue
    }

    var queryItems: [String : String]{
        ["apiKey" : APISettings.news_api_key,
         "country" : APISettings.country,
         "category": category.rawValue]
    }
    
    func decode(_ data: Data) throws -> [Sources] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try decoder.decode(SourcesModel.self, from: data)
        return response.sources
    }
}
