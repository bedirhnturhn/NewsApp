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
