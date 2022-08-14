//
//  SearchViewModel.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 14.08.2022.
//

import Foundation

final class SearchViewModel : SearchViewModelProtocol {
    weak var delegate: SearchViewModelDelegate?
    var sources: [Sources] = []
    var services : NewNewsServiceProtocol
    
    init(_ service : NewNewsServiceProtocol){
        self.services = service
    }
    
    func load() {
        notify(.setTitle("Search"))
        notify(.setLoading(true))
        let requestModel = SourcesRequest(category: .technology)
        services.fetchNews(requestModel) {[self] result in
            switch result{
            case .failure(let errorResponce):
                notify(.setLoading(false))
                notify(.showNotification(result: false, notificationText: errorResponce.rawValue))
            case .success(let resources):
                self.sources = resources
                notify(.setLoading(false))
                notify(.updateSourcesList)
            }
        }
    }
    
    private func notify(_ output : SearchViewModelOutput){
        delegate?.handleViewModelOutput(output)
    }
}
