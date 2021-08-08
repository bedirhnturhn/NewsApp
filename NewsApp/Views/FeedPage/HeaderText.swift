//
//  HeaderText.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 8/5/21.
//

import UIKit

class HeaderText : UICollectionReusableView {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = "Most Popular News For You:"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        label.textColor = .systemGray
        addSubview(label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


