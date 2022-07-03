//
//  CategorySource.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 8/9/21.
//

import UIKit
import Alamofire
import SDWebImage

class CategoryResult: UICollectionViewController {
    var news : [News] = []
    lazy var selectedCategory : String = ""
    var urlforCategory = ""
    
    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    init(categoryName : String){
        /*let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        */
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        selectedCategory = categoryName
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        title = selectedCategory.uppercased()
        collectionView.register(CategoryResultCell.self, forCellWithReuseIdentifier: "categorySourceCell")
        setupLayout()
        fetchingNews(categoryName: selectedCategory)
    }
    
    
}

extension CategoryResult{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categorySourceCell", for: indexPath) as! CategoryResultCell
        let item = news[indexPath.row]
        cell.newsText.text = item.title
        if let urlImage = URL(string: item.urlToImage ?? "https://ibb.co/KydcgZ8") {
            cell.imageView.sd_setImage(with: urlImage, completed: nil)
        } else {
            cell.imageView.image = UIImage(named: "slider")
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = NewsDetailViewController(newsObject: news[indexPath.row])
//        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CategoryResult{
    func setupLayout(){
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10
                layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                let size = CGSize(width:(collectionView!.bounds.width-30)/2, height: 200)
                layout.itemSize = size
        }
    }
}




