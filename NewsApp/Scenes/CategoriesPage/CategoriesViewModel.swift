//
//  CategorizeViewModel.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 28.06.2022.
//

import Foundation
import UIKit

final class CategoriesViewModel : CategoriesViewModelProtocol{
    //MARK: - Properties
    weak var delegate: CategoriesViewModelDelegate?
    let mainCategories : Array<Categorie> =
    [Categorie(categorieName: .general, categorieImageName: "content1"),Categorie(categorieName: .business, categorieImageName: "content2"),Categorie(categorieName: .technology, categorieImageName: "content3"), Categorie(categorieName: .science, categorieImageName: "content4")]
    let otherCategories : Array<Categorie> =
    [Categorie(categorieName: .entertainment, categorieImageName: "content5"),Categorie(categorieName: .health, categorieImageName: "content6"), Categorie(categorieName: .sports, categorieImageName: "content7")]
    
    func load() {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryMainCell.id, for: indexPath) as! CategoryMainCell
            cell.textContent.text = mainCategories[indexPath.row].categorieName.rawValue.uppercased()
            cell.imageView.image = UIImage(named: mainCategories[indexPath.row].categorieImageName)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryOtherCell.id, for: indexPath) as! CategoryOtherCell
            cell.textContent.text = otherCategories[indexPath.row].categorieName.rawValue.uppercased()
            cell.genreIcon.image = UIImage(named: otherCategories[indexPath.row].categorieImageName)
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            delegate?.navigate(to: .categorieResult(mainCategories[indexPath.row].categorieName))
        }else {
            delegate?.navigate(to: .categorieResult(otherCategories[indexPath.row].categorieName))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return mainCategories.count
        }else {
            return otherCategories.count
        }
    }
    
}
