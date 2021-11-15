//
//  HomePage.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 14.11.2021.
//

import Foundation
import UIKit
import Alamofire
import SDWebImage

protocol HeaderDelegate {
    func headerTapped(sender: UICollectionReusableView, newsdetail: News)
}


class HomePage : UICollectionViewController, UICollectionViewDelegateFlowLayout, HeaderDelegate {
    
    
    func headerTapped(sender: UICollectionReusableView, newsdetail: News) {
        let vc = NewsContentPage(newsObject: newsdetail)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    fileprivate let cellId = "cellid"
    fileprivate let headerId = "headerId"
    let padding : CGFloat = 16
    var otherNEws : [News] = []
    
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
        collectionView.register(HomeNewsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        collectionView.register(HomePageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        fetchHomeNews()
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return otherNEws.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeNewsCell
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
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
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


class HomeNewsCell : UICollectionViewCell {
    let imageView : UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = .white
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.image = UIImage(named: "slider")
        imageV.layer.cornerRadius = 5.0
        imageV.clipsToBounds = true
        return imageV
    }()
    
    var headerText : UITextView = {
        let textView =  UITextView()
        textView.isEditable = false
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "other DENEMEMEMEME"
        
        textView.textAlignment = .center
        return textView
    }()
    
    let pageControl : UIPageControl = {
        let page = UIPageControl()
        page.translatesAutoresizingMaskIntoConstraints = false
        page.currentPage = 1
        page.numberOfPages = 5
        page.backgroundColor = .black
        return page
    }()
    
    let blackView : UIView = {
        let blackview = UIView()
        blackview.backgroundColor = .systemGray3
        blackview.translatesAutoresizingMaskIntoConstraints = false
        return blackview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    func setupLayouts() {
        addSubview(imageView)
        addSubview(headerText)
        addSubview(blackView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0]-4-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": imageView ]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]-5-[v1(50)]-[v2(1)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": imageView , "v1" : headerText, "v2" : blackView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0]-4-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : headerText]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : blackView]))
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
