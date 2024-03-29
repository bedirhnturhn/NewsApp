//
//  HomePageHeader.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 14.11.2021.
//

import UIKit



final class HomePageHeader: UICollectionReusableView, UIScrollViewDelegate {
    
    public static let headerId = "headerId"
    weak var delegate : HomeHeaderDelegate?
    
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
        indicator.numberOfPages = 0
        indicator.currentPageIndicatorTintColor = .gray
        indicator.pageIndicatorTintColor = .lightGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var topHeadlines = [NewsPresentation]()
    public static let sliderHeight = 225
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    
        scrollViewNews.delegate = self
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / self.frame.size.width
        scrollIndicator.currentPage = Int(page)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadFeatures(){
        scrollViewNews.subviews.forEach({ $0.removeFromSuperview() })
        scrollIndicator.numberOfPages = topHeadlines.count
        scrollViewNews.contentSize = CGSize(width: self.bounds.width * CGFloat(topHeadlines.count), height: CGFloat(225))
        
        for (index, objectNews) in topHeadlines.enumerated(){
            let newsO = objectNews
            let newsViewC = SliderCellView2()
            newsViewC.newsHeaderLabel.text = newsO.title
            guard let imageUrl = URL(string: newsO.urlToImage ?? "") else {return}
            newsViewC.imageView.sd_setImage(with: imageUrl, completed: nil)
            scrollViewNews.addSubview(newsViewC)
            newsViewC.frame.size.width = CGFloat(self.bounds.width)
            newsViewC.frame.size.height = CGFloat(225)
            newsViewC.frame.origin.x = CGFloat(index) * self.bounds.size.width
            newsViewC.selectCellButton.tag = index
            newsViewC.selectCellButton.addTarget(self, action: #selector(HomePageHeader.goNewsDetailFromSlider(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func goNewsDetailFromSlider(sender: UIButton){
        print("ciktimizi \(sender.tag)")
        delegate?.showNewsDetailsInHomeSlider(sender.tag)
        
    }
    
    private func setupLayout(){
        self.addSubview(scrollViewNews)
        self.addSubview(scrollIndicator)
        scrollViewNews.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollViewNews.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        scrollViewNews.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        scrollViewNews.bottomAnchor.constraint(equalTo: scrollIndicator.topAnchor).isActive = true
        scrollIndicator.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        scrollIndicator.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        scrollIndicator.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        scrollIndicator.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
}


class SliderCellView2 : UIView {
    
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

    lazy var selectCellButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.isOpaque = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
        newsHeaderLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        newsHeaderLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -6).isActive = true
        newsHeaderLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 6).isActive = true
        newsHeaderLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor ,constant: 6).isActive = true

        self.addSubview(selectCellButton)
        selectCellButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        selectCellButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
        selectCellButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
        selectCellButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}

extension HomePageHeader : HomeHeaderProtocol{
    func updateUI(new news: [NewsPresentation]) {
        DispatchQueue.main.async { [self] in
            topHeadlines.removeAll()
            topHeadlines = news
            loadFeatures()
        }
    }
}
