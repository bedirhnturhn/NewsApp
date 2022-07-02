//
//  CategoryMainCell.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 8/5/21.
//

import UIKit

final class CategoryMainCell: UICollectionViewCell {
    
    static let id = "categoryMainCell"
    
    var imageView : UIImageView = {
        let imageV = UIImageView()
        //imageV.clipsToBounds = true
        //imageV.layer.cornerRadius = 5.0
        imageV.translatesAutoresizingMaskIntoConstraints = false
        //imageV.backgroundColor = .orange
        imageV.contentMode = .scaleAspectFit
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
        //text.backgroundColor = .orange
        text.text = "COVID"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .red
        setupConstraints()
        /*
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 15
        self.layer.shadowColor = UIColor.black.cgColor
        */
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
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
