//
//  CategoryResultViewModel.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 2.07.2022.
//

import Foundation


final class CategoryResultViewModel : CategoryResultViewModelProtocol {
    //MARK: -Properties
    //presentation
    let selectedCategory : THCategories
    weak var delegate: CategoryResultViewModelDelegate?
    let service : NewNewsServiceProtocol!
    var newsModelArray = [THArticleModel]()
    
    init(_ selectedCategory : THCategories, service : NewNewsServiceProtocol){
        self.selectedCategory = selectedCategory
        self.service = service
    }
    
    func load() {
        notify(.setLoading(true))
        notify(.updateTitle(selectedCategory.rawValue.uppercased()))
        fetchNews(selectedCategory: selectedCategory)
    }
    
    private func fetchNews(selectedCategory : THCategories){
        let request = THNewsRequest(selectedCategory: selectedCategory, page: 1)
        service.fetchNews(request) { [self]result in
            switch result{
            case .failure(let err):
                notify(.showNotification(status: false, text: err.rawValue))
            case.success(let articles):
                newsModelArray = articles
                let presentations = newsModelArray.map({NewsPresentation(topHeadline: $0)})
                notify(.updateApps(presentations))
            }
        }
    }
    
    func didSelectNews(selected index: Int) {
        delegate?.navigate(to: .newsDetail(newsModelArray[index]))
    }
    
    private func notify(_ output: CategoryResultViewModelOutput){
        delegate?.handleViewModelOutput(output)
    }
    
}
