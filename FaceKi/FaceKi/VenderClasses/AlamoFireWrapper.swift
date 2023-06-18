//
//  AlamoFireWrapper.swift
//
//

import UIKit
import Alamofire
import AssetsLibrary
import Photos
import MBProgressHUD

class AlamoFireWrapper: NSObject {
    
    let customManager = Alamofire.Session.default
    let timeOutInterval:Double = 60
    
    var progressViewNib = UIView()
    
    class var sharedInstance : AlamoFireWrapper{
        struct Singleton{
            static let instance = AlamoFireWrapper()
        }
        return Singleton.instance;
    }
    
        
   
    //MARK: MULTIPART API
    func MultipartApiHit(action:String,imageData: Data?,view: UIView,param: [String:Any], withName: String, fileName: String, mimeType: String, onSuccess: @escaping(AFDataResponse<Any>) -> Void, onFailure: @escaping(Error) -> Void){

        let url : String = baseUrl + action
        print("url",url)
        print("param ",param)
        print("withName: \(withName) \nfileName: \(fileName) \nmimeType: \(mimeType)")

        let headers: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(DataManager.authorizationTokken ?? "NA")"
        ]
        print("headers ",headers)

        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in param {
                   if let temp = value as? String {
                       multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                   }
                   if let temp = value as? Int {
                       multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                   }
                   if let temp = value as? NSArray {
                       temp.forEach({ element in
                       let keyObj = key + "[]"
                       if let string = element as? String {
                           multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                       } else
                           if let num = element as? Int {
                           let value = "\(num)"
                           multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                           }
                       })
                   }
                }
                multipartFormData.append(imageData!, withName: "selfie_image" , fileName: "selfie_image.jpg", mimeType: "image/jpg")
        },
            to: url, method: .post , headers: headers)
            .responseJSON {
                (response:AFDataResponse<Any>) in
                print("response ",response)
                switch(response.result) {
                case .success( _):
//                    progressBar.progress = Float(100.0)
                    DispatchQueue.main.async {
                        self.hideProgressView()
                    }
                    onSuccess(response)
                    break
                case .failure(let error):
                    print("error==> ",error)
                    onFailure(error)
                    DispatchQueue.main.async {
                        self.hideProgressView()
                    }
                    break
                }
        }
    }
    
    
    //MARK:- Post Request
    func PostApiHit(action:String,param: [String:Any],view: UIView, onSuccess: @escaping(AFDataResponse<Any>) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseUrl + action
        print("url ",url)
//        print("param ",param)
        
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON {
            (response:AFDataResponse<Any>) in
//            print("response ",response)
            switch(response.result) {
            case .success(_):
                onSuccess(response)
                break
            case .failure(let error):
                print("error==> ",error)
                DispatchQueue.main.async {
                    CommonFunctions.dismissProgressView(view: view)
                }
                break
            }
        }
    }
    
    //MARK: MULTIPART API
    func verificationDocMultipartApiHit(action:String,imagesData: [Data?],fetchImageParamNameArray: [String],view: UIView,param: [String:Any], withName: String, fileName: String, mimeType: String, onSuccess: @escaping(AFDataResponse<Any>) -> Void, onFailure: @escaping(Error) -> Void){

        let url : String = baseUrl + action
        print("url",url)
        print("param ",param)
        print("withName: \(withName) \nfileName: \(fileName) \nmimeType: \(mimeType)")
       
        let headers: HTTPHeaders = [
            "Content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer \(DataManager.authorizationTokken ?? "NA")"
        ]
        print("headers ",headers)
        
        var imageParamNameArray = fetchImageParamNameArray
        
        AF.upload(
            multipartFormData: { multipartFormData in
                
                for imageData in imagesData {
                    let imageParamName = imageParamNameArray[0]
                    imageParamNameArray.remove(at: 0)
                    multipartFormData.append(imageData!, withName: "\(imageParamName)", fileName: "\(imageParamName).jpg", mimeType: "\(imageParamName)/jpg")
                }
                //Date().timeIntervalSince1970
               
                for (key, value) in param {
                    
                   if let temp = value as? String {
                       multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                   }
                    
                   if let temp = value as? Int {
                       multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                   }
                    
                   if let temp = value as? NSArray {
                       temp.forEach({ element in
                       let keyObj = key + "[]"
                       if let string = element as? String {
                           multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                       } else
                           if let num = element as? Int {
                           let value = "\(num)"
                           multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                           }
                       })
                   }
                                         
           }
                
        },
            to: url, method: .post , headers: headers)
            .responseJSON {
                (response:AFDataResponse<Any>) in
                print("response ",response)
                switch(response.result) {
                case .success( _):
                    DispatchQueue.main.async {
                        self.hideProgressView()
                    }
                    onSuccess(response)
                    break
                case .failure(let error):
                    print("error==> ",error)
                    onFailure(error)
                    DispatchQueue.main.async {
                        self.hideProgressView()
                    }
                    break
                }
        }
    }
    
    
     //MARK:- Normal Get Request
    func GetApiHit(action:String,view: UIView, onSuccess: @escaping(AFDataResponse<Any>) -> Void, onFailure: @escaping(Error) -> Void){
        print("action url", action)
        
        let headers: HTTPHeaders = [
            "Content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer \(DataManager.authorizationTokken ?? "NA")"
        ]
        print("headers ",headers)
        
        let strURL : String = baseUrl+action
        print("strURL ",strURL)
        let urlwithPercentEscapes = strURL.addingPercentEncoding( withAllowedCharacters: CharacterSet.urlQueryAllowed)
        print("urlwithPercentEscapes", urlwithPercentEscapes as Any)
        
        AF.request(urlwithPercentEscapes!, method: .get,
                   headers: nil).responseJSON {
            (response:AFDataResponse<Any>) in
            print("API Url", baseUrl+action)
            //                print("response GetApiHit", response)
            switch(response.result) {
            case .success(_):
                onSuccess(response)
                break
            case .failure(let error):
                print("error==> ",error)
                DispatchQueue.main.async {
                    CommonFunctions.dismissProgressView(view: view)
                    onFailure(error)
                }
                break
            }
        }
    }
    
    //Mark- to fix orientation in Image upload
    func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
    
    //Mark- to Show progress Bar
    func showProgressView(){
        let nibContents = Bundle.main.loadNibNamed("progressView", owner: nil, options: nil)
        progressViewNib = nibContents![0] as! UIView
        let progressBar = (progressViewNib.viewWithTag(1)! as! UIProgressView)
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 5)
        applicationDelegate.window?.rootViewController?.view.addSubview(progressViewNib)
        progressViewNib.center = (applicationDelegate.window?.rootViewController?.view.center)!
        progressViewNib.frame.origin.y = (applicationDelegate.window?.rootViewController?.view.frame.size.height)!-300
//        UIApplication.shared.beginIgnoringInteractionEvents()
        applicationDelegate.window?.isUserInteractionEnabled = false
    }
    
    func hideProgressView(){
        progressViewNib.removeFromSuperview()
//        UIApplication.shared.endIgnoringInteractionEvents()
        applicationDelegate.window?.isUserInteractionEnabled = true
    }
    
    //Mark- create thumbnail
    func getThumbnailFrom(path: URL) -> UIImage? {
        do {
            
            let asset = AVURLAsset(url: path , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTime.zero, actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            
            return thumbnail
            
        } catch let error {
            
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
            
        }
    }
    
}

extension UIImage {
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
}

