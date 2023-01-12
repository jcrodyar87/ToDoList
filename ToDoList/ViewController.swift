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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableTasks.delegate = self
        tableTasks.dataSource = self
    }


    @IBAction func newTask(_ sender: UIBarButtonItem) {
        
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

