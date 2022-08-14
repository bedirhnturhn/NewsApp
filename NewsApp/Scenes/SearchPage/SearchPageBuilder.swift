//
//  SearchPageBuilder.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 14.08.2022.
//

import Foundation

final class searchPageBuilder{
    static func make(with viewModel : SearchViewModelProtocol) -> SearchViewController {
        let vc = SearchViewController()
        vc.viewModel = viewModel
        return vc
    }
}
