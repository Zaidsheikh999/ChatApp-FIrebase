//
//  AppDelegate.swift
//  Messenger
//
//  Created by Zaid Sheikh on 29/05/2023.
//

import UIKit
import FBSDKCoreKit
import Firebase
import GoogleSignIn


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        FirebaseApp.configure()
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    func application(_ app: UIApplication,open url: URL,options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        return GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                         annotation: [:])
        
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            if let error = error {
                print("Failed to sign in with google \(error)")
            }
            return
        }
        
        guard let user = user else {
            return
        }
        
        print("Did sign in with google \(user)")
        
        guard let email = user.profile.email,
              let firstName = user.profile.givenName,
              let lastName = user.profile.familyName else{
            return
        }
        DataBaseManager.shared.isUserExist(with: email, completion: { exists in
            if !exists {
                DataBaseManager.shared.insertUser(with: chatAppUser(firstName: firstName, lastName: lastName, email: email))
            }
        })
        
        guard let authentication = user.authentication else {return}
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        FirebaseAuth.Auth.auth().signIn(with: credential, completion: { authResult, error in
            guard authResult != nil, error == nil else {
                print("Fialed to sign in with google credentials")
                return
            }
            print("Sign in with google credentials")
            
            NotificationCenter.default.post(name: .didLoginNotification, object: nil)
        })
        
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Google user was disconnected")
    }
    
    
    
    
}


