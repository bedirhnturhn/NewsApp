//
//  CategoryResultConstract.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 2.07.2022.
//

import Foundation
import UIKit

protocol CategoryResultViewModelProtocol : AnyObject {
    var delegate : CategoryResultViewModelDelegate? { get set }
    func load()
    func didSelectNews(selected index : Int)
}

enum CategoryResultViewModelOutput {
    case updateTitle(String)
    case setLoading(Bool)
    case updateApps([NewsPresentation])
    case showNotification(status : Bool,text : String)
}

enum CategoryResultViewRoute{
    case newsDetail(THArticleModel)
}

protocol CategoryResultViewModelDelegate : AnyObject {
    func handleViewModelOutput(_ output: CategoryResultViewModelOutput)
    func navigate(to route: CategoryResultViewRoute)
}
