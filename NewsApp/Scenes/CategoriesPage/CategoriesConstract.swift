//
//  CategorizeConstract.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 28.06.2022.
//

import Foundation
import UIKit

protocol CategoriesViewModelProtocol : AnyObject{
    var delegate : CategoriesViewModelDelegate? { get set }
    func load()
    func categorieDidSelect(selected index : IndexPath)
}

protocol CategoriesViewModelDelegate : AnyObject {
    func handleViewModelOutput(_ output: CategoriesViewModelOutput)
    func navigate(to route: CategoriesRoute)
}

enum CategoriesViewModelOutput{
    case setTitle(String)
    case showNotification(result: Bool,notificationText : String)
    case setCategories(_ mainCategories : [CategoriesPresentations], _ otherCategories : [CategoriesPresentations])
}

enum CategoriesRoute {
    case categorieResult(_ selectedCategory : THCategories)
}
