//
//  SearchPage.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 7/1/21.
//

import UIKit
import Alamofire

class SearchPage : UIViewController  {
    let apiKey: String = "565b53ef125c494985797acd7d1cfdf4"
    var url = "https://newsapi.org/v2/everything?q=tesla&from=2021-06-14&sortBy=publishedAt&apiKey=565b53ef125c494985797acd7d1cfdf4"
    var newsA : [News] = []
    
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
        sc.searchResultsUpdater = self
        sc.searchBar.delegate = self
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        setupElements()
        navigationItem.searchController = searchController
        fetchNews()
        
    }
}

extension SearchPage : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsA.count
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
    
    var imageV : UIImageView = {
        let imageV = UIImageView()
        //imageV.clipsToBounds = true
        //imageV.layer.cornerRadius = 5.0
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.backgroundColor = .orange
        return imageV
    }()
    
    var genreT : UILabel = {
        let text = UILabel()
        text.backgroundColor = .orange
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func setupConstraints() {
        addSubview(imageV)
        addSubview(genreT)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|6-[v0]-6|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : imageV]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|6-[v0]-6|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : genreT]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|6-[v0]-6-[v1]-6|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : imageV, "v1" : genreT]))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SearchPage {
    // you need write your api key from newsapi.org
    func fetchNews(){
        AF.request("https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=565b53ef125c494985797acd7d1cfdf4")
            .validate()
            .responseDecodable(of: SourceStatus.self) { (response) in
                //print(response.value)
                guard let news = response.value else {  return }
                print(news.articles[0].title)
                self.newsA = news.articles
                self.tbView.reloadData()
            }
        
    }
    
    
}
