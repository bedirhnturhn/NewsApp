//
//  NewsDetailViewController1.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 3.07.2022.
//

import Foundation


final class NewsDetailViewModel : NewsDetailViewModelProtocol{
    var delegate: NewsDetailViewModelDelegate?
    var selectedNews : THArticleModel
    
    init(_ selectedNews: THArticleModel){
        self.selectedNews = selectedNews
    }
    
    func load() {
        notify(.setTitle("News Detail"))
        notify(.setLoading(true))
        let presentation = NewsPresentation(topHeadline: selectedNews)
        notify(.showNewsDetail(presentation))
        notify(.setLoading(false))
    }
    
    func saveToDB() {
        
    }
    
    func deleteFromDB() {
        
    }
    
    func showNewsDetailsInBrowser() {
        notify(.setLoading(true))
        guard let url = URL(string: selectedNews.url) else {
            notify(.setLoading(false))
            notify(.showNotification(result: false, notificationText: "News url is broken."))
            return
        }
        notify(.setLoading(false))
        delegate?.navigate(to: .showNewsDetailsInSafari(url))
        
        
        
    }
    
    private func notify(_ output : NewsDetailViewModelOutput){
        delegate?.handleViewModelOutput(output)
    }
    
}
