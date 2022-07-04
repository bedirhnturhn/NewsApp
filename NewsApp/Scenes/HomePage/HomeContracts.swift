//
//  HomeContracts.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 27.06.2022.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol {
    var delegate : HomeViewModelDelegate? {get set}
    func load()
    func fetchTopNews()
    func fetchOtherNews()
    func didSelectNews(selected index : IndexPath)
    func didSelectNewsFromHeader(selectedIndex : Int)
}

enum HomeViewModelOutput{
    case setTitle(String)
    case setLoading(Bool)
    case showNotification(result: Bool,notificationText : String)
    case updateCollectionView(_ newsPresentationArray : [NewsPresentation])
    case updateHeader(_ newsPresentationArray : [NewsPresentation])
}

enum HomeRoute {
    case newsDetail(_ selectedNews : THArticleModel)
}

protocol HomeViewModelDelegate {
    func handleViewModelOutput(_ output: HomeViewModelOutput)
    func navigate(to route: HomeRoute)
}

protocol HomeHeaderProtocol : AnyObject{
    var delegate : HomeHeaderDelegate? { get set }
    func updateUI(new news: [NewsPresentation])
}

protocol HomeHeaderDelegate : AnyObject{
    func showNewsDetailsInHomeSlider(_ selectedNewsIndex : Int)
}
