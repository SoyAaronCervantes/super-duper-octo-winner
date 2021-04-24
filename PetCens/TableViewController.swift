//
//  TableViewController.swift
//  Compatibility
//
//  Created by Jan Zelaznog on 05/03/21.
//

import UIKit

class TableViewController: UITableViewController {

    var personas = [Persona]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // obteniendo la referencia a AppDelegate
        let comosea = UIApplication.shared.delegate as! AppDelegate
        
        comosea.personaSeleccionada = nil
        
        // invocamos el método para obtener todos los registros de Persona
        //personas = comosea.personas()
        // invocamos el método para obtener los registros de un determinado estado:
        personas = comosea.personas()
        // con la nueva información redibujamos la tabla
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // el llenado de la tabla debe estar en función del numero de elementos del arreglo
        return personas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // obtenemos el elemento Persona correspondiente
        let persona = personas[indexPath.row]
        // Los objetos UITableViewCell, por default cuentan con una etiqueta y una imagen
        // para presentar textos, se usa la propiedad textLabel
        let nom = (persona.nombre ?? "")
        let ap = (persona.paterno ?? "")
        let am = (persona.materno ?? "")
        cell.textLabel?.text = nom + " " + ap + " " + am
        // para presentar imagenes, se usa la propiedad imageView
        cell.imageView?.image = UIImage(named: "tel-ico")
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Buscar el objeto que corresponde
            let personaElegida = personas[indexPath.row]
            let alert = UIAlertController(title: "Personas", message: "Confirma que quiere borrar el registro de " + (personaElegida.nombre ?? ""), preferredStyle:.alert)
            let botonAceptar = UIAlertAction(title: "SI", style:.destructive) { (localAlert) in
                // este bloque se ejecuta en un thread secundario
                // Obtenemos una referencia a AppDelegate
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                // borramos el registro de la base de datos
                let _ = appDelegate.borraPersona(personaElegida)
                // borramos el objeto en el datasource
                self.personas.remove(at: indexPath.row)
                // eliminamos la fila
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            let botonCancelar = UIAlertAction(title: "NO", style: .cancel, handler: nil)
            alert.addAction(botonAceptar)
            alert.addAction(botonCancelar)
            present(alert, animated: true, completion:nil)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let nuevoVC = segue.destination as! ViewControllerDetalle
        // obtener el indice de la fila que eligió el usuario:
        guard let indice = tableView.indexPathForSelectedRow
        else { return }
        // Buscar el objeto que corresponde
        let personaElegida = personas[indice.row]
        // Pass the selected object to the new view controller.
        nuevoVC.miPersona = personaElegida
    }

}
