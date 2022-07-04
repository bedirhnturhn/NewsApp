//
//  HomeBuilder.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 3.07.2022.
//

import UIKit

final class HomeBuilder {
    static func make(with viewModel : HomeViewModelProtocol) -> HomeViewController{
        let vc = HomeViewController()
        vc.viewModel = viewModel
        return vc
    }
}
