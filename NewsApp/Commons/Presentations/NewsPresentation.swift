//
//  NewsPresentation.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 2.07.2022.
//

import UIKit

final class NewsPresentation {
    let source: String
    let author: String?
    let title: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content : String?
    
    init(source: String, author: String?, title: String, url: String, urlToImage: String?, publishedAt: String,content : String?) {
        self.source = source
        self.author = author
        self.title = title
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    convenience init(topHeadline: THArticleModel) {
        self.init(source: topHeadline.source.name, author: topHeadline.author, title: topHeadline.title, url: topHeadline.url, urlToImage: topHeadline.urlToImage, publishedAt: topHeadline.publishedAt, content: topHeadline.content)
    }
}

extension NewsPresentation: Equatable {
    static func == (lhs: NewsPresentation, rhs: NewsPresentation) -> Bool {
        return lhs.author == rhs.author && lhs.source == rhs.source && lhs.publishedAt == rhs.publishedAt && lhs.title == rhs.title && lhs.url == rhs.url && lhs.urlToImage == rhs.urlToImage

    }
    
    
}
