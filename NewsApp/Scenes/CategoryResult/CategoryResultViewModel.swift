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
    let service : NewsServiceProtocol?
    
    init(_ selectedCategory : THCategories, service : NewsServiceProtocol = NewsService()){
        self.selectedCategory = selectedCategory
        self.service = service
    }
    
    func load() {
        notify(.setLoading(true))
        service?.fetchTHNewsDelegate(2, selectedCategory, completion: { [self] result in
            notify(.setLoading(false))
            switch result {
            case .failure(let err):
                print(err.rawValue)
            case .success(let newsArray):
                let presentations = newsArray.map({NewsPresentation(topHeadline: $0)})
                print(presentations[0].publishedAt)
                notify(.updateApps(presentations))
            }
        })
        
    }
    
    private func notify(_ output: CategoryResultViewModelOutput){
        delegate?.handleViewModelOutput(output)
    }
    
}
