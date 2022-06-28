//
//  News.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 6/16/21.
//

import Foundation


struct SourceStatus : Codable {
    let status : String
    let articles : [News]
}

struct News : Codable{
    
    //var author : String?
    var title : String
    var description : String?
    var url : String
    var urlToImage : String? 
    var publishedAt : String?
    var content : String?
    
}
