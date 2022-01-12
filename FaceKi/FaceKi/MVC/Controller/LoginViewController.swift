//
//  LoginViewController.swift
//  FaceKi
//
//  Created by Varun Naharia on 11/01/22.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var signInImg: UIImageView!
    @IBOutlet weak var signUpImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.startLoaderGif(isLoaderStart: true)
        let langStr = Locale.current.languageCode
        if langStr == "ar"{
            signUpImg.image = UIImage(named: "Sign-up (1)")
            signInImg.image = UIImage(named: "Sign-in-1")
        }else{
            signUpImg.image = UIImage(named: "Sign-up")
            signInImg.image = UIImage(named: "Sign-in")
        }
        
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        let vc = Storyboard.instantiateViewController(withIdentifier: "RegisterUserVC") as! RegisterUserVC
        DataManager.isSignIn = "SignIn"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    @IBAction func signInAction(_ sender: Any) {
        let vc = Storyboard.instantiateViewController(withIdentifier: "TakeSelfieVC") as! TakeSelfieVC
        DataManager.isSignIn = ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
