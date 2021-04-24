//
//  ViewController.swift
//  Compatibility
//
//  Created by Jan Zelaznog on 05/03/21.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    
    var tecladoArriba = false
    let placeholder = ["nombre","apellido paterno","apellido materno","correo","telefono","estado","ciudad"]
    
    @IBOutlet var txtFields: [UITextField]!
    @IBOutlet weak var scroolView: UIScrollView!
    @IBAction func tapEnLaVista() {
        view.endEditing(true)
    }
    
    @IBAction func btnGuardar(_ sender: UIButton) {
        // validar los datos introducidos por el usuario
        var mensaje = ""
        if !(Utils.stringNoVacio(unString: txtFields[6].text!).1) {
            mensaje = "Introduzca una ciudad válida"
        }
        if !(Utils.stringNoVacio(unString: txtFields[5].text!).1) {
            mensaje = "Introduzca un estado válido"
        }
        if !(Utils.validaTelefono(txtFields[4].text!)) {
            mensaje = "Introduzca un teléfono válido"
        }
        if !(Utils.validaEmail(txtFields[3].text!)) {
            mensaje = "Introduzca un correo válido"
        }
        // El apellido materno podría estar vacío porque no todas las personas tienen dos apellidos
        if !(Utils.validaNombre(txtFields[1].text!)) {
            mensaje = "Introduzca un apellido paterno válido"
        }
        if !(Utils.validaNombre(txtFields[0].text!)) {
            mensaje = "Introduzca un nombre válido"
        }
        
        if mensaje == "" {
            // Todo Ok, guardar la info
            //Obtener una referencia a AppDelegate
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //Obtenemos el objeto de la clase NSManagedObjectContext
            let contexto = appDelegate.persistentContainer.viewContext
            //Creamos una instancia del la propiedad persona
            let persona = NSEntityDescription.insertNewObject(forEntityName: "Persona", into: contexto) as! Persona
            //Asignamos los valores para cada una de las propiedades
            persona.nombre = txtFields[0].text!
            persona.paterno = txtFields[1].text!
            persona.materno = txtFields[2].text!
            persona.correo = txtFields[3].text!
            persona.telefono = txtFields[4].text!
            persona.estado = txtFields[5].text!
            persona.ciudad = txtFields[6].text!
            //Salvamos los cambios al contexto
            if appDelegate.saveContext() {
                // se guardó correctamente, borramos el formulario
                mensaje = "El registro se guardó correctamente"
                for txt in txtFields {
                    txt.text = ""
                }
            }
            else {
                mensaje = "El registro no se guardó, ocurrió un error"
            }
        }
        
        let alert = UIAlertController(title: "Personas", message: mensaje, preferredStyle:.alert)
        let boton = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(boton)
        present(alert, animated: true, completion:nil)
    }
    
    //////////
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector:#selector(tecladoAparece), name:UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(tecladoDesaparece), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func tecladoAparece (notificacion: Notification) {
        if tecladoArriba{
            return
        }
        tecladoArriba = true
        print ("el teclado subió")
        if let tamanioTeclado = (notificacion.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
            NSValue)?.cgRectValue{
            scroolView.contentSize.height += tamanioTeclado.height        }
    }
    
    @objc func tecladoDesaparece (notificacion: Notification) {
        tecladoArriba = false
        print ("el teclado se fue")
        if let tamanioTeclado = (notificacion.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
            NSValue)?.cgRectValue{
            scroolView.contentSize.height -= tamanioTeclado.height
        }
    }
    /////////////
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for txtF in txtFields {
            txtF.delegate = self
        }
        // for-each en swift sería equivalente a:
        // for (index = 0; index < 7; index += 1)
        for index in 0...6 {
            txtFields[index].placeholder = placeholder[index]
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let index = txtFields.firstIndex(of: textField) else{return true}
        
        if index < (txtFields.count - 1) {
        let siguienteTXT = txtFields[index + 1]
            siguienteTXT.becomeFirstResponder()
            return false
        }
        
        return true
        
    }
    


}
/*

 
 
 
 
 
 
import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var txtFields: [UITextField]!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var tecladoArriba = false
    
    @IBAction func tapEnLaVista() {
        view.endEditing(true)
    }
    
    @IBAction func btnGuardar(_ sender: UIButton) {
        // TODO: Validar los datos introducidos por el usuario
        
        
        // Obtenemos el objeto NSManagedObjectContext
        let contexto = appDelegate.persistentContainer.viewContext
        // creamos una instancia de la entidad Persona
        let persona = NSEntityDescription.insertNewObject(forEntityName: "Persona", into: contexto) as! Persona
        // Asignamos los valores para cada una de las propiedades
        persona.nombre = txtFields[0].text!
        persona.paterno = txtFields[1].text!
        persona.materno = txtFields[2].text!
        persona.correo = txtFields[3].text!
        persona.telefono = txtFields[4].text!
        persona.estado = txtFields[5].text!
        persona.ciudad = txtFields[6].text!
        // salvamos los cambios al contexto
        if appDelegate.saveContext() {
            
        }
    }
    
    //////////
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector:#selector(tecladoAparece), name:UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(tecladoDesaparece), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func tecladoAparece (notificacion: Notification) {
        if tecladoArriba {
            return
        }
        tecladoArriba = true
        print ("el teclado subió")
        // Obtenemos el tamaño final del teclado
        if let tamanioTeclado = (notificacion.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // aumentamos el tamaño del content del scrollview, para que haga scroll y libre el teclado
            scrollView.contentSize.height += tamanioTeclado.height
        }
    }
    
    @objc func tecladoDesaparece (notificacion: Notification) {
        print ("el teclado se fue")
        tecladoArriba = false
        // Obtenemos el tamaño final del teclado
        if let tamanioTeclado = (notificacion.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // reducimos el tamaño del content, para que ya no haga scroll cuando se oculte el teclado
            scrollView.contentSize.height -= tamanioTeclado.height
        }
    }
    /////////////
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for txtF in txtFields {
            txtF.delegate = self
        }
    }

    // TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let index = txtFields.firstIndex(of: textField)
        else { return true }
        
        if index < (txtFields.count - 1) {
            let siguienteTXT = txtFields[index + 1]
            siguienteTXT.becomeFirstResponder()
            return false
        }
        return true
    }

}
*/
