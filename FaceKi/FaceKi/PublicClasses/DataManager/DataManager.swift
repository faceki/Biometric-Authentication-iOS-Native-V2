//
//  DataManager.swift
//
//


import UIKit

class DataManager{
    
    static var passportDocNumber:Int? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "PassportDocNumber")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: "PassportDocNumber")
        }
    }
    
    static var declinedMessage:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "DeclinedMessage")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "DeclinedMessage")
        }
    }
    
    static var isSignIn:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "signIn")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "signIn")
        }
    }
    
//    static var declinedMessage:String? {
//        set {
//            UserDefaults.standard.setValue(newValue, forKey: "DeclinedMessage")
//            UserDefaults.standard.synchronize()
//        }
//        get {
//            return UserDefaults.standard.string(forKey: "DeclinedMessage")
//        }
//    }
    
    
    static var declinedRedirectUrl:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "DeclinedRedirectUrl")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "DeclinedRedirectUrl")
        }
    }
    
    static var docTypeOne:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "DocTypeOne")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "DocTypeOne")
        }
    }
    
    static var docTypeTwo:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "DocTypeTwo")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "DocTypeTwo")
        }
    }
    
    static var docTypeThree:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "DocTypeThree")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "DocTypeThree")
        }
    }
    
    static var invalidMeaasge:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "InvalidMeaasge")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "InvalidMeaasge")
        }
    }
    
    static var invalidRedirectUrl:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "InvalidRedirectUrl")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "InvalidRedirectUrl")
        }
    }
    
    static var numberOfDoc:Int? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "NumberOfDoc")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: "NumberOfDoc")
        }
    }
    
    static var successMeaasge:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "SuccessMeaasge")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "SuccessMeaasge")
        }
    }
    
    static var successRedirectUrl:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "SuccessRedirectUrl")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "SuccessRedirectUrl")
        }
    }
    
    static var isUserRegistered:Bool?{
        set {
            UserDefaults.standard.setValue(newValue, forKey: "IsUserRegistered")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: "IsUserRegistered")
        }
    }
    
    static var isUserLoggedIn:Bool?{
        set {
            UserDefaults.standard.setValue(newValue, forKey: IsUserLoggedIn)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: IsUserLoggedIn)
        }
    }
    
    static var isBackScanComplete:Bool?{
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isBackScanComplete")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: "isBackScanComplete")
        }
    }
    
    static var isFromtScanComplete:Bool?{
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isFromtScanComplete")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: "isFromtScanComplete")
        }
    }
    
    static var deviceTokken:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "DeviceTokenFCM")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "DeviceTokenFCM")
        }
    }
    
    static var logedUserImageString:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: LogedUserImageString)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: LogedUserImageString)
        }
    }
    
    
    static var authorizationTokken:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "AuthorizationTokken")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "AuthorizationTokken")
        }
    }

    static var userId:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "UserId")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "UserId")
        }
    }
    
    static var clientId:String {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "ClientId")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "ClientId") ?? "clientId"
        }
    }
    static var clientSecret:String {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "clientSecret")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "clientSecret") ?? ""
        }
    }
    static var confidence:Double? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "Confidence")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.double(forKey: "Confidence")
        }
    }
    
    static var email:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "Email")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "Email")
        }
    }
    
    static var faceId:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "FaceId")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "FaceId")
        }
    }
    
    static var imageId:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "ImageId")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "ImageId")
        }
    }
    
    static var mobileNumber:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "MobileNumber")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "MobileNumber")
        }
    }
    
    static var name:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "Name")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "Name")
        }
    }

    
    
    //    static var childrenArray:NSArray? {
    //        set {
    //            UserDefaults.standard.setValue(newValue, forKey: ChildrenArray)
    //            UserDefaults.standard.synchronize()
    //        }
    //        get {
    //            return UserDefaults.standard.array(forKey: ChildrenArray)! as NSArray
    //        }
    //    }
    
    
    //    static var babyId:AnyObject? {
    //        set {
    //            UserDefaults.standard.setValue(newValue, forKey: BabyId)
    //            UserDefaults.standard.synchronize()
    //        }
    //        get {
    //            return UserDefaults.standard.object(forKey: BabyId) as AnyObject
    //        }
    //    }
    
    
//    static var userType:Double? {
//        set {
//            UserDefaults.standard.setValue(newValue, forKey: UserType)
//            UserDefaults.standard.synchronize()
//        }
//        get {
//            return UserDefaults.standard.double(forKey: UserType)
//        }
//    }
    
}

