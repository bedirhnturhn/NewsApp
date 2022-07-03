//
//  NewsDetailConstracts.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 3.07.2022.
//

import Foundation

protocol NewsDetailViewModelProtocol {
    var delegate : NewsDetailViewModelDelegate? { get set }
    func load()
    func saveToDB()
    func deleteFromDB()
    func showNewsDetailsInBrowser()
}

enum NewsDetailViewModelOutput : Equatable{
    case setLoading(Bool)
    case setTitle(String)
    case showNotification(result : Bool,notificationText : String)
    case showNewsDetail(NewsPresentation)
}

enum NewsDetailRoute{
    case showNewsDetailsInSafari(_ url : URL)
}

protocol NewsDetailViewModelDelegate : AnyObject {
    func handleViewModelOutput(_ output: NewsDetailViewModelOutput)
    func navigate(to route: NewsDetailRoute)
}
