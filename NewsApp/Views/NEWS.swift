//
//  NEWS.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 8/19/21.
//

import UIKit
import Alamofire
import SDWebImage

class NewsPage : UIViewController , UIScrollViewDelegate{
    
    var topHeadlines = [News]()
    var otherNews = [News]()
    
    lazy var scrollViewNews : UIScrollView = {
        let scrllV = UIScrollView()
        scrllV.translatesAutoresizingMaskIntoConstraints = false
        scrllV.isPagingEnabled = true
        scrllV.showsHorizontalScrollIndicator = false
        return scrllV
    }()
    
    lazy var scrollIndicator : UIPageControl =  {
        let indicator = UIPageControl()
        indicator.currentPage = 0
        indicator.numberOfPages = 2
        indicator.currentPageIndicatorTintColor = .gray
        indicator.pageIndicatorTintColor = .lightGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
       
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        scrollViewNews.contentSize = CGSize(width: self.view.bounds.width * 2, height: CGFloat(225))
        let denemee1 = SliderCellView()
        let denemee2 = SliderCellView()
        
        scrollViewNews.addSubview(denemee1)
        scrollViewNews.addSubview(denemee2)
        
        denemee1.frame.size.width = CGFloat(self.view.bounds.width)
        denemee1.frame.size.height = CGFloat(225)
        denemee2.frame.size.width = CGFloat(self.view.bounds.width)
        denemee2.frame.size.height = CGFloat(225)
        denemee1.frame.origin.x = /*self.scrollView.bounds.width*/ 0
        denemee2.frame.origin.x = CGFloat(1) * CGFloat(self.view.bounds.width)
        
        
        scrollViewNews.delegate = self
        
        fetchData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / view.frame.size.width
        print(page)
        scrollIndicator.currentPage = Int(page)
    }
    
    private func loadFeatures(){
        
        scrollViewNews.subviews.forEach({ $0.removeFromSuperview() })
        scrollIndicator.numberOfPages = topHeadlines.count
        scrollViewNews.contentSize = CGSize(width: self.view.bounds.width * CGFloat(topHeadlines.count), height: CGFloat(225))
        
        for (index, objectNews) in topHeadlines.enumerated() {
            let newsO = objectNews
            let newsViewC = SliderCellView()
            newsViewC.newsHeaderLabel.text = newsO.title
            guard let imageUrl = URL(string: newsO.urlToImage!) else {return}
            newsViewC.imageView.sd_setImage(with: imageUrl, completed: nil)
            scrollViewNews.addSubview(newsViewC)
            newsViewC.frame.size.width = CGFloat(self.view.bounds.width)
            newsViewC.frame.size.height = CGFloat(225)
            newsViewC.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
            
        }
    }
    
   
    private func setupLayout(){
        // scroll view
        view.addSubview(scrollViewNews)
        scrollViewNews.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollViewNews.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollViewNews.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollViewNews.heightAnchor.constraint(equalToConstant: 225).isActive = true
        
        //scroll indicator
        view.addSubview(scrollIndicator)
        scrollIndicator.topAnchor.constraint(equalTo: scrollViewNews.bottomAnchor, constant: 6).isActive = true
        scrollIndicator.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 6).isActive = true
        scrollIndicator.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -6).isActive = true
        scrollIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    
    
}


extension NewsPage {
    func fetchData()   {
        AF.request("https://newsapi.org/v2/everything?q=apple&sortBy=popularity&apiKey=565b53ef125c494985797acd7d1cfdf4")
            .validate()
            .responseDecodable(of: SourceStatus.self) { (response) in
                guard let stored = response.value?.articles else { return }
                self.topHeadlines = stored
                self.loadFeatures()
               
        }
    }
    
    func fetchOtherData() {
        AF.request("https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=565b53ef125c494985797acd7d1cfdf4")
            .validate()
            .responseDecodable(of: SourceStatus.self) { (response) in
                guard let stored = response.value?.articles else { return }
                self.otherNews = stored
            }
    }
}


class SliderCellView : UIView {
    
    lazy var imageView : UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = .brown
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.image = UIImage(named: "slider")
        imageV.layer.cornerRadius = 5.0
        imageV.clipsToBounds = true
        return imageV
    }()

    lazy var newsHeaderLabel : UITextView = {
        let textView =  UITextView()
        textView.isEditable = false
        textView.textColor = .black
        textView.backgroundColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "DENEMEMEMEME"
        textView.textAlignment = .center
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        
        self.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 185).isActive = true

        self.addSubview(newsHeaderLabel)
        newsHeaderLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -6).isActive = true
        newsHeaderLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -6).isActive = true
        newsHeaderLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 6).isActive = true
        newsHeaderLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true

    }
    
}

