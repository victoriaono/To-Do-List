//
//  ToDoTableViewController.swift
//  To-Do List
//
//  Created by Victoria Ono on 5/28/20.
//  Copyright © 2020 Victoria Ono. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var toDos : [ToDoCD] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    func createToDos() -> [ToDo] {
//        let swift = ToDo()
//        swift.name = "Learn Swift"
//        swift.important = true
//
//        let dog = ToDo()
//        dog.name = "Walk the dog"
//
//        return [swift, dog]
//    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let toDo = toDos[indexPath.row]
        
        if let name = toDo.name {
            if toDo.important {
                cell.textLabel?.text = "❗️" + name
            } else {
                cell.textLabel?.text = toDo.name
            }
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // this gives us a single ToDoCD entity
        let toDo = toDos[indexPath.row]
        performSegue(withIdentifier: "moveToComplete", sender: toDo)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let addVC = segue.destination as? AddToDoViewController {
          addVC.previousVC = self
        }
        if let completeVC = segue.destination as? CompleteToDoViewController {
            if let toDo = sender as? ToDoCD {
                completeVC.selectedToDo = toDo
                completeVC.previousVC = self
            }
        }
    }
    
    func getToDos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataToDos = try? context.fetch(ToDoCD.fetchRequest()) as? [ToDoCD] {
                    toDos = coreDataToDos
                    tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }

}
