//
//  TabbarController\.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 6/19/21.
//

import UIKit

class TabBarController: UITabBarController {
    
    let vc1 = UINavigationController(rootViewController: FeedPage())
    let vc2 = UINavigationController(rootViewController: CategorizePage())
    let vc3 = UINavigationController(rootViewController: SearchPage())
   
    override func viewDidLoad() {
        self.setViewControllers([vc1,vc2,vc3], animated: false)
        vc1.title = "FEED"
        vc2.title = "CATEGORY"
        vc3.title = "SEARCH"
        setImage()
        self.selectedIndex = 1
    }
    
    func setImage() {
        guard let items = self.tabBar.items else {
            return
        }
        let image = ["news","categorize","search"]
        
        
        for x in 0..<items.count {
            items[x].image = UIImage(named: image[x])
            items[x].badgeValue = "A"
        }
            
        
    }
}

