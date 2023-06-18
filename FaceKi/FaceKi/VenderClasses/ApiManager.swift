//
//  ApiManager.swift
//
//

import Foundation
import Alamofire

class ApiManager: NSObject {
    
    static let shared = ApiManager()
    

    //MARK:- get Auth token APi Function
    func getAuthTokenApi(clientSecret: String,
                         clientId: String,
                      currentVC: UIViewController,
                      onSuccess: @escaping([String:Any]) -> Void) {
        DataManager.deviceTokken = clientId
        AlamoFireWrapper.sharedInstance.GetApiHit(action: getTokenUrl+"?clientId=\(clientId)&clientSecret=\(clientSecret)", view: currentVC.view, onSuccess: { (response) in
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
