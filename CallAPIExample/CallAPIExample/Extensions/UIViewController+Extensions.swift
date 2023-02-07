//
//  UIViewController+Extensions.swift
//  CallAPIExample
//
//  Created by Leo Ho on 2023/2/3.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
}
