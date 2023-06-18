//
//  RegisterUserVC.swift
//  FaceKi
//
//  Created by Logictrix on 12/11/21.
//

import UIKit
import FlagPhoneNumber

class RegisterUserVC: BaseViewController {
    
    @IBOutlet weak var testImg: UIImageView!
    @IBOutlet weak var firstNameTxtfld: UITextField!
    @IBOutlet weak var lastNameTxtfld: UITextField!
    @IBOutlet weak var phonrTxtfld: FPNTextField!
    @IBOutlet weak var emailTxtfld: UITextField!
    @IBOutlet weak var passwordTxtfld: UITextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    var userImage = UIImage()
    var dialCodeStr = String()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        testImg.image = userImage
        phonrTxtfld.delegate = self
        
        dialCodeStr = "+1"
        //        firstNameTxtfld.text = "Marwa"
        //        lastNameTxtfld.text = "Gerashi"
        //        phonrTxtfld.text = "34146705"
        //        emailTxtfld.text = "marwagerashi93@gmail.com"
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        if checkValidation() == true {
            self.getUserTokenApiHit()
        }
    }
    @IBAction func backAction(_ sender: Any) {
        performSegueToReturnBack()
    }
    
    //MARK:- get User Token Api Hit
    func getUserTokenApiHit(){
        self.startLoaderGif(isLoaderStart: true)
        ApiManager.shared.getAuthTokenApi(clientSecret: DataManager.clientSecret, clientId: DataManager.clientId,
            currentVC: self, onSuccess: { (response) in
            print("get User Token Api Hit Response ",response)
            let data = response["data"] as? [String:Any] ?? [:]
            print("data token response",data["access_token"] ?? "")
            if let token = data["access_token"] as? String {
                DataManager.authorizationTokken = token
                
                if DataManager.isSignIn == "SignIn"{
                    let vc = Storyboard.instantiateViewController(withIdentifier: "TakeSelfieVC") as! TakeSelfieVC
                    let name = "\(self.firstNameTxtfld.text!) \(self.lastNameTxtfld.text!)"
                    vc.firstName = self.firstNameTxtfld.text!
                    vc.lastName = self.lastNameTxtfld.text!
                    vc.email = self.emailTxtfld.text!
                    vc.password = self.passwordTxtfld.text!
                    vc.mobile = self.phonrTxtfld.text!
                    DataManager.isSignIn = "SignIn"
                    vc.dialCodeStr = self.dialCodeStr
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else{
                
                    var imagesData = Data()
                    if let imageDataFaceImage = self.userImage.jpeg(.medium) {
                        imagesData = imageDataFaceImage
                    }
                    self.registerUserApiHit(imageData: imagesData, email: self.emailTxtfld.text!,password: self.passwordTxtfld.text!, mobile: self.phonrTxtfld.text!, firstName: self.firstNameTxtfld.text!, lastName: self.lastNameTxtfld.text!, fileName: "", mimeType: "")
                }
            }
        })
    }
    
    //MARK:- registerUserApiHit Api Hit
    func registerUserApiHit(imageData: Data, email: String,password: String, mobile: String, firstName: String,lastName: String, fileName: String, mimeType: String){
        
        var mobileNumber = "\(dialCodeStr)\(mobile)"
        mobileNumber = mobileNumber.replacingOccurrences(of: " ", with: "")
        print("mobileNumber ",mobileNumber)
        
        let params:[String: Any] = ["selfie_image": "file.jpg",
                                    "email":email,
                                    "phoneNumber":mobileNumber,
                                    "firstName":firstName, "lastName":lastName,"password":password]
        
        //        CommonFunctions.startProgressView(view: self.view)
        AlamoFireWrapper.sharedInstance.MultipartApiHit(action: registrationUrl, imageData: imageData, view: self.view, param: params, withName: "image", fileName: fileName, mimeType: mimeType, onSuccess: { (response) in
            
            //            CommonFunctions.dismissProgressView(view: self.view)
            self.startLoaderGif(isLoaderStart: false)
            switch(response.result) {
            case .success(let value):
                //                print("value = ",value)
                let  dictionaryContent = value as? NSDictionary ?? [:]
                print("upload Test Report Image Api hit Response ",dictionaryContent)
                
                let status = dictionaryContent["status"] as? String ?? ""
                if status == "Failed" {
                    self.showAlert(message: dictionaryContent["message"] as? String ?? "")
                }
                
                let status2 = dictionaryContent["status"] as? Int ?? -1
                if status2 == 0 {
                    self.showAlert(message: dictionaryContent["message"] as? String ?? "")
                }
                
                if status != "Failed" && status2 != 0  {
                    objUser.parseUserData(responseDict: dictionaryContent["user"] as? Dictionary ?? [:])
                    
                    DataManager.isUserRegistered = true
                    let vc = Storyboard.instantiateViewController(withIdentifier: "TakeSelfieVC") as! TakeSelfieVC
                    vc.screenName = "Register"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                break
            case .failure(_):
                
                print("do nothing")
            }
        }) { (error) in
            self.startLoaderGif(isLoaderStart: false)
            //            CommonFunctions.dismissProgressView(view: self.view)
            print(error.localizedDescription)
            CommonFunctions.showAlert(self, message: error.localizedDescription, title: "Error!")
        }
    }
    
    func showAlert(message: String){
        let alertController = UIAlertController(title: appName, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.performSegueToReturnBack()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkValidation() -> Bool {
        var isValid = true
        
        firstNameLabel.textColor = .darkGray
        lastNameLabel.textColor = .darkGray
        phoneLabel.textColor = .darkGray
        emailLabel.textColor = .darkGray
        
        if(((firstNameTxtfld.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            firstNameLabel.textColor = .red
            isValid = false
        }
        
        if(((lastNameTxtfld.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            lastNameLabel.textColor = .red
            isValid = false
        }
        
        if(((phonrTxtfld.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            phoneLabel.textColor = .red
            isValid = false
        }
        
        if(((emailTxtfld.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            emailLabel.textColor = .red
            isValid = false
        }
        if(((passwordTxtfld.text!.trimmingCharacters(in: .whitespaces).isEmpty))){
            passwordLabel.textColor = .red
            isValid = false
        }
        return isValid
    }
    
}

extension RegisterUserVC: FPNTextFieldDelegate {
    func fpnDisplayCountryList() {
        
    }
    
    
    //   /// The place to present/push the listController if you choosen displayMode = .list
    //   func fpnDisplayCountryList() {
    //      let navigationViewController = UINavigationController(rootViewController: listController)
    //
    //      present(navigationViewController, animated: true, completion: nil)
    //   }
    
    /// Lets you know when a country is selected
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code) // Output "France", "+33", "FR"
        dialCodeStr = dialCode
    }
    
    /// Lets you know when the phone number is valid or not. Once a phone number is valid, you can get it in severals formats (E164, International, National, RFC3966)
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            // Do something...
            textField.getFormattedPhoneNumber(format: .E164)         // Output "+33600000001"
            textField.getFormattedPhoneNumber(format: .International)  // Output "+33 6 00 00 00 01"
            textField.getFormattedPhoneNumber(format: .National)       // Output "06 00 00 00 01"
            textField.getFormattedPhoneNumber(format: .RFC3966)       // Output "tel:+33-6-00-00-00-01"
            textField.getRawPhoneNumber()                               // Output "600000001"
        } else {
            // Do something...
        }
    }
}
