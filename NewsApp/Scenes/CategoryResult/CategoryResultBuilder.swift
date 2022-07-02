//
//  CategoryResultBuilder.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 2.07.2022.
//

import UIKit

final class CategoryResultBuilder {
    static func make(with viewModel : CategoryResultViewModelProtocol) -> CategoryResultViewController {
        let viewController = CategoryResultViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
