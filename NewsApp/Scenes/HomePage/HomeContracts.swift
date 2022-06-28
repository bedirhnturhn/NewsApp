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
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath,cell : HomeCollectionViewCell)
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
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
