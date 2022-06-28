//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 27.06.2022.
//

import UIKit
import Alamofire

final class HomeViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    weak var headerDelegate : HomePageHeader?
    let padding : CGFloat = 16
    var otherNEws : [News] = []
    var topHeadlines : [News] = []
    weak var headerObject : HomePageHeader?
    
    //MARK: - Life Cycles
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "HOME"
        
        //layout customization
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.cellId)
        collectionView.backgroundColor = .white
        collectionView.register(HomePageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomePageHeader.headerId)
        fetchHomeNews()
        fetchData()
    }
    
    
    func fetchHomeNews() {
        AF.request("https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=565b53ef125c494985797acd7d1cfdf4")
            .validate()
            .responseDecodable(of: SourceStatus.self) { (response) in
                guard let stored = response.value?.articles else { return }
                self.otherNEws = stored
                self.collectionView.reloadData()
        }
    }
    
    func fetchData()   {
        AF.request("https://newsapi.org/v2/everything?q=apple&sortBy=popularity&apiKey=565b53ef125c494985797acd7d1cfdf4")
            .validate()
            .responseDecodable(of: SourceStatus.self) { (response) in
                guard let stored = response.value?.articles else { return }
                self.topHeadlines = stored
                self.headerObject?.updateUI(new: self.topHeadlines)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return otherNEws.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.cellId, for: indexPath) as! HomeCollectionViewCell
        let item = otherNEws[indexPath.row]
        cell.headerText.text = item.title
        let imageUrl = URL(string: item.urlToImage!)
        cell.imageView.sd_setImage(with: imageUrl, completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 2 * padding, height: 255)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomePageHeader.headerId, for: indexPath) as! HomePageHeader
        header.delegate = self
        headerObject = header
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width , height: 260 )
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = NewsContentPage(newsObject: otherNEws[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController : HomeHeaderDelegate{
    func showNewsDetailsInHomeSlider(_ selectedNewsIndex: Int) {
        let vc = NewsContentPage(newsObject: topHeadlines[selectedNewsIndex])
        navigationController?.pushViewController(vc, animated: true)
    }
}
