//
//  ConversationViewController.swift
//  Messenger
//
//  Created by Zaid Sheikh on 29/05/2023.
//

import UIKit
import FirebaseAuth

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.isValidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    private func isValidate(){
        let isLoggedIn = UserPreferences.isLoggedIn
        
        if FirebaseAuth.Auth.auth().currentUser == nil{
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.navigationBar.tintColor = .black
            present(nav, animated: false)
        }
    }


}
