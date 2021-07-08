//
//  SearchPage.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 7/1/21.
//

import UIKit

class SearchPage : UIViewController  {
    
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
        sc.searchBar.searchBarStyle = .prominent
        sc.searchResultsUpdater = self
        sc.searchBar.delegate = self
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        setupElements()
        navigationItem.searchController = searchController
        
    }
}

extension SearchPage : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "sourceCell", for: indexPath) as! SourceCell
        return cell
    }
}

extension SearchPage : UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
    }
}

extension SearchPage {
    func setupElements(){
        view.addSubview(tbView)
        NSLayoutConstraint.activate([
            tbView.topAnchor.constraint(equalTo: view.topAnchor),
            tbView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tbView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tbView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        
        
    }
}

class SourceCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
