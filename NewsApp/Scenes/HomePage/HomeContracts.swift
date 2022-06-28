//
//  HomeContracts.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 27.06.2022.
//

import Foundation

protocol HomeViewModelProtocol {
    
}

enum HomeModelOutput : Equatable{
    case setLoading(Bool)
    case showNotification(result: Bool,notificationText : String)
}

enum HomeRoute {
}

protocol HomeViewModelDelegate {
    
}

protocol HomeHeaderProtocol : AnyObject{
    var delegate : HomeHeaderDelegate? { get set }
    func updateUI(new news: [News])
}

protocol HomeHeaderDelegate : AnyObject{
    func showNewsDetailsInHomeSlider(_ selectedNewsIndex : Int)
}
