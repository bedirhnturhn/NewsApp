//
//  News.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 6/16/21.
//

import Foundation


struct SourceStatus : Decodable {
    let status : String
    let articles : [News]
}

struct News : Decodable {
    
    enum CodingKeys : String , CodingKey {
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case contents = "content"
    }
    
    var author : String?
    var title : String
    var description : String
    var url : URL
    var urlToImage : URL
    var publishedAt : Date
    var contents : String
    
}


