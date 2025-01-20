//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController, UISearchBarDelegate{
    
    var itemArray = [Item]()
    var filteredItemArray = [Item]()
    
    //search bar
    let searchBar = UISearchBar()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //UISearchBar ayarları
        searchBar.delegate = self
        searchBar.placeholder = "Search an item"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        view.addSubview(searchBar)
      
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ToDoItemCell")

        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItem?.tintColor = .gray
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
        filteredItemArray = itemArray

        
        

        
        
        // searchbar Auto layout
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
    }
    
    @objc func addItem(){
        let ac = UIAlertController(title: "Add new ToDo item", message: nil, preferredStyle: .alert)
        
        ac.addTextField{(alertTextField) in
            alertTextField.placeholder = "Create new item"
            
        }
        
        let submitItem = UIAlertAction(title: "Add Item", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return}
            
            // creating data with CoreData
            let answerItem = Item(context: self!.context)
            answerItem.title = answer
            answerItem.done = false
            self?.submit(answerItem)
        }
        ac.addAction(submitItem)
        present(ac, animated: true)
        
    }
    
    //read data from core data(read in crud)
    func loadItems(){
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data, \(error)")
        }
        filteredItemArray = itemArray
    
        
    }
    
    func saveItems(){
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
       
    func submit(_ item: Item){
      
        itemArray.insert(item, at: .zero)
        filteredItemArray = itemArray
        saveItems()
    }
    
    //MARK- Tableview DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = filteredItemArray[indexPath.row].title
        
        
        cell.accessoryType = filteredItemArray[indexPath.row].done ? .checkmark : .none
       /* if itemArray[indexPath.row].done == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }*/
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        
        //delete in crud: removing data
        //context.delete(itemArray[indexPath.row])
        
        //removing current item from the itemArray
        //itemArray.remove(at: indexPath.row)
        
        filteredItemArray[indexPath.row].done = !filteredItemArray[indexPath.row].done
      
        
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          filteredItemArray = itemArray.filter {
            if let title = $0.title{
                return title.lowercased().contains(searchText.lowercased())
            }
            return false
        }
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filteredItemArray = itemArray
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }

}
