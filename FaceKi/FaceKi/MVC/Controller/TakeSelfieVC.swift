//
//  TakeSelfieVC.swift
//  FaceKi
//
//  Created by Logictrix on 03/11/21.
//

import UIKit
import AVKit
import AVFoundation
import Vision

class TakeSelfieVC: BaseViewController {

    @IBOutlet weak var camView: UIView!
    
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var videoCaptureDevice: AVCaptureDevice?
    var input: AnyObject?
    
    var isFrontCameraOn = true
    var session: AVCaptureSession?
    
    lazy var previewLayer: AVCaptureVideoPreviewLayer? = {
        guard let session = self.session else { return nil }

        var previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill

        return previewLayer
    }()
    
    var frontCamera: AVCaptureDevice? = {
        return AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: .front)
    }()
    var signIn = ""
    var firstName = ""
    var lastName = ""
    var password = ""
    var email = ""
    var mobile = ""
    var dialCodeStr = ""
    var isRotation = true
    var landscape = false
    var lastOreintationOfDevice = "Portrait"
    var imageCapture = UIImage()
    
    let captureSession = AVCaptureSession()
    let movieOutput = AVCaptureMovieFileOutput()
    var activeInput: AVCaptureDeviceInput!
    
    let faceLandmarks = VNDetectFaceLandmarksRequest()
    
    var screenName = String()
    var isFaceDetect = Bool()
    
    var frontSideScanedImagesArry = [UIImage]()
    var backSideScanedImagesArry = [UIImage]()
    var isSuccess = true
    var errorMsg = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontSideScanedImagesArry.removeAll()
        frontSideScanedImagesArry = CommonFunctions.getTargetList(keyName: "FrontScanImages")
        print("frontSideScanedImagesArry append",frontSideScanedImagesArry)
        
        backSideScanedImagesArry.removeAll()
        backSideScanedImagesArry = CommonFunctions.getTargetList(keyName: "BackScanImages")
        print("backSideScanedImagesArry append",backSideScanedImagesArry)
        
        print("frontSideScanedImagesArry.count ",frontSideScanedImagesArry.count)
        print("backSideScanedImagesArry.count ",backSideScanedImagesArry.count)
        
        getUserTokenApiHit()
    }
    
    //MARK:- get User Token Api Hit
    func getUserTokenApiHit(){
        if DataManager.isSignIn == "SignIn"{
       
        }
        else{
            self.startLoaderGif(isLoaderStart: true)
        }
        ApiManager.shared.getAuthTokenApi(clientSecret: DataManager.clientSecret, clientId: DataManager.clientId,
            currentVC: self, onSuccess: { (response) in
                        print("get User Token Api Hit Response ",response)
                self.startLoaderGif(isLoaderStart: false)
            let data = response["data"] as? [String:Any] ?? [:]
            
            print("data token response",data["access_token"] ?? "")
                if let token = data["access_token"] as? String {
                    DataManager.authorizationTokken = token
                    
                }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        landscape = false
        isRotation = true
       
        DispatchQueue.main.async {
            print("View Will Appaper")
            self.startCamera(caputreMode: "Potrait")
            self.session?.startRunning()
        }
    }
    
    //MARK:- Camra Button Action
    @IBAction func camraBtnAction(_ sender: UIButton) {
        detectFaces(img: imageCapture)
    }
    
    func startCamera(caputreMode: String){
        session = AVCaptureSession()
        session?.sessionPreset = AVCaptureSession.Preset.high
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session!)
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.name = "prevVideolayer"
        var agle_Rotate = CGFloat()   ////////// for orientation of video //////
        //agle_Rotate = degreeToRadian(0)
        lastOreintationOfDevice = caputreMode
            if caputreMode == "LandscapeLeft" {
                agle_Rotate = degreeToRadian(-90)
            }
            else if caputreMode == "LandscapeRight" {
                agle_Rotate = degreeToRadian(90)
            }
            else  {
                agle_Rotate = degreeToRadian(0)
            }
        let affineTransform = CGAffineTransform(rotationAngle: agle_Rotate)
        previewLayer?.setAffineTransform(affineTransform)  ////////// for orientation of video //////
    
        if landscape == false {
            previewLayer?.frame = camView.layer.bounds
        }
        else if landscape == true {
//            previewLayer?.frame = self.view.layer.bounds
            previewLayer?.frame = camView.layer.bounds
        }
        camView.layer.addSublayer(previewLayer!)
        
       if isFrontCameraOn == true {
          self.videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera,for: .video, position: .front)
        }
        else {
           self.videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera,for: .video, position: .back)
        }
        
        do {
            let deviceInput = try AVCaptureDeviceInput(device: self.videoCaptureDevice!)
            session?.beginConfiguration()
            
            if (session?.canAddInput(deviceInput))! {
                session?.addInput(deviceInput)
            }
            
            let output = AVCaptureVideoDataOutput()
            output.videoSettings = [
                String(kCVPixelBufferPixelFormatTypeKey) : Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)
            ]
            output.alwaysDiscardsLateVideoFrames = true
            if (session?.canAddOutput(output))! {
                session?.addOutput(output)
            }
            
            session?.commitConfiguration()
            let queue = DispatchQueue(label: "output1.queue")
            output.setSampleBufferDelegate(self, queue: queue)
            print("setup delegate")
            
        }
        catch {
            print("video device error")
        }
    }
    
    func degreeToRadian(_ x: CGFloat) -> CGFloat {
        return .pi * x / 180.0
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
                    let vc = Storyboard.instantiateViewController(withIdentifier: "FinalResultVC") as! FinalResultVC
//                    vc.dictionaryContent = dictionaryContent
                    vc.isSuccess = self.isSuccess
                    vc.errorMsg = self.errorMsg
                    DataManager.isSignIn = ""
                    vc.name = firstName
                    self.navigationController?.pushViewController(vc, animated: true)
//
//                    let vc = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
////                    vc.screenName = "Register"
//                    DataManager.isSignIn = ""
//                    self.navigationController?.pushViewController(vc, animated: true)
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
    
}

