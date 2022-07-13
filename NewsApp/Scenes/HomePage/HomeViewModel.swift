//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 27.06.2022.
//

import Foundation

final class HomeViewModel : HomeViewModelProtocol {
    var delegate : HomeViewModelDelegate?
    var otherNews = [THArticleModel]()
    var topHeadlinesNEws = [THArticleModel]()
    weak var sliderObject : HomePageHeader?
    private let networkService : NewNewsServiceProtocol
    
    init(networkService : NewNewsServiceProtocol){
        self.networkService = networkService
    }
    
    func load() {
        notify(.setTitle("HOME"))
        fetchTopNews()
        fetchOtherNews()
    }
    
    func fetchTopNews() {
        let request = THNewsRequest(selectedCategory: .general, page: 1)
        networkService.fetchNews(request) { result in
            switch result {
            case.failure(let errorResponse):
                self.notify(.showNotification(result: false, notificationText: errorResponse.rawValue))
            case .success(let articles):
                self.topHeadlinesNEws = articles
                let presentationArray = self.topHeadlinesNEws.map({NewsPresentation(topHeadline: $0)})
                self.notify(.updateHeader(presentationArray))
            }
        }
    }
    
    func fetchOtherNews(page : Int = 2){
        let request = THNewsRequest(selectedCategory: .general, page: page)
        networkService.fetchNews(request) { result in
            switch result {
            case .failure(let err):
                self.notify(.showNotification(result: false, notificationText: err.rawValue))
            case .success(let articles):
                self.otherNews = articles
                let presentationArray = self.otherNews.map({NewsPresentation(topHeadline: $0)})
                self.notify(.updateCollectionView(presentationArray))
            }
        }
    }
    
    func didSelectNews(selected index: IndexPath) {
        let selectedTHArticle = otherNews[index.row]
        delegate?.navigate(to: .newsDetail(selectedTHArticle))
    }
    
    func didSelectNewsFromHeader(selectedIndex: Int) {
        let selectedHeaderTHArticle = topHeadlinesNEws[selectedIndex]
        delegate?.navigate(to: .newsDetail(selectedHeaderTHArticle))
    }
    
    private func notify(_ output : HomeViewModelOutput){
        delegate?.handleViewModelOutput(output)
    }
}
