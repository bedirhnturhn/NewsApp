//
//  CategorySourceCell.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 8/12/21.
//

import UIKit

class CategoryResultCell: UICollectionViewCell {
    
    let imageView : UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.image = UIImage(named: "slider")
        imageV.layer.cornerRadius = 5.0
        imageV.clipsToBounds = true
        return imageV
    }()
    
    var newsText : UITextView = {
        let textView =  UITextView()
        textView.isEditable = false
        textView.textColor = .red
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TRYTRY"
        textView.textAlignment = .center
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    func setupViews(){
        addSubview(imageView)
        addSubview(newsText)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[v0]-6-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[v0]-6-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": newsText]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-6-[v0]-6-[v1(40)]-6-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": imageView, "v1": newsText]))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

