//
//  cellFullScreen.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 5/9/21.
//

import UIKit

class swipePage : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages : [Page] = [
        Page(imageName: "deneme", headText: "Join use today in our fun and games!", descText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
        Page(imageName: "news", headText: "Subscribe and get coupons on our daily events", descText: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),
        Page(imageName: "deneme", headText: "VIP members special services", descText: "birşeyler yazmassak olmazdı maga"),
        Page(imageName: "profile", headText: "VIP members special services", descText: "VIP members special services"),
        ]
    
    
    let previousButton1 : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget( self , action: #selector(prevClicked), for: .touchUpInside)
        return button
    }()
    
    @objc private func prevClicked() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    let nextButton1 : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        let pinkColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        button.setTitleColor(pinkColor, for: .normal)
        button.addTarget( self , action: #selector(nextClicked), for: .touchUpInside)
        return button
    }()
    
    
    @objc private func nextClicked() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    let stackS : UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = pages.count
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        super.init(collectionViewLayout: layout)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Deneme"
        collectionView.register(fullPage.self, forCellWithReuseIdentifier: "cellFull")
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        setupCollectionView()
        view.addSubview(stackS)
        NSLayoutConstraint.activate([
            stackS.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackS.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackS.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackS.heightAnchor.constraint(equalToConstant: 50)
        ])
        stackS.addArrangedSubview(previousButton1)
        stackS.addArrangedSubview(pageControl)
        stackS.addArrangedSubview(nextButton1)
        view.addSubview(stackS)
    
    }
    
    private func setupCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        
        print(x, view.frame.width, x / view.frame.width)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFull", for: indexPath) as! fullPage
        cell.page = pages[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

class fullPage : UICollectionViewCell {
    
    var page : Page? {
        didSet {
            
            guard let unwrappedPage = page else {return}
            
            bearImageView.image = UIImage(named: unwrappedPage.imageName)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.descText)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
            
            destinationTextView.attributedText = attributedText
            destinationTextView.textAlignment = .center
            
            
        }
    }
    
    let viewC : UIView = {
        let newView = UIView()
        newView.translatesAutoresizingMaskIntoConstraints = false
        return newView
    }()
    let bearImageView : UIImageView = {
        let image = UIImage(named: "deneme")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let destinationTextView : UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Join us today in our fun and games!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "\n\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in out stroes soon.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
        textView.attributedText = attributedText
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(viewC)
        addSubview(destinationTextView)
        viewC.addSubview(bearImageView)
        NSLayoutConstraint.activate([
            
            viewC.topAnchor.constraint(equalTo: topAnchor),
            viewC.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewC.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewC.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            bearImageView.topAnchor.constraint(equalTo: viewC.topAnchor),
            bearImageView.leadingAnchor.constraint(equalTo: viewC.leadingAnchor),
            bearImageView.trailingAnchor.constraint(equalTo: viewC.trailingAnchor),
            bearImageView.bottomAnchor.constraint(equalTo: viewC.bottomAnchor),
            destinationTextView.topAnchor.constraint(equalTo: viewC.bottomAnchor),
            destinationTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            destinationTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            destinationTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
