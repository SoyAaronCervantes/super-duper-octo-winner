//
//  AppDelegate.swift
//  Compatibility
//
//  Created by Jan Zelaznog on 05/03/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // ejemplo de una variable "global" que necesita ser accedida por varios controller
    var personaSeleccionada:Persona?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func personas() -> [Persona] {
        let fr = NSFetchRequest<Persona>(entityName: "Persona")
        // var people:[Persona] = []  // forma de inicialización 1
        // var people:Array<Persona> = [] // forma de inicialización 2
        var people = [Persona]() // forma de inicializar 3
        do {
            // trata de ejecutar el request contra la base de datos
            people = try persistentContainer.viewContext.fetch(fr)
        }
        catch {
            // no se pudo ejecutar el request
            /* LOG */   print("Error al recuperar info de la BD " + error.localizedDescription)
            // mandar un alert?
            /* crash */ fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
        return people
    }
    
    func personasPorEstado(_ estado:String) -> [Persona] {
        let fr = NSFetchRequest<Persona>(entityName: "Persona")
        var people = [Persona]()
        // Configuramos la condición que deben cumplir los registros
        let filtro = NSPredicate(format: "estado beginswith[c] %@", estado)
        // agregamos el filtro al request
        fr.predicate = filtro
        do {
            // trata de ejecutar el request contra la base de datos
            people = try persistentContainer.viewContext.fetch(fr)
        }
        catch {
            // no se pudo ejecutar el request
            /* LOG */   print("Error al recuperar info de la BD " + error.localizedDescription)
            // mandar un alert?
            /* crash */ fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
        return people
    }
    
    // BORRADO DE UN OBJETO en la BD
    func borraPersona(_ persona:Persona) -> Bool {
        // borrar un solo objeto previamente seleccionado
        persistentContainer.viewContext.delete(persona)
        // Después de un delete, siempre hay que hacer save
        return saveContext()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
            /*
             The persistent container for the application. This implementation
             creates and returns a container, having loaded the store for the
             application to it. This property is optional since there are legitimate
             error conditions that could cause the creation of the store to fail.
            */
            let container = NSPersistentContainer(name: "PetCens")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                     
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
  
        func personByState() -> [NSDictionary] {
          var results = [NSDictionary]()
          let groupByField = NSExpression(forKeyPath: "estado")
          let functionForGrouping = NSExpression( forFunction: "count:", arguments: [groupByField] )
          let expressionDescription = NSExpressionDescription()
          expressionDescription.expression = functionForGrouping
          expressionDescription.name = "count"
          expressionDescription.expressionResultType = .integer64AttributeType
          let fetchRequest = NSFetchRequest<NSDictionary>( entityName: "Persona" )
          fetchRequest.propertiesToGroupBy = ["estado"]
          fetchRequest.propertiesToFetch = ["estado", expressionDescription ]
          fetchRequest.resultType = .dictionaryResultType
          do {
            results = try persistentContainer.viewContext.fetch( fetchRequest )
          } catch {
            // no se pudo ejecutar el request
            /* LOG */   print("Error al recuperar info de la BD " + error.localizedDescription)
            // mandar un alert?
            /* crash */ fatalError("Unresolved error \(error), \(error.localizedDescription)")
          }
          
          return results
        }

        // MARK: - Core Data Saving support
        func saveContext() -> Bool {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                    return true
                }
                catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
            return false
        }
}

