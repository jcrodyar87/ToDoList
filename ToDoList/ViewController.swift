//
//  ViewController.swift
//  ToDoList
//
//  Created by Juan Carlos Rodriguez Yarmas on 12/01/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableTasks: UITableView!
    
    var taskList = [Task]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableTasks.delegate = self
        tableTasks.dataSource = self
        
        loadTasks()
    }


    @IBAction func newTask(_ sender: UIBarButtonItem) {
        var title = UITextField()
        
        let alert = UIAlertController(title: "New", message: "Task", preferredStyle: .alert)
        
        let actionAccept = UIAlertAction(title: "Add", style: .default){ (_) in
            let newTask = Task(context: self.context)
            newTask.title = title.text!
            newTask.finished = false
            self.taskList.append(newTask)
            
            self.save()
        }
        
        alert.addTextField(){ textFieldAlert in
            textFieldAlert.placeholder = "Enter something..."
            title = textFieldAlert
        }
        
        alert.addAction(actionAccept)
        
        present(alert, animated: true)
    }
    
    func save(){
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
        
        self.tableTasks.reloadData()
    }
    
    func loadTasks(){
        let request : NSFetchRequest<Task> = Task.fetchRequest()
        
        do{
            taskList = try context.fetch(request)
        }catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableTasks.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let task = taskList[indexPath.row]
        
        cell.textLabel?.text = task.title
        cell.textLabel?.textColor = task.finished ? .black : .blue
        cell.detailTextLabel?.text = task.finished ? "Finished" : "Pending"
        
        cell.accessoryType = task.finished ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableTasks.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableTasks.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableTasks.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        taskList[indexPath.row].finished = !taskList[indexPath.row].finished
        
        save()
        
        tableTasks.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .normal, title: "Delete"){
            _, _, _ in
            self.context.delete(self.taskList[indexPath.row])
            self.taskList.remove(at: indexPath.row)
            
            self.save()
        }
        
        actionDelete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [actionDelete])
    }
    
}

