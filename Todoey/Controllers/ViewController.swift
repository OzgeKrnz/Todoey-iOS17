//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItem?.tintColor = .gray
        
        /*if let items = defaults.array(forKey: "toDoListArray") as? [String]{
         itemArray = items
         }*/
        //
        
        if let savedData = defaults.data(forKey: "toDoListArray") {
            let decoder = JSONDecoder()
            if let decodedItems = try? decoder.decode([Item].self, from: savedData) {
                itemArray = decodedItems
            }}
 
        
    }
    
    @objc func addItem(){
        let ac = UIAlertController(title: "Add new ToDo item", message: nil, preferredStyle: .alert)
        
        ac.addTextField{(alertTextField) in
            alertTextField.placeholder = "Create new item"
            
        }
        
        let submitItem = UIAlertAction(title: "Add Item", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return}
            
            let answerItem = Item()
            answerItem.title = answer
            answerItem.done = false
            self?.submit(answerItem)
        }
        ac.addAction(submitItem)
        present(ac, animated: true)
        
    }
    
    func saveItems() {
        let itemsToSave = itemArray.map { ["title": $0.title, "done": $0.done] }
        defaults.set(itemsToSave, forKey: "toDoListArray")
        tableView.reloadData()
    }

    func submit(_ item: Item){
      
        itemArray.insert(item, at: .zero)
        saveItems()
    }
    
    //MARK- Tableview DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        if itemArray[indexPath.row].done == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        
        if itemArray[indexPath.row].done == false{
            itemArray[indexPath.row].done = true
        }else{
            itemArray[indexPath.row].done = false
        }
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    


}

