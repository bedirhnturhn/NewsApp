//
//  Displayable.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 7/14/21.
//

import Foundation


protocol  Displayable {
    var titleLabelText : String { get }
    var desciptionText : String { get }
    var imageUrl : String { get }
    var dateText : String { get }
    var sourceText : String { get }
    
}
