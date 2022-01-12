//
//  FinalResultVC.swift
//  FaceKi
//
//  Created by Logictrix on 03/11/21.
//

import UIKit

class FinalResultVC: UIViewController {

    @IBOutlet weak var backBTn: UIButtonCustomClass!
    
    @IBOutlet weak var imageGifVw: UIView!
    
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var resulInfotLbl: UILabel!
    @IBOutlet weak var linkLbl: UILabel!
    
    var dictionaryContent = [String:Any]()
    var isSuccess = Bool()
    var errorMsg = String()
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let langStr = Locale.current.languageCode
        if langStr == "ar"{
            backBTn.setTitle("العودة إلى المنزل", for: .normal)
        }else{
            backBTn.setTitle("Back to Home", for: .normal)
        }
        
        if isSuccess == true {
            DataManager.isUserRegistered = false
            linkLbl.isHidden = true
            startLoaderGif(gifName: "24-approved-checked-outline")
            resultLbl.text = "WELCOME \(name)"
            resulInfotLbl.text = "\(DataManager.successMeaasge ?? "Process is complete check dashboard for details.")"
        }
        else {
            linkLbl.isHidden = false
            linkLbl.text = errorMsg
            startLoaderGif(gifName: "25-error-cross-outline")
            resultLbl.text = "ACCESS DENIED"
            resulInfotLbl.text = "\(DataManager.declinedMessage ?? "Process is complete check dashboard for details.")"
        }
        
        let emptyImagesArry = [UIImage]()
        CommonFunctions.archive(customObject: emptyImagesArry, keyName: "FrontScanImages")
        CommonFunctions.archive(customObject: emptyImagesArry, keyName: "BackScanImages")
    }
      
    
    @IBAction func BackToHomeAction(_ sender: Any) {
        let vc = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    func startLoaderGif(gifName: String){
        DispatchQueue.main.async {
        do {
                let gif = try UIImage(gifName: gifName)
                let imageview = UIImageView(gifImage: gif, loopCount: 3) // Will loop 3 times
                imageview.frame = self.imageGifVw.bounds
                self.imageGifVw.addSubview(imageview)
            
        } catch {
            print(error)
        }
        }
    }

}
