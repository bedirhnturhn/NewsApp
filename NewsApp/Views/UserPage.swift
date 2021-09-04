//
//  UserPage.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 4/24/21.
//

import UIKit

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}


class UserPage: UIViewController {
    //let's avoid polluting viewDidLoad
    //{} is referred to as closure, or anon. functions
    
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
    
    let descriptionLabel : UILabel = {
       let labelText = UILabel()
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.text = "Naber bebek gel diskoya gidek!!!"
        labelText.font = UIFont.boldSystemFont(ofSize: 12)
        return labelText
    }()
    
    let previousButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    let nextButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        let pinkColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        button.setTitleColor(pinkColor, for: .normal)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.pageIndicatorTintColor = .gray
        pc.currentPageIndicatorTintColor = .mainPink
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Profile"
        //here' our entry point into our app
        //view.backgroundcolor = .yellow
         
        //let imageView = UIImageView(image: UIImage(named: "news"))
        view.addSubview(bearImageView)
        view.addSubview(destinationTextView)
        setupLayout()
        setupBottomControls()
    }
    
    fileprivate func setupBottomControls() {
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton,  pageControl ,nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        //yayılma
        bottomControlsStackView.distribution = .fillEqually
        //dikinne yapma
        //bottomControlsStackView.axis = .vertical
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            // safe area kullanmyaı unutma man
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    private func setupLayout() {
        let topImageContainerView = UIView()
        
        view.addSubview(topImageContainerView)
        //topImageContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        //enable auto layout
        
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        //topImageContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        //topImageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        
        
        topImageContainerView.addSubview(bearImageView)
        bearImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        bearImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        bearImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.7).isActive = true
        
        // this enables autolayout for our imageView
        
        //bearImageView.translatesAutoresizingMaskIntoConstraints = false
        /*
         buraya yorum yapytık image ı view içine ekleyecem
        bearImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        bearImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        bearImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        bearImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        */
        
        
        
        destinationTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        destinationTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        destinationTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        destinationTextView.bottomAnchor.constraint(equalTo:view.bottomAnchor ).isActive = true
        
        //sağ için eksi değer vereceksin
        
        
    }
}

