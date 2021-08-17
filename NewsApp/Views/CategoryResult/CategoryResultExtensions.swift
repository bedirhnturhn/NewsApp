//
//  CategorySourceExtensions.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 8/13/21.
//

import UIKit
import Alamofire

extension CategoryResult {
    func fetchingNews(categoryName : String){
        AF.request("https://newsapi.org/v2/top-headlines?country=us&category=\(categoryName)&apiKey=565b53ef125c494985797acd7d1cfdf4")
            .validate()
            .responseDecodable(of: SourceStatus.self) { (response) in
                guard let stored = response.value?.articles else { return }
                self.news = stored
                print("tamamke")
                self.collectionView.reloadData()
        }
    }
}
