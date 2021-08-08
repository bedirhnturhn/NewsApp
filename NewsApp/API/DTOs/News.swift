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
    
    //var author : String?
    var title : String
    //var description : String
    var url : String
    var urlToImage : String
    //var publishedAt : String
    //var content : String
    
}
/*
extension News : Displayable {
    var imageUrl: String {
        urlToImage
    }
    
    var titleLabelText: String {
        title
    }
    
    var desciptionText: String {
        description
    }
    
    var dateText: String {
        publishedAt
    }
    
    var sourceText: String {
        author ?? "Unknown"
    }
    
    
    
    
}
*/
