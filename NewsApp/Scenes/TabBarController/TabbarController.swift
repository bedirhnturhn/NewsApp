//
//  TabbarController\.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 6/19/21.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    
    let viewModel1 = HomeViewModel(networkService: app.service)
    let viewModel2 = CategoriesViewModel()
    let viewModel3 = SearchViewModel(app.service)
    
    lazy var vc1 = UINavigationController(rootViewController: HomeBuilder.make(with: viewModel1))
    lazy var vc2 = UINavigationController(rootViewController: CategoriesBuilder.make(with: viewModel2))
    lazy var vc3 = UINavigationController(rootViewController: searchPageBuilder.make(with: viewModel3))
   
    override func viewDidLoad() {
        self.setViewControllers([vc1,vc2,vc3], animated: false)
        vc1.title = "FEED"
        vc2.title = "CATEGORIES"
        vc3.title = "SEARCH"
        setImage()
        self.selectedIndex = 0
        
        // White non-transucent navigatio bar, supports dark appearance
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }

        
    }
    
    func setImage() {
        guard let items = self.tabBar.items else {
            return
        }
        let image = ["news","categories","search"]
        
        
        for x in 0..<items.count {
            items[x].image = UIImage(named: image[x])
            items[x].badgeValue = "A"
        }
    }
}

