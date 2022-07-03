//
//  NewsDetailBuilder.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 3.07.2022.
//

import Foundation

final class NewsDetailBuilder{
    static func make(with viewModel: NewsDetailViewModelProtocol) -> NewsDetailViewController{
        let vc = NewsDetailViewController()
        vc.viewModel = viewModel
        return vc
    }
}
