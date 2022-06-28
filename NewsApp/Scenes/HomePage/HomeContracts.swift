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
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    
}

enum HomeModelOutput{
    case setLoading(Bool)
    case showNotification(result: Bool,notificationText : String)
    case updateCollectionView
}

enum HomeRoute {
    case newsDetail(_ selectedNews : News)
}

protocol HomeViewModelDelegate {
    func handleViewModelOutput(_ output: HomeModelOutput)
    func navigate(to route: HomeRoute)
}

protocol HomeHeaderProtocol : AnyObject{
    var delegate : HomeHeaderDelegate? { get set }
    func updateUI(new news: [News])
}

protocol HomeHeaderDelegate : AnyObject{
    func showNewsDetailsInHomeSlider(_ selectedNewsIndex : Int)
}
