//
//  ViewController.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 6/1/21.
//

import UIKit
import Alamofire
import SDWebImage

class FeedPage : UICollectionViewController {
    // VAriables
    
    var topHeadlines : [News] = []
    var otherNEws : [News] = []
    var timer = Timer()
    var counter = 0
    
    init() {
        super.init(collectionViewLayout: FeedPage.createLayout())
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout{
        UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 2
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(225)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                return section
            } else if sectionNumber == 1 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 2
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            } else {
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)))
            item.contentInsets.bottom = 2
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [ . init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: "naberanlamadım", alignment: .topLeading)]
            return section
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public let scrollIndicator : UIPageControl =  {
        let indicator = UIPageControl()
        indicator.currentPage = 0
        indicator.numberOfPages = 10
        indicator.currentPageIndicatorTintColor = .gray
        indicator.pageIndicatorTintColor = .lightGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(sliderCell.self, forCellWithReuseIdentifier: "sliderCell")
        collectionView.register(otherCell.self, forCellWithReuseIdentifier: "otherCell")
        collectionView.register(HeaderText.self, forSupplementaryViewOfKind: "naberanlamadım", withReuseIdentifier: "headerId")
        collectionView.register(pageIndicator.self, forCellWithReuseIdentifier: "indicatorCell")
        self.title = "FEED"
        
        fetchData()
        fetchOtherData()
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeNews), userInfo: nil, repeats: true)
        }
        
        //DENEME
    }
    
    @objc func changeNews(){
        if counter < topHeadlines.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            collectionView.reloadSections(IndexSet(integer: 1))
            counter += 1
            print(counter)
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            counter = 1
            collectionView.reloadSections(IndexSet(integer: 1))
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
        return header
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
}

