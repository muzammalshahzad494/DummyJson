//
//  CartViewController.swift
//  DummyJSON
//
//  Created by Muzammal Shahzad on 6/26/23.
//

import UIKit

class CartViewController: UIViewController {
   
    

    
    @IBOutlet weak var titleLable: UILabel!
    
    var cartData = ""
    var postData = ""
    var todoData = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleLable.text = cartData
        titleLable.text = postData
        titleLable.text = todoData
    }

   

}
