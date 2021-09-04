//
//  MainPage.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 5/13/21.
//

import UIKit

class MainPage: UICollectionViewController {
     init() {
        
        super.init(collectionViewLayout: MainPage.createLayout())
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 2
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                return section
            } else if sectionNumber == 1  {
            
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.18)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 16
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: "categorizeHeaderId", alignment: .topLeading )
                ]
                return section
            
            }
            
            else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.bottom = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 16, bottom: 10, trailing: 16)
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: "newsHeader", alignment: .topLeading)
                ]
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
        collectionView.register(sliderCell1.self, forCellWithReuseIdentifier: "sliderCell")
        collectionView.register(HeaderUS.self, forSupplementaryViewOfKind: "categorizeHeaderId", withReuseIdentifier: "headerId")
        collectionView.register(NewsHeader.self, forSupplementaryViewOfKind: "newsHeader", withReuseIdentifier: "otherNews")
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let costumCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! sliderCell1
            
            costumCell.backgroundColor = .red
            return costumCell
            
            
            
        } else if indexPath.section == 1 {
            let costumCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! sliderCell1
            costumCell.backgroundColor = .blue
            return costumCell
        } else {
            let costumCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! sliderCell1
            costumCell.backgroundColor = .green
            return costumCell
        }
        
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1{
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
        return header
        } else {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "otherNews", for: indexPath)
        return header
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 5
        }
    }
    
}

class sliderCell1 : UICollectionViewCell{
    
    var image : UIImageView = {
        var imageV = UIImageView()
        imageV.image = UIImage(named: "newsSlider")
        imageV.contentMode = .scaleAspectFit
        return imageV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        setupLayout()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            image.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: ((self.frame.height) * 0.8) )
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class HeaderUS : UICollectionReusableView{
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = "US News:"
        label.textColor = .black
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

class NewsHeader : UICollectionReusableView{
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = "NEWS:"
        label.textColor = .black
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

