//
//  CollectionReusableView.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 4/24/21.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "headerCollectionView"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "header"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

class FooterCollectionReusableView: UICollectionReusableView {
    static let identifier = "footerCollectionView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