//MARK:- for output of camera
extension TakeSelfieVC: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let attachments = CMCopyDictionaryOfAttachments(allocator: kCFAllocatorDefault, target: sampleBuffer, attachmentMode: kCMAttachmentMode_ShouldPropagate)
        let ciImage = CIImage(cvImageBuffer: pixelBuffer!, options: attachments as! [CIImageOption : Any]?)
        
        //leftMirrored for front camera
        let ciImageWithOrientation = ciImage.oriented(forExifOrientation: Int32(UIImage.Orientation.leftMirrored.rawValue))
        
        var image = UIImage()
        if lastOreintationOfDevice == "LandscapeLeft" {
            image = convert(cmage:ciImage)
        }
        else if lastOreintationOfDevice == "LandscapeRight" {
            image = convert(cmage: ciImage.oriented(forExifOrientation: Int32(UIImage.Orientation.right.rawValue)))
        }
        else {
            image = convert(cmage:ciImageWithOrientation)
        }
        
        DispatchQueue.main.async {
//            self.headImag.image = image
        }
        imageCapture = image
//        detectFaces(img: image)
    }
    
    //MARK:- Coverting CGImage into UIImage
    func convert(cmage:CIImage) -> UIImage    {
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
    
    func detectFaces(img: UIImage){
        // Create Face Detection Request
        let request = VNDetectFaceRectanglesRequest { (req, err)
            in
            if let err = err{
                print("Failed to detect faces !! \(err)")
                return
            }
            else {

                DispatchQueue.main.async {
                    self.camView.subviews.forEach({ (subview) in
                        
                        if self.camView.subviews.contains(subview) {
                            subview.removeFromSuperview() // Remove it
                        } else {
                            // Do Nothing
                        }
                        
                    })
                }
                
                if let landmarksResults = self.faceLandmarks.results as? [VNFaceObservation] {
                guard landmarksResults.first != nil else {return}
            }
         }
            req.results?.forEach({ (res) in
                // Get face observations
                guard let faceObservation = res as? VNFaceObservation else {return}
               
                DispatchQueue.main.async {
            
                    self.setCropField(img: img, originX: faceObservation.boundingBox.origin.x, originY: faceObservation.boundingBox.origin.y, rectHeight: faceObservation.boundingBox.height, rectWidth: faceObservation.boundingBox.width)
                }
            })
        }
        
        // Convert Image to cgImage and pass to request handler
        let cgImage = img.cgImage
        let handler = VNImageRequestHandler(cgImage: cgImage!, options: [:])
        
        // Perform vision request
        do{
            try handler.perform([request])
           // print("[request]:=> ",[request])
        }
        catch let reqErr{
            print("Failed to perform request: \(reqErr)")
        }
  }
    
    func navigateToScreen(cropedImage: UIImage){
        if DataManager.isSignIn == "SignIn"{
            var imagesData = Data()
            if let imageDataFaceImage = cropedImage.jpeg(.medium) {
                imagesData = imageDataFaceImage
            }
            self.startLoaderGif(isLoaderStart: true)
            self.registerUserApiHit(imageData: imagesData, email: self.email, password: self.password, mobile: self.mobile,  firstName:self.firstName,lastName:self.lastName, fileName: "", mimeType: "")
        }
        else{
        self.loginUserApiHit(userImage: cropedImage)
        }
    }
    
    // func cropImage(screenshot: UIImage, vw: CGRect) -> UIImage {
    func cropImage(screenshot: UIImage, originX: CGFloat, originY: CGFloat, getWidth: CGFloat, getHeight: CGFloat) -> UIImage {
        let cgimage = screenshot.cgImage!
        print("x", originX)
        print("y", originY)
        print("height", getWidth)
        print("width", getHeight)
        
        let width = getWidth * CGFloat(cgimage.width)
        let height = getHeight * CGFloat(cgimage.height)
        let x = originX * CGFloat(cgimage.width)
        let y = (1 - originY) * CGFloat(cgimage.height) - height
        
        let croppingRect = CGRect(x: x-20, y: y-50, width: width+50, height: height+60)
        let faceImage = cgimage.cropping(to: croppingRect)
        let image: UIImage = UIImage(cgImage: faceImage!)
        
        return image
    }
    
    func setCropField(img: UIImage, originX: CGFloat, originY: CGFloat, rectHeight: CGFloat, rectWidth: CGFloat){
        session?.stopRunning()
            var cropImag = UIImage()
            cropImag = cropImage(screenshot: img, originX: originX, originY: originY, getWidth: rectWidth, getHeight: rectHeight)
            print("cropImag :==>> ",cropImag)
//        navigateToScreen(cropedImage: cropImag)
        navigateToScreen(cropedImage: img)
    }
    
    //MARK:- login User Api Hit
    func loginUserApiHit(userImage: UIImage){
        self.isSuccess = true
        let params:[String: Any] = ["selfie_image": "selfie_image.jpg"]
        startLoaderGif(isLoaderStart: true)
        
        var imagesData = Data()
        if let imageDataFaceImage = userImage.jpeg(.medium) {
            imagesData = imageDataFaceImage
        }
        
//        CommonFunctions.startProgressView(view: self.view)
        AlamoFireWrapper.sharedInstance.MultipartApiHit(action: logInUrl, imageData: imagesData, view: self.view, param: params, withName: "selfie_image", fileName: "", mimeType: "", onSuccess: { (response) in
            self.startLoaderGif(isLoaderStart: false)
//            CommonFunctions.dismissProgressView(view: self.view)
            switch(response.result) {
            case .success(let value):
                //                print("value = ",value)
                let  dictionaryContent = value as? [String:Any] ?? [:]
                print("login User Api Hit Response ",dictionaryContent)
                self.startLoaderGif(isLoaderStart: false)
                
                self.isSuccess = true
                let statusCode = dictionaryContent["responseCode"] as? Int ?? -1
                let data = dictionaryContent["data"] as? [String:Any] ?? [:]
                let isLogdedIn = data["logedIn"] as? Bool ?? false

                if  statusCode != 0 ||  isLogdedIn == false {
                    self.isSuccess = false

                   let message = dictionaryContent["message"] as? String ?? ""
                    if message == "Image quality is not good, Make sure you are under proper lights, Try again!!" {
                        self.showAlert(message: message)
                    }
                    else {
                      
                        let vc = Storyboard.instantiateViewController(withIdentifier: "RegisterUserVC") as! RegisterUserVC
                        vc.userImage = userImage
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                }

                if self.isSuccess == true {
                    let userDict = data["user"] as? [String:Any] ?? [:]
                    
                    let vc = Storyboard.instantiateViewController(withIdentifier: "FinalResultVC") as! FinalResultVC
                    vc.dictionaryContent = dictionaryContent
                    vc.isSuccess = self.isSuccess
                    vc.errorMsg = self.errorMsg
                    vc.name = userDict["name"] as? String ?? ""
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
            //self.performSegueToReturnBack()
            DispatchQueue.main.async {
                self.startCamera(caputreMode: "Potrait")
                self.session?.startRunning()
            }
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}


class CustomOval: UIView {

    override func draw(_ rect: CGRect) {
        let ovalPath = UIBezierPath(ovalIn: rect)
        UIColor.clear.setFill()
        ovalPath.fill()
    }
}
