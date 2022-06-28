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
    weak var sliderObject : HomePageHeader?
    
    func load() {
        fetchTopNews()
        fetchOtherNews()
    }
    
    func fetchTopNews() {
        newsServices.fetchTHNewsDelegate(5, .business) { [self] result in
            switch result {
            case .success(let fetchedNews):
                print(fetchedNews)
                topHeadlinesNEws = fetchedNews
                sliderObject?.updateUI(new: topHeadlinesNEws)
            case .failure(let error):
                delegate?.handleViewModelOutput(.showNotification(result: false, notificationText: error.rawValue))
            }
        }
    }
    
    func fetchOtherNews() {
        newsServices.fetchDelegate(10) {[self] result in
            switch(result){
            case .success(let fetchedNews):
                otherNews = fetchedNews
                delegate?.handleViewModelOutput(.updateCollectionView)
            case .failure(let error):
                delegate?.handleViewModelOutput(.showNotification(result: false, notificationText: error.rawValue))
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return otherNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.cellId, for: indexPath) as! HomeCollectionViewCell
        let item = otherNews[indexPath.row]
        cell.headerText.text = item.title
        let imageUrl = URL(string: item.urlToImage!)
        cell.imageView.sd_setImage(with: imageUrl, completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        delegate?.navigate(to: .newsDetail(otherNews[indexPath.row]))
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomePageHeader.headerId, for: indexPath) as! HomePageHeader
        header.delegate = self
        sliderObject = header
        return header
    }
}

extension HomeViewModel : HomeHeaderDelegate{
    func showNewsDetailsInHomeSlider(_ selectedNewsIndex: Int) {
        delegate?.navigate(to: .newsDetail(topHeadlinesNEws[selectedNewsIndex]))
    }
}
