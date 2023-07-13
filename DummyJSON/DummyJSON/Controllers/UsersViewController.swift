//
//  UsersViewController.swift
//  DummyJSON
//
//  Created by Muzammal Shahzad on 6/22/23.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UISearchBarDelegate {
    
    var data : UserList?
    let searchResult = "john"
    private let searchBar = UISearchBar()
    private var searchTask: DispatchWorkItem?
    var eyeColor = "Amber"
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User List"
        
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
        
        
//        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
//        navigationItem.rightBarButtonItem = plusButton
        
        tableView.delegate  = self
        tableView.dataSource = self
        tableView.registerCustomCell(RowsTableViewCell.self)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RowsTableViewCell", for: indexPath) as! RowsTableViewCell
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        longPressGesture.delegate = self
        cell.addGestureRecognizer(longPressGesture)
        
        let dataArr = data?.users[indexPath.row].username
        cell.titleLable.text = dataArr
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let selectedUserID = data?.users[indexPath.row].id {
            NetworkService.shared.fetchSingleuser(for: selectedUserID) { result in
                switch result {
                case .success(let success):
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SingleViewController") as! SingleViewController
                    nextViewController.data = success
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                case .failure(let failure):
                    print(failure)
                }
            }
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Cancel the previous search task if any
        searchTask?.cancel()
        
        // Create a new search task with a debounce delay
        let task = DispatchWorkItem { [weak self] in
            self?.performSearch(with: searchText)
        }
        
        // Save the new search task
        searchTask = task
        
        // Schedule the search task with a debounce delay of 0.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task)
    }
    
    private func performSearch(with searchText: String) {
        // Call your API here with the entered search text
        // ...
        
        print("Performing search for: \(searchText)")
        NetworkService.shared.fetchSearchUser(for: searchText) { [self] result in
            switch result { 
            case .success(let success):
                print(success)
                self.data = success
                tableView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
    @objc func plusButtonTapped() {
        // Handle plus button tapped
    }
    
    @objc func handleLongPressGesture(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            // Handle long-press gesture here
            
            if let cell = gestureRecognizer.view as? UITableViewCell {
                // Get the indexPath of the cell
                if let indexPath = tableView.indexPath(for: cell) {
                    // Perform actions specific to the selected cell
                    
                    // Open the context menu or perform any other actions
                    let alertController = UIAlertController(title: "Options", message: "Choose an action", preferredStyle: .actionSheet)
                    
                    // Add actions to the alert controller
                    let action1 = UIAlertAction(title: "Update", style: .default) { (_) in
                        // Handle Action 1
                    }
                    let action2 = UIAlertAction(title: "Delete", style: .default) { (_) in
                        // Handle Action 1
                    }
                    let action3 = UIAlertAction(title: "Todo's", style: .default) { (_) in
                        // Handle Action 1
                    }
                    alertController.addAction(action1)
                    alertController.addAction(action2)
                    alertController.addAction(action3)
                    // Add more actions if needed
                    
                    // Show the alert controller
                    present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func tapFilterButton(_ sender: Any) {
        NetworkService.shared.fetchFilterUser(for: eyeColor) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
}
