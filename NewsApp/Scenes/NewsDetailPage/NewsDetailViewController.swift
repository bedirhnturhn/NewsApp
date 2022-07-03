//
//  NewsContentPage.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 8/13/21.
//

import UIKit
import SDWebImage
import SafariServices

class NewsDetailViewController: UIViewController {
    
    var viewModel : NewsDetailViewModelProtocol! {
        didSet{
            viewModel.delegate = self
        }
    }
    
    let imageView : UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "content5")
        //imageV.backgroundColor = .blue
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.layer.cornerRadius = 5.0
        imageV.clipsToBounds = true
        return imageV
    }()
    
    let headerText : UITextView = {
        let textView =  UITextView()
        //textView.backgroundColor = .orange
        textView.isEditable = false
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "NEWS RESAULT"
        textView.textAlignment = .natural
        textView.font = .systemFont(ofSize: 18)
        return textView
    }()
    
    let newsContentText : UITextView = {
        let textView =  UITextView()
        //textView.backgroundColor = .orange
        textView.isEditable = false
        textView.textColor = .darkGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "ALIVELIEAVLEOAŞFOJLDADJVLDVJKLDMFLKJAMD"
        textView.textAlignment = .natural
        textView.font = .systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        return textView
    }()
    
    let readMoreButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        button.setTitle("READ FULL NEWS", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17 )
        button.addTarget(self, action: #selector(readMore), for: .touchUpInside)
        return button
    }()
    
    @objc private func readMore(){
        viewModel.showNewsDetailsInBrowser()
    }
    
    let saveButton : UIButton = {
        let dButton = UIButton()
        dButton.setTitle(" SAVE", for: .normal)
        dButton.setImage(UIImage(named: "save"), for: .normal)
        dButton.addTarget(self, action: #selector(saveClicked), for: .touchUpInside)
        dButton.translatesAutoresizingMaskIntoConstraints = false
        //sButton.backgroundColor = .red
        dButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        dButton.setTitleColor(.gray, for: .normal)
        return dButton
    }()
    
    @objc private func saveClicked(){
        print("save button clicked")
        saveButton.imageView?.image = UIImage(named: "saveFilled")
    }
    
    let deleteButton : UIButton = {
        let sButton = UIButton()
        sButton.setTitle(" DELETE", for: .normal)
        sButton.addTarget(self, action: #selector(saveClicked), for: .touchUpInside)
        sButton.translatesAutoresizingMaskIntoConstraints = false
        //sButton.backgroundColor = .blue
        sButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        sButton.setImage(UIImage(named: "trash"), for: .normal)
        sButton.setTitleColor(.gray, for: .normal)
        return sButton
    }()
    
    @objc private func deleteClicked(){
        print("delete clicked")
        
    }
    
    let saveAndDelete : UIStackView = {
        let uiStack = UIStackView()
        //uiStack.backgroundColor = .orange
        uiStack.translatesAutoresizingMaskIntoConstraints = false
        uiStack.distribution = .fillEqually
        return uiStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setup()
        view.backgroundColor = .white
    }
    
    func setup(){
        viewModel.load()
    }
    
    func layout(){
        view.addSubview(imageView)
        view.addSubview(saveAndDelete)
        view.addSubview(headerText)
        view.addSubview(newsContentText)
        view.addSubview(readMoreButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            imageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            imageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            
            saveAndDelete.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            saveAndDelete.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12),
            saveAndDelete.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            saveAndDelete.heightAnchor.constraint(equalToConstant: 45),
            
            headerText.topAnchor.constraint(equalTo: saveAndDelete.bottomAnchor, constant: 6),
            headerText.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12),
            headerText.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            headerText.heightAnchor.constraint(equalToConstant: 70),
            
            readMoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            readMoreButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            readMoreButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            readMoreButton.heightAnchor.constraint(equalToConstant: 50),
            
            newsContentText.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 12),
            newsContentText.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12),
            newsContentText.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            newsContentText.bottomAnchor.constraint(equalTo: readMoreButton.topAnchor, constant: -12)
        ])
        
        saveAndDelete.addArrangedSubview(deleteButton)
        saveAndDelete.addArrangedSubview(saveButton)
    }
}


//MARK: - ViewModel Delegate
extension NewsDetailViewController : NewsDetailViewModelDelegate {
    func handleViewModelOutput(_ output: NewsDetailViewModelOutput) {
        switch output {
        case .setTitle(let title):
            self.title = title
        case .setLoading(let bool):
            print("loading \(bool)")
        case .showNotification(let result, let notificationText):
            if(result){
                customNotification(_title: "Success!", _message: notificationText)
            }else{
                customNotification(_title: "Error!", _message: notificationText)
            }
            
        case .showNewsDetail(let newsPresentation):
            headerText.text = newsPresentation.title
            newsContentText.text = newsPresentation.content
            try? imageView.sd_setImage(with: newsPresentation.urlToImage?.asURL(), completed: nil)
        }
    }
    
    func navigate(to route: NewsDetailRoute) {
        switch route {
        case .showNewsDetailsInSafari(let url):
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true, completion: nil)
        }
    }
}
