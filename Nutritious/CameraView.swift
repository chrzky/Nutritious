//
//  FirstViewController.swift
//  Nutritious
//
//  Created by Christian Frühauf on 11/03/16.
//  Copyright © 2016 ChristianFruhauf. All rights reserved.
//



import UIKit

import AVFoundation



class CameraView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    // Setting up the variables for the camera
    
    var captureSession : AVCaptureSession?
    
    var stillImageOutput : AVCaptureStillImageOutput?
    
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    
    var segueHelper = UploadView()
    
    
    @IBOutlet var cameraView: UIView!
    
    
    func prepareForSegue(sender: UIImage?) {
        
        let segue = UIStoryboardSegue(identifier: "sendImageSegue", source: self, destination: segueHelper)
        if (segue.identifier == "sendImageSegue") {
            if let destination = segue.destinationViewController as? UploadView {
                destination.viaSegueImage = tempImageView.image
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        prepareForSegue(tempImageView.image)
        
        
        //captureSession.decreaseSize(AVEdgeWidths.bounds)
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        previewLayer?.frame = cameraView.bounds
        
    }
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        
        // Capture session size
        
        captureSession?.sessionPreset = AVCaptureSessionPreset352x288
        
        
        
        
        
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        
        
        var error : NSError?
        
        var input: AVCaptureDeviceInput!
        
        do {
            
            input = try AVCaptureDeviceInput(device: backCamera)
            
        } catch let error1 as NSError {
            
            error = error1
            
            input = nil
            
        }
        
        
        
        if (error == nil && captureSession?.canAddInput(input) != nil) {
            
            
            
            captureSession?.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            
            stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            
            
            
            if (captureSession?.canAddOutput(stillImageOutput) != nil) {
                
                captureSession?.addOutput(stillImageOutput)
                
                // Setting up the camera stream
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                
                // Camera orientation
                
                previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                
                previewLayer?.frame = self.cameraView.layer.frame
                
                previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
                
                cameraView.layer.addSublayer(previewLayer!)
                
                captureSession?.startRunning()
                
            }
            
            
            
        }
        
        
        
    }
    
    
    
    
    @IBOutlet var tempImageView: UIImageView!
    
    /*  This function determines whether or not the user
    tapped on the screen to take a photo */
    
    func didPressToTakePhoto() {
        
        
        
        if let videoConnection = stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo) {
            
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {(samplebuffer, error) in
                
                
                
                if samplebuffer != nil {
                    
                    
                    
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(samplebuffer)
                    
                    let dataProvider = CGDataProviderCreateWithCFData(imageData)
                    
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    
                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    
                    
                    
                    self.tempImageView.image = image
                    
                    self.tempImageView.hidden = false
                    
                    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
                    
                    
                }
                
                
                
            })
            
        }
        
        
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        didPressToTakeAnother()
        
    }
    
    
    var didTakePhoto = Bool()
    
    
    
    // This eventually leads back to the camera
    
    func didPressToTakeAnother() {
        
        if  didTakePhoto == true {
            
            tempImageView.hidden = true
            
            didTakePhoto = false
            
        }   else   {
            
            captureSession?.startRunning()
            
            didTakePhoto = true
            
            didPressToTakePhoto()
            
        }
    }
    
    
}