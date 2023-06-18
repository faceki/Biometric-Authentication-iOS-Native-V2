//
//  AppDelegate.swift
//  FaceKi
//
//  Created by Logictrix on 28/10/21.
//

import UIKit
import IQKeyboardManagerSwift

//App Delegate Class
let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
let Storyboard = UIStoryboard(name: "Main", bundle: nil)
let userDefault = UserDefaults.standard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        sleep(1)
        //Third-party library for KeyBoard
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
        DataManager.clientId = "clientId" // replace here with actual value
        DataManager.clientSecret = "clientSecret" // replace here with actual value
        if DataManager.isUserRegistered == true {
            getUserTokenApiHit()
        }
        
        return true
    }
    
    //MARK:- get User Token Api Hit
    func getUserTokenApiHit(){
        ApiManager.shared.getAuthTokenApi(clientSecret: DataManager.clientSecret, clientId: DataManager.clientId,
            currentVC: (self.window?.rootViewController as! UINavigationController), onSuccess: { (response) in
                        print("get User Token Api Hit Response ",response)
            let data = response["data"] as? [String:Any] ?? [:]
            
            print("data token response",data["access_token"] ?? "")
                if let token = data["access_token"] as? String {
                    DataManager.authorizationTokken = token
                    
                }
                                            
        })
    }

}

