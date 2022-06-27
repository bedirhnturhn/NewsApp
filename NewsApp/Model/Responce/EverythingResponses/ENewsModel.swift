//
//  ENewsModel.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 27.06.2022.
//

import Foundation

struct ENewsModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [EArticleModel]
}
