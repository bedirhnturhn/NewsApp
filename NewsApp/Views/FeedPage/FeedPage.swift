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
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
        return header
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
}

extension FeedPage {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return topHeadlines.count
        }else if section == 1 {
            return 1
        }
        else {
            return otherNEws.count
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! sliderCell
            let item = topHeadlines[indexPath.row]
            cell.headerText.text = item.title
            cell.backgroundColor = .white
            if let urlImage = URL(string: item.urlToImage) {
                cell.imageView.sd_setImage(with: urlImage) { image, error, CType, urll in
                    
                }
            } else {
                cell.imageView.image = UIImage(named: "slider")
            }
            return cell
        } else if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "indicatorCell", for: indexPath) as! pageIndicator
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherCell", for: indexPath) as! otherCell
            let item = otherNEws[indexPath.row]
            cell.headerText.text = item.title
            if let urlImage = URL(string: item.urlToImage) {
                cell.imageView.sd_setImage(with: urlImage, completed: nil)
            } else {
                cell.imageView.image = UIImage(named: "slider")
            }
            cell.backgroundColor = .white
            return cell
            
        }
    }
}


extension FeedPage{
    func fetchData()   {
        AF.request("https://newsapi.org/v2/everything?q=apple&from=2021-08-04&to=2021-08-04&sortBy=popularity&apiKey=565b53ef125c494985797acd7d1cfdf4")
            .validate()
            .responseDecodable(of: SourceStatus.self) { (response) in
                //print(response.value)
                guard let stored = response.value?.articles else { return }
                print(stored[0].title)
                print("deneme")
                self.topHeadlines = stored
                self.collectionView.reloadData()
        }
    }
    
    func fetchOtherData() {
        AF.request("https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=565b53ef125c494985797acd7d1cfdf4")
            .validate()
            .responseDecodable(of: SourceStatus.self) { (response) in
                guard let stored = response.value?.articles else { return }
                print("oluyor mukeee")
                self.otherNEws = stored
                self.collectionView.reloadData()
            }
    }
}
