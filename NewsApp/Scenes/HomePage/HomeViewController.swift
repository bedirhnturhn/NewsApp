//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 27.06.2022.
//

import UIKit
import SnapKit

final class HomeViewController : UIViewController{
    
    //MARK: - Properties
    let padding : CGFloat = 16
    var otherNews : [NewsPresentation] = []
    weak var headerProtocol : HomeHeaderProtocol?{
        didSet{
            headerProtocol?.delegate = self
        }
    }
    var viewModel : HomeViewModelProtocol! {
        didSet{
            viewModel.delegate = self
        }
    }
    
    //MARK: - Views
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: view.bounds,
                                  collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .red
        return cv
    }()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        view.backgroundColor = .gray
    }
    
    func setup(){
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.cellId)
        collectionView.backgroundColor = .white
        collectionView.register(HomePageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomePageHeader.headerId)
        
        viewModel.load()
    }
    
    func layout(){
        //layout customization
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return otherNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.cellId, for: indexPath) as! HomeCollectionViewCell
        let item = otherNews[indexPath.row]
        cell.headerText.text = item.title
        try? cell.imageView.sd_setImage(with: item.urlToImage?.asURL(), completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 2 * padding, height: 255)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomePageHeader.headerId, for: indexPath) as! HomePageHeader
        headerProtocol = header
        return header
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width , height: 260 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectNews(selected: indexPath)
    }
}

//MARK: - ViewModel Delegate
extension HomeViewController : HomeViewModelDelegate {
    func navigate(to route: HomeRoute) {
        switch route {
        case .newsDetail(let selectedNews):
            let viewModel = NewsDetailViewModel(selectedNews)
            let vc = NewsDetailBuilder.make(with: viewModel)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func handleViewModelOutput(_ output: HomeViewModelOutput) {
        switch output {
        case .setLoading(let bool):
            print("set loading \(bool)")
        case .showNotification(let result, let notificationText):
            if(result){
                customNotification(_title: "Success!", _message: notificationText)
            }else{
                customNotification(_title: "Error!", _message: notificationText)
            }
        case .updateCollectionView(let newNewsArray):
            DispatchQueue.main.async { [self] in
                otherNews = newNewsArray
                collectionView.reloadData()
            }
        case .setTitle(let title):
            self.title = title
        case .updateHeader(let newsArray):
            print(newsArray[3].urlToImage)
            headerProtocol?.updateUI(new: newsArray)
            break
        }
    }
}


//MARK: - Header Delegate
extension HomeViewController : HomeHeaderDelegate{
    func showNewsDetailsInHomeSlider(_ selectedNewsIndex: Int) {
        viewModel.didSelectNewsFromHeader(selectedIndex: selectedNewsIndex)
    }
}
