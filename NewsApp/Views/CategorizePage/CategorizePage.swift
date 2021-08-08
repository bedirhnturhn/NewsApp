//
//  CategorizePage.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 6/24/21.
//

import UIKit

class CategorizePage : UICollectionViewController {
    
    // Arrays
    
    let imageName  = ["content1","content2" ,"content3" ,"content4"]
    let cellName = ["Covid-19", "Bitcoin", "Technology", "Science"]
    
    init() {
        super.init(collectionViewLayout: CategorizePage.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout{
        UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .absolute(120)))
            item.contentInsets.trailing = 6
            item.contentInsets.bottom = 6
            item.contentInsets.leading = 6
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.bottom = 6
                item.contentInsets.leading = 6
                item.contentInsets.trailing = 6
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(56)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Category"
        collectionView.backgroundColor = .white
        collectionView.register(CategoryMainCell.self, forCellWithReuseIdentifier: "categoryMainCell")
        collectionView.register(CategoryOtherCell.self, forCellWithReuseIdentifier: "categoryOtherCell")
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
}

extension CategorizePage {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryMainCell", for: indexPath) as! CategoryMainCell
            cell.textContent.text = cellName[indexPath.row]
            cell.imageView.image = UIImage(named: imageName[indexPath.row])
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryOtherCell", for: indexPath) as! CategoryOtherCell
            return cell
        }
        
    }
}


