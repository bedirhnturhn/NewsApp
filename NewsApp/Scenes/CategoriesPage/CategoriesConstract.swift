//
//  CategorizeConstract.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 28.06.2022.
//

import Foundation
import UIKit

protocol CategoriesViewModelProtocol : AnyObject{
    var delegate : CategoriesViewModelDelegate? { get set }
    func load()
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

protocol CategoriesViewModelDelegate : AnyObject {
    func handleViewModelOutput(_ output: CategoriesViewModelOutput)
    func navigate(to route: CategoriesRoute)
}

enum CategoriesViewModelOutput{
    case showNotification(result: Bool,notificationText : String)
    case updateCollectionView
}

enum CategoriesRoute {
    case categorieResult(_ selectedCategory : Categories)
}
