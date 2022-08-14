//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 14.08.2022.
//

import UIKit

final class SearchViewController : UIViewController {
    //MARK: - Properties
    var viewModel : SearchViewModelProtocol!{
        didSet{
            viewModel.delegate = self
        }
    }
    
    //MARK: - Views
    lazy var tbView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(SourceCell.self, forCellReuseIdentifier: "sourceCell")
        return tv
    }()
    
    lazy var searchController : UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "Search News..."
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.sizeToFit()
        sc.searchBar.searchBarStyle = .default
//        sc.searchResultsUpdater = self
//        sc.searchBar.delegate = self
        return sc
    }()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        setup()
        layout()
    }
    
    private func setup(){
        tbView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func layout(){
        view.addSubview(tbView)
        tbView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.categories[indexPath.row]
        return cell
    }
}

extension SearchViewController : SearchViewModelDelegate{
    func handleViewModelOutput(_ output: SearchViewModelOutput) {
        DispatchQueue.main.async {[self] in
            switch output {
            case .setLoading(let bool):
                //setloading
                print("\(bool)")
            case .setTitle(let title):
                navigationItem.title = title
            case .showNotification(let result, let notificationText):
                print("\(result),\(notificationText)")
            case .updateSourcesList:
                tbView.reloadData()
            }
        }
    }
    
    func navigate(to route: SearchRoute) {
        
    }
}
