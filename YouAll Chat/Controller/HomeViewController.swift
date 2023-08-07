//
//  HomeViewController.swift
//  YouAll Chat
//
//  Created by Umer on 05/08/2023.
//

import UIKit
import Firebase

class HomeViewController : UIViewController {
    
    //MARK: - Variables
    
    let userAutentication = UserAuthentication()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true

        
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        
        userAutentication.logOut()
        navigationController?.popToRootViewController(animated: true)
    }
    
}
