//
//  FeedNewsCell.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 5/9/33.
//

import UIKit

class CustomCell: UICollectionViewCell {
    override init(frame : CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "CustomCellText"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    func setupViews() {
        backgroundColor = UIColor.red
        
        addSubview(nameLabel)
        let viewsDictionary = ["label1": nameLabel]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label1]|", options: [], metrics: nil, views: viewsDictionary))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: [], metrics: nil, views: ["v0": nameLabel]))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

