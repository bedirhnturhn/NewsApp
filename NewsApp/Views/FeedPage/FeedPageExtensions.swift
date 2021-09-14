//
//  FeedPageExtensions.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 8/13/21.
//

import UIKit

extension FeedPage {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        switch section {
        case 0: return topHeadlines.count
        case 1: return 1
        case 2: return otherNEws.count
        default: return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! sliderCell
            let item = topHeadlines[indexPath.row]
            cell.headerText.text = item.title
            cell.backgroundColor = .white
            if let urlImage = URL(string: item.urlToImage ?? "https://ibb.co/KydcgZ8") {
                cell.imageView.sd_setImage(with: urlImage) { image, error, CType, urll in
                    
                }
            } else {
                cell.imageView.image = UIImage(named: "slider")
            }
            return cell
        } else if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "indicatorCell", for: indexPath) as! pageIndicator
            cell.scrollIndicator.numberOfPages = topHeadlines.count
            cell.scrollIndicator.currentPage = counter
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherCell", for: indexPath) as! otherCell
            let item = otherNEws[indexPath.row]
            cell.headerText.text = item.title
            if let urlImage = URL(string: item.urlToImage ?? "https://ibb.co/KydcgZ8") {
                cell.imageView.sd_setImage(with: urlImage, completed: nil)
            } else {
                cell.imageView.image = UIImage(named: "slider")
            }
            cell.backgroundColor = .white
            return cell
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = NewsContentPage(newsObject: topHeadlines[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 1 {
            print("naber")
        } else {
            let vc = NewsContentPage(newsObject: otherNEws[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}


