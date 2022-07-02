//
//  CategorizePage.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 6/24/21.
//

import UIKit

final class CategoriesViewController : UICollectionViewController {
    
    //MARK: -Properties
    lazy var viewModel : CategoriesViewModel = {
        let vm = CategoriesViewModel()
        vm.delegate = self
        return vm
    }()
    
    //MARK: - Init
    init() {
        super.init(collectionViewLayout: CategoriesViewController.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout{
        UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .absolute(120)))
            item.contentInsets.trailing = 6
            item.contentInsets.bottom = 6
            item.contentInsets.leading = 6
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.bottom = 6
                item.contentInsets.leading = 6
                item.contentInsets.trailing = 6
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(56)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
        }
    }
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        setup()
    }
    
    func setup(){
        self.title = "Category"
        collectionView.backgroundColor = .white
        collectionView.register(CategoryMainCell.self, forCellWithReuseIdentifier: CategoryMainCell.id)
        collectionView.register(CategoryOtherCell.self, forCellWithReuseIdentifier: CategoryOtherCell.id)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
}

extension CategoriesViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel.collectionView(collectionView, cellForItemAt: indexPath)
    }
}

extension CategoriesViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.collectionView(collectionView, didSelectItemAt: indexPath)
    }
}

//MARK: ViewModel Delegate
extension CategoriesViewController : CategoriesViewModelDelegate {
    func handleViewModelOutput(_ output: CategoriesViewModelOutput) {
        switch output {
        case .showNotification(let result, let notificationText):
            if(result){
                customNotification(_title: "Success!", _message: notificationText)
            }else{
                customNotification(_title: "Error!", _message: notificationText)
            }
        case .updateCollectionView:
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func navigate(to route: CategoriesRoute) {
        switch route {
        case .categorieResult(let selectedCategorie):
            let vc = CategoryResult(categoryName: selectedCategorie.rawValue)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
