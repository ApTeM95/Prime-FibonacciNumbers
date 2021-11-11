//
//  UITextFieldExtension.swift
//  Prime&Fibonacci Numbers
//
//  Created by Артем on 14.07.2021.
//

import Foundation
import UIKit
extension UITextField {
func addDoneButtonOnKeyboard()  {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        resignFirstResponder()
        _ = delegate?.textFieldShouldReturn?(self)
    }
}
