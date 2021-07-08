//
//  ViewController.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 6/1/21.
//

import UIKit

class FeedPage : UICollectionViewController {
    
    
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
        self.title = "FEED"
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
        return header
    }
    
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! sliderCell
            cell.backgroundColor = .white
            cell.imageView.image = UIImage(named: "slider")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherCell", for: indexPath) as! otherCell
            cell.imageView.image = UIImage(named: "allNews")
            cell.backgroundColor = .white
            return cell
        }
    }
}

class sliderCell : UICollectionViewCell {
    let imageView : UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = .brown
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.image = UIImage(named: "slider")
        imageV.layer.cornerRadius = 5.0
        imageV.clipsToBounds = true
        return imageV
    }()
    
    let headerText : UITextView = {
        let textView =  UITextView()
        textView.isEditable = false
        textView.textColor = .red
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "DENEMEMEMEME"
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
        blackview.backgroundColor = .white
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
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0]-4-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": imageView ]))
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]-5-[v1(30)]-[v2(1)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": imageView , "v1" : headerText, "v2" : blackView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]-5-[v1(30)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": imageView , "v1" : headerText]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0]-4-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : headerText]))
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : blackView]))
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class otherCell : UICollectionViewCell {
    let imageView : UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = .brown
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.image = UIImage(named: "slider")
        imageV.layer.cornerRadius = 5.0
        imageV.clipsToBounds = true
        return imageV
    }()
    
    let headerText : UITextView = {
        let textView =  UITextView()
        textView.isEditable = false
        textView.textColor = .red
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
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]-5-[v1(30)]-[v2(1)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": imageView , "v1" : headerText, "v2" : blackView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[v0]-4-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : headerText]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : blackView]))
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HeaderText : UICollectionReusableView {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = "Most Popular News For You:"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        label.textColor = .systemGray
        addSubview(label)
        
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
