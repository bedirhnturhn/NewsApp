//
//  Categories.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 2.07.2022.
//

import Foundation

struct Categorie{
    let categorieName : Categories
    let categorieImageName : String
}

enum Categories : String{
    case general
    case business
    case technology
    case science
    case entertainment
    case health
    case sports
}
