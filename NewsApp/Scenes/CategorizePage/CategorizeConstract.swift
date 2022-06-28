//
//  CategorizeConstract.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 28.06.2022.
//

import Foundation

protocol CategorizeViewModelProtocol{
    var delegate : CategorizeViewModelDelegate? { get set }
}

protocol CategorizeViewModelDelegate : AnyObject {
    func handleViewModelOutput(_ output: CategorizeViewModelOutput)
    func navigate(to route: CategorizeRoute)
}

enum CategorizeViewModelOutput{
    case setLoading(Bool)
    case showNotification(result: Bool,notificationText : String)
    case updateCollectionView
}

enum CategorizeRoute {
    case newsDetail(_ selectedNews : News)
}
