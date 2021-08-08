//
//  SliderCell.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 8/5/21.
//

import UIKit


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
    
    var headerText : UITextView = {
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
