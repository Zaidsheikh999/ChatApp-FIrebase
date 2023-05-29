//
//  Utility.swift
//  Messenger
//
//  Created by Zaid Sheikh on 29/05/2023.
//

import Foundation
import UIKit

class Utility: NSObject{
    
    class func showAlert(_ parentController:UIViewController, title:String?, message:String?, action:String? ,actionStyle:UIAlertAction.Style?, completion:((UIAlertAction) -> Swift.Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert);
            
            alert.addAction(UIAlertAction(title: action ?? "Ok" , style: actionStyle ?? .default, handler: completion));
            parentController.present(alert, animated: true)

        }
    }
}
