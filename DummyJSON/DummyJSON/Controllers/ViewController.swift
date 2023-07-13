//
//  ViewController.swift
//  DummyJSON
//
//  Created by Muzammal Shahzad on 6/9/23.
//

import UIKit

struct DashboardModal {
    var string : String
    var dashboardType : DashboardType
}

enum DashboardType: String {
    
    case Products = "Products"
    case Carts = "Carts"
    case Users = "Users"
    case Posts = "Posts"
    case Comments = "Comments"
    case Quotes = "Quotes"
    case Todo = "Todo"
    
    var stringValue: String {
        return rawValue
    }
}



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    

    @IBOutlet weak var tableView: UITableView!
    
    let dataArr = [
        DashboardModal(string: "Products", dashboardType: .Products),
        DashboardModal(string: "Carts", dashboardType: .Carts),
        DashboardModal(string: "Users", dashboardType: .Users),
        DashboardModal(string: "Posts", dashboardType: .Posts),
        DashboardModal(string: "Comments", dashboardType: .Comments),
        DashboardModal(string: "Quotes", dashboardType: .Quotes),
        DashboardModal(string: "Todo", dashboardType: .Todo),
    ]
    
    var usersList : UserList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call the function to make the GET request
        NetworkService.shared.fetchUserList { [self] result in
            switch result {
            case .success(let success):
                usersList = success
            case .failure(let failure):
                print(failure)
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RowsTableViewCell", bundle: nil), forCellReuseIdentifier: "RowsTableViewCell")
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RowsTableViewCell", for: indexPath) as! RowsTableViewCell
        let dashboardModal = dataArr[indexPath.row]
        cell.titleLable.text = dashboardModal.dashboardType.stringValue
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedDashboard = dataArr[indexPath.row].dashboardType
        
        switch selectedDashboard {
        case .Products:
            // Handle selection for "Products" dashboard
            // Code specific to Products dashboard
            break
            
        case .Carts:
            // Handle selection for "Carts" dashboard
            // Code specific to Carts dashboard
            break
            
        case .Users:
            pushViewController(with: "UsersViewController", data: usersList)
            break
            
        case .Posts:
            // Handle selection for "Posts" dashboard
            // Code specific to Posts dashboard
            break
            
        case .Comments:
            // Handle selection for "Comments" dashboard
            // Code specific to Comments dashboard
            break
            
        case .Quotes:
            // Handle selection for "Quotes" dashboard
            // Code specific to Quotes dashboard
            break
            
        case .Todo:
            // Handle selection for "Todo" dashboard
            // Code specific to Todo dashboard
            break
        }
        
       
    }
    
   

}



extension UIViewController{
    
    func pushViewController<T>(with controllerName: String, data: T?){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: controllerName) as? UsersViewController {
            if let userData = data as? UserList {
                controller.data = userData      }
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}


extension UITableView {
    func registerCustomCell<T: UITableViewCell>(_: T.Type) {
        let className = String(describing: T.self)
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withIdentifier identifier: String, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell with identifier: \(identifier)")
        }
        return cell
    }
    
}
