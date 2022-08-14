//
//  NewswithQueryWordRequest.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 14.08.2022.
//

import Foundation

struct NewsWithQueryWordRequest : DataRequest{
    var queryWord : String
    var page : Int
    
    init(_ queryWord : String, _ page : Int){
        self.page = page
        self.queryWord = queryWord
    }
    
    var path: String{
        EndPointType.everything.rawValue
    }
    
    var queryItems: [String : String]{
        ["apiKey" : APISettings.news_api_key,
         "country" : APISettings.country,
         "pageSize": "\(10)",
         "page": "\(page)",
         "q": queryWord]
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
