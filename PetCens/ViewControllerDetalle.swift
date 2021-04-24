//
//  ViewControllerDetalle.swift
//  Compatibility
//
//  Created by Jan Zelaznog on 05/03/21.
//

import UIKit

class ViewControllerDetalle: UIViewController {

    var miPersona:Persona?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
// TODO: hacer una interfaz apropiada para presentar la info
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let elNombre = miPersona?.nombre
        // SUPONIENDO QUE TENEMOS Label's PARA CADA DATO DEL USUARIO:
        // labelNombre.text = miPersona?.nombre
        print ("El nombre de la persona elegida es: " + (elNombre ?? "nobody"))
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
