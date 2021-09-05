//
//  CategoryOtherCell.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 8/5/21.
//

import UIKit

class CategoryOtherCell : UICollectionViewCell {
    var textContent : UILabel = {
        let text = UILabel()
        text.textColor = .systemGray
        text.textAlignment = .natural
        //text.backgroundColor = .red
        text.text = "Other Most Popular Genre"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    var otherPageIcon : UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        //text.backgroundColor = .red
        text.text = ">"
        return text
    }()
    
    var genreIcon : UIImageView = {
        let imageV = UIImageView()
        //imageV.backgroundColor = .red
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .blue
        setupConstraints()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
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
