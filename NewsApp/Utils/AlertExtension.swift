//
//  AlertExtension.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 28.06.2022.
//

import UIKit

extension UIViewController {
    func customNotification(_title: String, _message: String, actions: (() -> Void)? = nil){
        let alert = UIAlertController(title:_title,
                                    message: _message,
                                    preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { actionA in
            actions?()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    ///this custom alert has a custom button
    func customNotificationWithButton(_title: String, _message: String, actions: (() -> Void)? = nil , _button2Title: String, actions2: (() -> Void)? = nil){
        let alert = UIAlertController(title:_title,
                                    message: _message,
                                    preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { actionA in
            actions?()
        }
        let action2 = UIAlertAction(title: _button2Title, style: .cancel) { actionB in
            actions2?()
        }
        alert.addAction(action)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
    }
}

