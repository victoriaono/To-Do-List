//
//  CompleteToDoViewController.swift
//  To-Do List
//
//  Created by Victoria Ono on 5/28/20.
//  Copyright © 2020 Victoria Ono. All rights reserved.
//

import UIKit

class CompleteToDoViewController: UIViewController {
    
    var previousVC = ToDoTableViewController()
    var selectedToDo : ToDoCD?
    
    @IBOutlet weak var titleLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = selectedToDo?.name
    }
    
    @IBAction func completeTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let toRemoveToDo = selectedToDo {
                context.delete(toRemoveToDo)
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
