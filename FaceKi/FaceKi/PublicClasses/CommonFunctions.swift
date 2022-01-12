//
//  CommonFunctions.swift
//
//

import Foundation
import UIKit
import MBProgressHUD

class CommonFunctions: NSObject {
    
    //Get Scanning Order of doc
    class func getDocorder() -> [[String:Any]] {
        var scanDocsArray = [[String:Any]]()
        //For first Doc
        if DataManager.docTypeOne == "ID Card" {
            var dict1 = [String:Any]()
            dict1["imageName"] = "Scan ID front side"
            dict1["docName"] = "Scan ID front side"
            scanDocsArray.append(dict1)
            
            var dict2 = [String:Any]()
            dict2["imageName"] = "Scan ID back side"
            dict2["docName"] = "Scan ID back side"
            scanDocsArray.append(dict2)
        }
        if DataManager.docTypeOne == "Passport" {
            var dict3 = [String:Any]()
            dict3["imageName"] = "Scan ID front side"
            dict3["docName"] = "Scan Passport"
            scanDocsArray.append(dict3)
        }
        if DataManager.docTypeOne == "Driving License" {
            var dict4 = [String:Any]()
            dict4["imageName"] = "Scan ID front side"
            dict4["docName"] = "Scan Driving License front side"
            scanDocsArray.append(dict4)
            
            var dict5 = [String:Any]()
            dict5["imageName"] = "Scan ID back side"
            dict5["docName"] = "Scan Driving License back side"
            scanDocsArray.append(dict5)
        }
        
        
        //For Second Doc
        if DataManager.docTypeTwo == "ID Card" {
            var dict1 = [String:Any]()
            dict1["imageName"] = "Scan ID front side"
            dict1["docName"] = "Scan ID front side"
            scanDocsArray.append(dict1)
            
            var dict2 = [String:Any]()
            dict2["imageName"] = "Scan ID back side"
            dict2["docName"] = "Scan ID back side"
            scanDocsArray.append(dict2)
        }
        if DataManager.docTypeTwo == "Passport" {
            var dict3 = [String:Any]()
            dict3["imageName"] = "Scan ID front side"
            dict3["docName"] = "Scan Passport front side"
            scanDocsArray.append(dict3)
        }
        if DataManager.docTypeTwo == "Driving License" {
            var dict4 = [String:Any]()
            dict4["imageName"] = "Scan ID front side"
            dict4["docName"] = "Scan Driving License front side"
            scanDocsArray.append(dict4)
            
            var dict5 = [String:Any]()
            dict5["imageName"] = "Scan ID back side"
            dict5["docName"] = "Scan Driving License back side"
            scanDocsArray.append(dict5)
        }
        
        //For Third Doc
        if DataManager.docTypeThree == "ID Card" {
            var dict1 = [String:Any]()
            dict1["imageName"] = "Scan ID front side"
            dict1["docName"] = "Scan ID front side"
            scanDocsArray.append(dict1)
            
            var dict2 = [String:Any]()
            dict2["imageName"] = "Scan ID back side"
            dict2["docName"] = "Scan ID back side"
            scanDocsArray.append(dict2)
        }
        if DataManager.docTypeThree == "Passport" {
            var dict3 = [String:Any]()
            dict3["imageName"] = "Scan ID front side"
            dict3["docName"] = "Scan Passport front side"
            scanDocsArray.append(dict3)
            
        }
        if DataManager.docTypeThree == "Driving License" {
            var dict4 = [String:Any]()
            dict4["imageName"] = "Scan ID front side"
            dict4["docName"] = "Scan Driving License front side"
            scanDocsArray.append(dict4)
            
            var dict5 = [String:Any]()
            dict5["imageName"] = "Scan ID back side"
            dict5["docName"] = "Scan Driving License back side"
            scanDocsArray.append(dict5)
        }
        
        var dict6 = [String:Any]()
        dict6["imageName"] = "Take a selfie picture"
        dict6["docName"] = "Take a selfie picture"
        scanDocsArray.append(dict6)
        
        return scanDocsArray
    }
    
    //Get HeadTitle
    class func getHeadTitleText() -> String {
        var headTitlelbl = String()
        if numberOfScannedDoc == 0 {
            if DataManager.docTypeOne == "ID Card" {
                headTitlelbl = "Scan your ID Card"
            }
            else if DataManager.docTypeOne == "Passport" {
                headTitlelbl = "Scan your Passport"
            }
            else if DataManager.docTypeOne == "Driving License" {
                headTitlelbl = "Scan your Driving License"
            }
        }
        else if numberOfScannedDoc == 1 {
            if DataManager.docTypeTwo == "ID Card" {
                headTitlelbl = "Scan your ID Card"
            }
            else if DataManager.docTypeTwo == "Passport" {
                headTitlelbl = "Scan your Passport"
            }
            else if DataManager.docTypeTwo == "Driving License" {
                headTitlelbl = "Scan your Driving License"
            }
        }
        else if numberOfScannedDoc == 2 {
            if DataManager.docTypeThree == "ID Card" {
                headTitlelbl = "Scan your ID Card"
            }
            else if DataManager.docTypeThree == "Passport" {
                headTitlelbl = "Scan your Passport"
            }
            else if DataManager.docTypeThree == "Driving License" {
                headTitlelbl = "Scan your Driving License"
            }
        }
        return headTitlelbl
    }
    
