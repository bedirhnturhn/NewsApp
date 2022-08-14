//
//  THNewsRequest.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 12.07.2022.
//

import Foundation


struct THNewsRequest : DataRequest {
    var page : Int
    var selectedCategory : THCategories
    
    init(selectedCategory : THCategories, page : Int){
        self.page = page
        self.selectedCategory = selectedCategory
    }
    
    var path: String {
        EndPointType.topHeadline.rawValue
    }
    
    var queryItems: [String : String]{
        ["apiKey" : APISettings.news_api_key,
         "country" : APISettings.country,
         "pageSize": "\(10)",
         "page": "\(page)",
         "category": selectedCategory.rawValue]
    }
    
    func decode(_ data: Data) throws -> [THArticleModel] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try decoder.decode(THNewsModel.self, from: data)
        return response.articles
        
    }
    
}
