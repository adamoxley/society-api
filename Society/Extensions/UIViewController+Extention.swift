//
//  UIViewController+Extention.swift
//  society
//
//  Created by Adam Oxley on 28/05/2018.
//  Copyright © 2018 Adam Oxley. All rights reserved.
//

import UIKit

extension UIViewController {

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func whiteNavigation(displayDividerLine: Bool = false) {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if displayDividerLine {
            navigationController?.navigationBar.shadowImage = UIImage(named: "grey_divider_line")
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
