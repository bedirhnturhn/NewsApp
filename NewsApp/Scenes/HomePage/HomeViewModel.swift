//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 27.06.2022.
//

import Foundation
import UIKit
import Alamofire

final class HomeViewModel : HomeViewModelProtocol {
    var delegate : HomeViewModelDelegate?
    var otherNews = [News]()
    var topHeadlinesNEws = [News]()
    let newsServices = NewsService()
    
    func load() {
        
    }
    
    func fetchTopNews() {
        
    }
    
    func fetchOtherNews() {
        newsServices.fetchDelegate(5) { result in
            switch(result){
            case .success(let fetchedNews):
                print(fetchedNews)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, cell: HomeCollectionViewCell) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomePageHeader.headerId, for: indexPath) as! HomePageHeader
        header.delegate = self
        return header
    }
}

extension HomeViewModel : HomeHeaderDelegate{
    func showNewsDetailsInHomeSlider(_ selectedNewsIndex: Int) {
        
    }
}
