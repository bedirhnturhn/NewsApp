//
//  CategoriesBuilder.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 3.07.2022.
//

import UIKit

final class CategoriesBuilder{
    static func make(with viewModel : CategoriesViewModelProtocol) -> CategoriesViewController{
        let vc = CategoriesViewController()
        vc.viewModel = viewModel
        return vc
    }
}

