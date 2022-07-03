//
//  CategorizeViewModel.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 28.06.2022.
//

import Foundation
import UIKit

final class CategoriesViewModel : CategoriesViewModelProtocol{
    //MARK: - Properties
    weak var delegate: CategoriesViewModelDelegate?
    let mainCategories : Array<CategoriesPresentations> =
    [CategoriesPresentations(categorieName: .general, categorieImageName: "content1"),CategoriesPresentations(categorieName: .business, categorieImageName: "content2"),CategoriesPresentations(categorieName: .technology, categorieImageName: "content3"), CategoriesPresentations(categorieName: .science, categorieImageName: "content4")]
    let otherCategories : Array<CategoriesPresentations> =
    [CategoriesPresentations(categorieName: .entertainment, categorieImageName: "content5"),CategoriesPresentations(categorieName: .health, categorieImageName: "content6"), CategoriesPresentations(categorieName: .sports, categorieImageName: "content7")]
    
    func load() {
        notify(.setTitle("Categories"))
        notify(.setCategories(mainCategories, otherCategories))
    }
    
    func categorieDidSelect(selected index: IndexPath) {
        if index.section == 0 {
            delegate?.navigate(to: .categorieResult(mainCategories[index.row].categorieName))
        }else {
            delegate?.navigate(to: .categorieResult(otherCategories[index.row].categorieName))
        }
    }
    
    private func notify(_ output: CategoriesViewModelOutput){
        delegate?.handleViewModelOutput(output)
    }
    
}
