//
//  UserData.swift
//
//

import Foundation
var numberOfScannedDoc = Int()

class UserData {
    
    func parseUserData(responseDict: [String: Any]) {
        
        DataManager.userId = responseDict["_id"] as? String ?? "0"
        DataManager.clientId = responseDict["client_id"] as? String ?? "NA"
        DataManager.confidence = responseDict["confidence"] as? Double ?? 0.0
        DataManager.email = responseDict["email"] as? String ?? "NA"
        DataManager.faceId = responseDict["face_id"] as? String ?? "NA"
        DataManager.imageId = responseDict["image_id"] as? String ?? "NA"
        DataManager.mobileNumber = responseDict["mobile_number"] as? String ?? "998989898"
        DataManager.name = responseDict["name"] as? String ?? "Test User"
    }
    
    func parseSDKsettingsData(responseDict: [String: Any]) {
        
        DataManager.declinedMessage = responseDict["declined_meaasge"] as? String ?? "Please visit our branch office."
        DataManager.declinedRedirectUrl = responseDict["declined_redirect_url"] as? String ?? "www.faceki2.com"
        DataManager.docTypeOne = responseDict["doc_type_one"] as? String ?? ""
        DataManager.docTypeTwo = responseDict["doc_type_two"] as? String ?? ""
        DataManager.docTypeThree = responseDict["doc_type_three"] as? String ?? ""
        DataManager.invalidMeaasge = responseDict["invalid_meaasge"] as? String ?? "Opps! your card expired"
        DataManager.invalidRedirectUrl = responseDict["invalid_redirect_url"] as? String ?? "www.faceki3.com"
        DataManager.numberOfDoc = responseDict["number_of_doc"] as? Int ?? 1
        DataManager.successMeaasge = responseDict["success_meaasge"] as? String ?? "Process is complete check dashboard for details."
        DataManager.successRedirectUrl = responseDict["success_redirect_url"] as? String ?? "www.faceki1.com"
    }
    
}

