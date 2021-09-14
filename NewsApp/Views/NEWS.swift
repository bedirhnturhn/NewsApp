//
//  NEWS.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 8/19/21.
//

import UIKit

class NewsPage : UICollectionViewController {
    
    init(){
        let layout = UICollectionViewLayout()
        super.init(collectionViewLayout: layout)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
}

extension NewsPage {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}


