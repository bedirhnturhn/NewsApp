//
//  ViewController.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 4/23/21.
//

import UIKit

class TabBarControl: UITabBarController {
    let layout = UICollectionViewFlowLayout()
    
    
    let customCollectionView = FeedPage(collectionViewLayout: UICollectionViewFlowLayout())
    
    let vc1 = UINavigationController(rootViewController: FeedPage(collectionViewLayout: UICollectionViewFlowLayout()))
    
    let vc2 = UINavigationController(rootViewController: CategorizePage())
    
    
    let vc3 = UINavigationController(rootViewController: UserPage())
    
    let vc5 = UINavigationController(rootViewController: MainPage())
    
    let vc4 = UINavigationController(rootViewController: swipePage())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //view.backgroundColor = .blue
        view.backgroundColor = .white
        self.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: false)
        //self.modalPresentationStyle = .fullScreen
        self.selectedIndex = 4
        vc1.title = "News"
        vc2.title = "Category"
        vc3.title = "Profile"
        vc4.title = "Deneme"
        vc5.title = "Main Page"
        setImage()
        
    }
    
    
    func setImage() {
        
        
        
        guard let items = self.tabBar.items else {
            return
        }
        let images = ["news", "categorize", "profile2", "news", "main"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(named: images[x])
            items[x].badgeValue = "A"
        }
        
    }
    
}





