//
//  HomePage.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 14.11.2021.
//

import UIKit

import SDWebImage
import SnapKit

final class HomeCollectionViewCell : UICollectionViewCell {
    public static let cellId = "cellid"
    
    let imageView : UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = .white
        imageV.image = UIImage(named: "slider")
        imageV.layer.cornerRadius = 5.0
        imageV.clipsToBounds = true
        return imageV
    }()
    
    var headerText : UITextView = {
        let textView =  UITextView()
        textView.isEditable = false
        textView.textColor = .black
        textView.textAlignment = .center
        return textView
    }()
    
    let pageControl : UIPageControl = {
        let page = UIPageControl()
        page.currentPage = 1
        page.numberOfPages = 5
        page.backgroundColor = .black
        return page
    }()
    
    let blackView : UIView = {
        let blackview = UIView()
        blackview.backgroundColor = .systemGray3
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
        
        headerText.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.right.equalToSuperview().offset(-6)
            make.left.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.right.equalToSuperview().offset(-6)
            make.left.equalToSuperview().offset(6)
            make.bottom.equalTo(headerText.snp.top).offset(-6)
        }
        
        blackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
