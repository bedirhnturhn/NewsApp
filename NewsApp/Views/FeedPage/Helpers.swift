//
//  Helpers.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 8/19/21.
//

import UIKit
import Alamofire


extension FeedPage{
    func fetchData()   {
        AF.request("https://newsapi.org/v2/everything?q=apple&sortBy=popularity&apiKey=565b53ef125c494985797acd7d1cfdf4")
            .validate()
            .responseDecodable(of: SourceStatus.self) { (response) in
                guard let stored = response.value?.articles else { return }
                self.topHeadlines = stored
                self.collectionView.reloadData()
        }
    }
    
    func fetchOtherData() {
        AF.request("https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=565b53ef125c494985797acd7d1cfdf4")
            .validate()
            .responseDecodable(of: SourceStatus.self) { (response) in
                guard let stored = response.value?.articles else { return }
                self.otherNEws = stored
                self.collectionView.reloadData()
            }
    }
}
