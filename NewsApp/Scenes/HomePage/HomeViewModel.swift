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
    let newsServices = NewsService()
    weak var sliderObject : HomePageHeader?
    
    func load() {
        notify(.setTitle("HOME"))
        fetchTopNews()
        fetchOtherNews()
    }
    
    func fetchTopNews() {
        newsServices.fetchTHNewsDelegate(5, .business) { [self] result in
            switch result {
            case .success(let fetchedNews):
                topHeadlinesNEws = fetchedNews
                let presentationArray = topHeadlinesNEws.map({NewsPresentation(topHeadline: $0)})
                notify(.updateHeader(presentationArray))
            case .failure(let error):
                delegate?.handleViewModelOutput(.showNotification(result: false, notificationText: error.rawValue))
            }
        }
    }
    
    func fetchOtherNews() {
        newsServices.fetchDelegate(10) {[self] result in
            switch(result){
            case .success(let fetchedNews):
                otherNews = fetchedNews
                let presentationArray = otherNews.map({NewsPresentation(topHeadline: $0)})
                notify(.updateCollectionView(presentationArray))
            case .failure(let error):
                delegate?.handleViewModelOutput(.showNotification(result: false, notificationText: error.rawValue))
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
