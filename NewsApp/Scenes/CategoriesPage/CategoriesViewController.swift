//
//  CategorizePage.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 6/24/21.
//

import UIKit

final class CategoriesViewController : UIViewController {
    
    //MARK: -Properties
    var viewModel : CategoriesViewModelProtocol! {
        didSet{
            viewModel.delegate = self
        }
    }
    var mainCategoriesArray = [CategoriesPresentations]()
    var otherCategoriesArray = [CategoriesPresentations]()
    
    //MARK: -Views
    lazy var collectionView : UICollectionView = {
        let cv = UICollectionView(frame: view.bounds,
                                  collectionViewLayout: createLayout())
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    func createLayout() -> UICollectionViewCompositionalLayout{
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
        layout()
    }
    
    private func setup(){
        viewModel.load()
        collectionView.backgroundColor = .white
        collectionView.register(CategoryMainCell.self, forCellWithReuseIdentifier: CategoryMainCell.id)
        collectionView.register(CategoryOtherCell.self, forCellWithReuseIdentifier: CategoryOtherCell.id)
    }
    
    private func layout(){
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension CategoriesViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return mainCategoriesArray.count
        }else {
            return otherCategoriesArray.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryMainCell.id, for: indexPath) as! CategoryMainCell
            cell.textContent.text = mainCategoriesArray[indexPath.row].categorieName.rawValue.uppercased()
            cell.imageView.image = UIImage(named: mainCategoriesArray[indexPath.row].categorieImageName)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryOtherCell.id, for: indexPath) as! CategoryOtherCell
            cell.textContent.text = otherCategoriesArray[indexPath.row].categorieName.rawValue.uppercased()
            cell.genreIcon.image = UIImage(named: otherCategoriesArray[indexPath.row].categorieImageName)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.categorieDidSelect(selected: indexPath)
    }
}

//MARK: ViewModel Delegate
extension CategoriesViewController : CategoriesViewModelDelegate {
    func handleViewModelOutput(_ output: CategoriesViewModelOutput) {
        switch output {
        case .setTitle(let title):
            self.title = title
        case .showNotification(let result, let notificationText):
            if(result){
                customNotification(_title: "Success!", _message: notificationText)
            }else{
                customNotification(_title: "Error!", _message: notificationText)
            }
        case .setCategories(let mainC,let otherC):
            DispatchQueue.main.async {
                self.mainCategoriesArray = mainC
                self.otherCategoriesArray = otherC
                self.collectionView.reloadData()
            }
        }
    }
    
    func navigate(to route: CategoriesRoute) {
        switch route {
        case .categorieResult(let selectedCategorie):
            let viewModel = CategoryResultViewModel(selectedCategorie)
            let vc = CategoryResultBuilder.make(with: viewModel)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
