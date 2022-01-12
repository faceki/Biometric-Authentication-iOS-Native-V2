//
//  ApiManager.swift
//
//

import Foundation
import Alamofire

class ApiManager: NSObject {
    
    static let shared = ApiManager()
    

    //MARK:- get Auth token APi Function
    func getAuthTokenApi(email: String,
                      currentVC: UIViewController,
                      onSuccess: @escaping([String:Any]) -> Void) {
        
//        let uuid = UUID().uuidString
        DataManager.deviceTokken = "af7d4790-04a9-11ec-aecf-1dca4d5eaaf0"
//        print(uuid)
        let param:[String:Any] = ["client_id": "af7d4790-04a9-11ec-aecf-1dca4d5eaaf0",
                                  "email": email]
        print("param ",param)
        
        AlamoFireWrapper.sharedInstance.PostApiHit(action: getTokenUrl, param: param, view: currentVC.view, onSuccess: { (response) in
            //            print("response ",response)
            CommonFunctions.dismissProgressView(view: currentVC.view)
            switch(response.result) {
            case .success(let value):
                
                let  dictionaryContent = value as? [String:Any] ?? [:]
                print("get Auth token Api Hit Response ",dictionaryContent)
                onSuccess(dictionaryContent)
                
                break
            case .failure(_):
                print("do nothing")
            }
            
        }) { (error) in
            CommonFunctions.dismissProgressView(view: currentVC.view)
            print(error.localizedDescription)
            CommonFunctions.showAlert(currentVC, message: error.localizedDescription, title: "Error!")
        }
    }
    
}
