//
//  Utils.swift
//  foo
//
//  Created by Jan Zelaznog on 26/02/21.
//

import Foundation
import UIKit

class Utils {
    // fuentes
    static let titulos = UIFont(name: "Roboto-Bold", size: 30)
    static let subtitulos = UIFont(name: "Roboto-Bold", size: 25)
    static let contenidos = UIFont(name: "Roboto-Regular", size: 16)
    static let pieDeFoto = UIFont(name: "Roboto-Regular", size: 12)
    // colores
    static let textColor = hexStringToUIColor(hex: "#ccddee")
    static let txtBackColor = hexStringToUIColor(hex: "#9933cc")
    // utilería para crear colores a partir de strings tipo "CSS-RGB"
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    // validaciones
    static func validaNombre(_ name: String) ->Bool {
        // validamos si la cadena no está vacía
        let tupla = stringNoVacio(unString: name)
        // la tupla que regresa la funcion tiene dos elementos, el 0 es el string
        // y el 1 es el valor bool que nos dice si el string esta vacío
        if tupla.1 {
            // Expresion regular: 18 caracteres maximo y 3 minimo
            let nombreRegExp = "^\\w{3,18}$"
            let predicado = NSPredicate(format: "SELF MATCHES %@", nombreRegExp)
            return predicado.evaluate(with:tupla.0)
        }
        return false
    }
    
    static func validaTelefono(_ phoneNumber: String) -> Bool {
        // validamos si la cadena no está vacía
        let tupla = stringNoVacio(unString: phoneNumber)
        // la tupla que regresa la funcion tiene dos elementos, el 0 es el string
        // y el 1 es el valor bool que nos dice si el string esta vacío
        if tupla.1 {
            // Expresion regular: solo dígitos. 10 caracteres forzosamente
            let telefonoRegExp = "^[0-9]{10}$"
            let predicado = NSPredicate(format: "SELF MATCHES %@", telefonoRegExp)
            return predicado.evaluate(with: tupla.0)
        }
        return false
    }
    static func validaEmail(_ email: String) -> Bool {
        // validamos si la cadena no está vacía
        let tupla = stringNoVacio(unString: email)
        // la tupla que regresa la funcion tiene dos elementos, el 0 es el string
        // y el 1 es el valor bool que nos dice si el string esta vacío
        if tupla.1 {
            let emailRegExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let predicado = NSPredicate(format:"SELF MATCHES %@", emailRegExp)
            return predicado.evaluate(with:tupla.0)
        }
        return false
    }
    static func validaPassword(_ password: String) -> Bool {
        let tupla = stringNoVacio(unString: password)
        // la tupla que regresa la funcion tiene dos elementos, el 0 es el string
        // y el 1 es el valor bool que nos dice si el string esta vacío
        if tupla.1 {
            // Expresion regular: Mínimo 8 caracteres al menos 1 Alfabetico y 1 Numero
            let passRegExp = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
            let predicado = NSPredicate(format:"SELF MATCHES %@", passRegExp)
            return predicado.evaluate(with:tupla.0)
        }
        return false
    }
    
    static func stringNoVacio(unString: String) -> (String, Bool) {
        // quitamos espacios al inicio y al final
        let trimmedString = unString.trimmingCharacters(in: .whitespaces)
        return (trimmedString, (trimmedString != ""))
    }
}
