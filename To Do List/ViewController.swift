//
//  ViewController.swift
//  To Do List
//
//  Created by Anastasia Kyratzoglou on 9/18/19.
//  Copyright © 2019 Anastasia Kyratzoglou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    var toDoArray = ["Learn Swift","Build apps", "Change the world!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItem"{
            let distination = segue.destination as! DetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            distination.toDoItem = toDoArray[index]
        }else{
            if let selectedPath = tableView.indexPathForSelectedRow{
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
        
    }
    
    @IBAction func unwindFromDetailController(segue: UIStoryboardSegue){
        let sourceViewController = segue.source as! DetailViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            toDoArray[indexPath.row] = sourceViewController.toDoItem!
            tableView.reloadRows(at: [indexPath], with:.automatic)
        }else{
            let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
            toDoArray.append(sourceViewController.toDoItem!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing{// if button is clicked while editing, I'm done
            tableView.setEditing(false, animated: true) //turn off tableView editing
            editBarButton.title = "Edit"                // set button label so it can restart edit
            addBarButton.isEnabled = true                 // enable the "+" button
        }else{                                          // I wasnt editing so start editing
            tableView.setEditing(true, animated: true)  //turn on tableView editing
            editBarButton.title = "Done"                // set button label so it can restart edit
            addBarButton.isEnabled = false              // disable the "+" button
        }
    }
    
}

//Extensions
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            toDoArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = toDoArray[sourceIndexPath.row]
        toDoArray.remove(at: sourceIndexPath.row)
        toDoArray.insert(itemToMove, at: destinationIndexPath.row)
    }
}
    

