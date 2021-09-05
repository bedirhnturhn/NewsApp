//
//  PageIndicator.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 8/5/21.
//

import UIKit


class pageIndicator : UICollectionViewCell {
    
    public let scrollIndicator : UIPageControl =  {
        let indicator = UIPageControl()
        indicator.currentPage = 0
        indicator.numberOfPages = 10
        indicator.currentPageIndicatorTintColor = .gray
        indicator.pageIndicatorTintColor = .lightGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        addSubview(scrollIndicator)
        scrollIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        scrollIndicator.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        scrollIndicator.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        scrollIndicator.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }


}