    //get Infolable text
    class func getInfoLabelText() -> String {
        var infolbl = String()
        if numberOfScannedDoc == 0 {
            if DataManager.docTypeOne == "ID Card" {
                infolbl = "Place your ID card within the frame, and make sure it's clear with no reflections"
            }
            else if DataManager.docTypeOne == "Passport" {
                infolbl = "Place your Passport within the frame, and make sure it's clear with no reflections"
            }
            else if DataManager.docTypeOne == "Driving License" {
                infolbl = "Place your Driving License within the frame, and make sure it's clear with no reflections"
            }
        }
        else if numberOfScannedDoc == 1 {
            if DataManager.docTypeTwo == "ID Card" {
                infolbl = "Place your ID card within the frame, and make sure it's clear with no reflections"
            }
            else if DataManager.docTypeTwo == "Passport" {
                infolbl = "Place your Passport within the frame, and make sure it's clear with no reflections"
            }
            else if DataManager.docTypeTwo == "Driving License" {
                infolbl = "Place your Driving License within the frame, and make sure it's clear with no reflections"
            }
        }
        else if numberOfScannedDoc == 2 {
            if DataManager.docTypeThree == "ID Card" {
                infolbl = "Place your ID card within the frame, and make sure it's clear with no reflections"
            }
            else if DataManager.docTypeThree == "Passport" {
                infolbl = "Place your Passport within the frame, and make sure it's clear with no reflections"
            }
            else if DataManager.docTypeThree == "Driving License" {
                infolbl = "Place your Driving License within the frame, and make sure it's clear with no reflections"
            }
        }
        return infolbl
    }
    
    //Save to local
    class func saveImgDocumentDirectory(_ pic:UIImage)->String
    {
        let fileManager = FileManager.default
        let randNum = arc4random_uniform(100000)
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("hma\(randNum)")
        //        let imageData = UIImageJPEGRepresentation(pic, 0.5)
        //        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
        return paths
    }
    
    //MARK: - Show alert
    class func showAlert (_ reference:UIViewController, message:String, title:String){
        var alert = UIAlertController()
        if title == "" {
            alert = UIAlertController(title: nil, message: message,preferredStyle: UIAlertController.Style.alert)
        }
        else{
            alert = UIAlertController(title: title, message: message,preferredStyle: UIAlertController.Style.alert)
        }
        
        alert.addAction(UIAlertAction(title: Ok, style: UIAlertAction.Style.default, handler: nil))
        reference.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Show OverLay View
    class func showOverLay (_ reference:UIViewController) -> UIView {
        let OverLayView = UIView()
        OverLayView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        OverLayView.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        reference.view.addSubview(OverLayView)
        
        return OverLayView
    }
    
    //MARK: - Show OverLay View
    class func showNoDataBanner (_ reference:UIViewController,BannerMessage:String,Y_origin:CGFloat) -> UIView {
        //UIScreen.main.bounds.height/2-50
        let OverLayView = UIView()
        OverLayView.frame = CGRect(x: 0, y: Y_origin, width: UIScreen.main.bounds.width, height: 100)
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
        label.text = BannerMessage
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.black
        OverLayView.addSubview(label)
        reference.view.addSubview(OverLayView)
        
        return OverLayView
    }
    
    class func showAlert(_ reference:UIViewController, message: String?, title:String? , otherButtons:[String:((UIAlertAction)-> ())]? = nil, cancelTitle: String = "OK", cancelAction: ((UIAlertAction)-> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelAction))
        
        if otherButtons != nil {
            for key in otherButtons!.keys {
                alert.addAction(UIAlertAction(title: key, style: .default, handler: otherButtons![key]))
            }
        }
        reference.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Shadow Effect
    class func shadowEffect(_ cell:UITableViewCell){
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 5
    }
    
    class func shadowLabel(_ label:UILabel){
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize.zero
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 5
    }
    
    class func getDocumentName(name:String)->String{
        var nameStr = name
        nameStr =  nameStr.replacingOccurrences(of: "http://app.incomenda.pt/customerDocument/", with: "")
        return nameStr
    }
    
    //MARK: - ProgressIndicator view start
    class func startProgressView(view:UIView){
        // let commonView:UIView = (self.window?.rootViewController?.view!)!
        let spinnerActivity = MBProgressHUD.showAdded(to: view, animated: true);
        spinnerActivity.mode = MBProgressHUDMode.indeterminate
        spinnerActivity.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    //MARK: - ProgressIndicator View Stop
    class func dismissProgressView(view:UIView)  {
        // let commonView:UIView = (self.window?.rootViewController?.view!)!
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    //MARK:- get Target list from UserDefaults
    class func getTargetList(keyName: String) -> [UIImage] {
        var getList = [UIImage]()
        if CommonFunctions.unarchive(archivedURL: CommonFunctions.archiveURL(keyName: keyName)!) != nil {
            getList = CommonFunctions.unarchive(archivedURL: CommonFunctions.archiveURL(keyName: keyName)!)! 
//            print("listOfTarget append",getList)
        }
        return getList
    }
    
    //MARK:- Locally Save Data
    class func archiveURL(keyName: String) -> URL? {
        guard let documentURL = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
        
        return documentURL.appendingPathComponent("\(keyName).data")
    }
    
    class func archive(customObject: [UIImage], keyName: String) {
        guard let dataToBeArchived = try? NSKeyedArchiver.archivedData(withRootObject: customObject, requiringSecureCoding: true),
              let archiveURL = archiveURL(keyName: keyName)
        else  {
            return
        }
        try? dataToBeArchived.write(to: archiveURL)
    }
    
    class func unarchive(archivedURL: URL) -> [UIImage]? {
        guard let archivedData = try? Data(contentsOf: archivedURL),
              let customObject = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedData)) as? [UIImage]
        else {
            return nil
        }
        return customObject
    }
    
}
