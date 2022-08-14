//
//  SearchContracts.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 14.08.2022.
//

import Foundation

protocol SearchViewModelProtocol{
    var delegate : SearchViewModelDelegate? {get set}
    var sources : [Sources] { get set }
    var categories : [String] {get set}
    func load()
}

enum SearchViewModelOutput : Equatable{
    case setLoading(Bool)
    case setTitle(String)
    case showNotification(result : Bool,notificationText : String)
    case updateSourcesList
}

enum SearchRoute{
    case showSourceDetails(Sources)
}

protocol SearchViewModelDelegate : AnyObject{
    func handleViewModelOutput(_ output: SearchViewModelOutput)
    func navigate(to route: SearchRoute)
}
