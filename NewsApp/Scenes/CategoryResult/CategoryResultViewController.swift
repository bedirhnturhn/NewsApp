//
//  CategoryResultViewController.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 2.07.2022.
//

import UIKit

final class CategoryResultViewController : UIViewController {
    //MARK: -Properties
    var newsPresentationArray = [NewsPresentation]()
    var viewModel : CategoryResultViewModelProtocol!{
        didSet{
            viewModel.delegate = self
        }
    }
    
    //MARK: -Views
    lazy var flowLayout : UICollectionViewFlowLayout = {
        let flw = UICollectionViewFlowLayout()
        flw.sectionInset = UIEdgeInsets(top: 16, left: 12, bottom: 0, right: 12)
        return flw
    }()
    
    lazy var collectionView : UICollectionView = {
        let cv = UICollectionView(frame: view.bounds,
                                  collectionViewLayout: flowLayout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.load()
    }
    
    private func setup(){
        collectionView.register(CategoryResultCell.self, forCellWithReuseIdentifier: CategoryResultCell.id)
        setupCellLayout()
        layout()
    }
    
    private func setupCellLayout() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let size = CGSize(width:(collectionView.bounds.width-30)/2, height: 200)
        layout.itemSize = size
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

extension CategoryResultViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let news = newsPresentationArray[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryResultCell.id, for: indexPath) as! CategoryResultCell
        cell.newsText.text = news.title
        guard let urlString = news.urlToImage else {return cell}
        cell.imageView.sd_setImage(with: URL(string: urlString), completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsPresentationArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectNews(selected: indexPath.row)
    }
}


//MARK: - ViewModel Delegate
extension CategoryResultViewController : CategoryResultViewModelDelegate {
    func handleViewModelOutput(_ output: CategoryResultViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
            }
        case .updateApps(let newsPresentationArray):
            DispatchQueue.main.sync {
                self.newsPresentationArray = newsPresentationArray
                self.collectionView.reloadData()
            }
        case .showNotification(status: let status, text: let text):
            DispatchQueue.main.async {[self] in
                if(status){
                    customNotification(_title: "Success!", _message: text)
                }else{
                    customNotification(_title: "Error!", _message: text)
                }
            }
        }
    }
    
    func navigate(to route: CategoryResultViewRoute){
        switch route {
        case .newsDetail(let news):
            let viewModel = NewsDetailViewModel(news)
            let vc = NewsDetailBuilder.make(with: viewModel)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
