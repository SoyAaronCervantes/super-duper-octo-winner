//
//  MyTextField.swift
//  Compatibility
//
//  Created by Jan Zelaznog on 06/03/21.
//

import Foundation
import UIKit

class MyTextField: UITextField {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.textColor = Utils.textColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.backgroundColor = Utils.txtBackColor.withAlphaComponent(0.75).cgColor
        self.layer.cornerRadius = 8.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.5
        self.font = Utils.contenidos
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "placeholder", attributes: [NSAttributedString.Key.foregroundColor : UIColor.yellow.withAlphaComponent(0.5) ])
        self.tintColor = Utils.textColor
    }

    // reubicar la posicion del texto
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top:0, left:20, bottom:0, right:0))
    }
    
    // reubicar la posicion del placeholder
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top:0, left:20, bottom:0, right:0))
    }
    
    // recolocar el punto donde el usuario comienza a escribir para que coincida con
    // la posición del placeholder y del texto
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top:0, left:20, bottom:0, right:0))
    }
}
