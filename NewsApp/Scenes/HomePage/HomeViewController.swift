//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 27.06.2022.
//

import UIKit
import Alamofire

final class HomeViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    let padding : CGFloat = 16
    var topHeadlines : [News] = []
    
    
    lazy var viewModel : HomeViewModelProtocol = {
        let vm = HomeViewModel()
        vm.delegate = self
        return vm
    }()
    
    //MARK: - Life Cycles
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        self.navigationItem.title = "HOME"
        
        //layout customization
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.cellId)
        collectionView.backgroundColor = .white
        collectionView.register(HomePageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomePageHeader.headerId)
        
        viewModel.load()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 2 * padding, height: 255)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return viewModel.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width , height: 260 )
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.collectionView(collectionView, didSelectItemAt: indexPath)
    }
}


extension HomeViewController : HomeViewModelDelegate {
    func navigate(to route: HomeRoute) {
        
    }
    
    func handleViewModelOutput(_ output: HomeModelOutput) {
        switch output {
        case .setLoading(let bool):
            print("set loading \(bool)")
        case .showNotification(let result, let notificationText):
            if(result){
                customNotification(_title: "Success!", _message: notificationText)
            }else{
                customNotification(_title: "Error!", _message: notificationText)
            }
        case .updateCollectionView:
            DispatchQueue.main.async { [self] in
                collectionView.reloadData()
            }
    }
}
}
