//
//  CategorizePage.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 6/24/21.
//

import UIKit

class CategorizePage : UICollectionViewController {
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryMainCell", for: indexPath) as! CategoryMainCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryOtherCell", for: indexPath) as! CategoryOtherCell
            return cell
        }
        
    }
    
    
    
}

class CategoryMainCell: UICollectionViewCell {
    
    var imageView : UIImageView = {
        let imageV = UIImageView()
        //imageV.clipsToBounds = true
        //imageV.layer.cornerRadius = 5.0
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.backgroundColor = .orange
        return imageV
    }()
    
    var genreText : UILabel = {
        let text = UILabel()
        text.backgroundColor = .orange
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    var textContent : UILabel = {
        let text = UILabel()
        text.textColor = .systemGray
        text.textAlignment = .center
        text.backgroundColor = .orange
        text.text = "COVID"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(imageView)
        addSubview(textContent)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]-[v1(20)]|" , options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : imageView , "v1" : textContent]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[v0]-6-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[v0]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : textContent]))
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CategoryOtherCell : UICollectionViewCell {
    var textContent : UILabel = {
        let text = UILabel()
        text.textColor = .systemGray
        text.textAlignment = .natural
        text.backgroundColor = .red
        text.text = "Other Most Popular Genre"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    var otherPageIcon : UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.backgroundColor = .red
        text.text = ">"
        return text
    }()
    
    var genreIcon : UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = .red
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(otherPageIcon)
        addSubview(genreIcon)
        addSubview(textContent)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v1(50)]-6-[v2]-6-[v0(20)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : otherPageIcon, "v1" : genreIcon, "v2" : textContent]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : otherPageIcon]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(50)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : genreIcon]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v0]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : textContent]))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
