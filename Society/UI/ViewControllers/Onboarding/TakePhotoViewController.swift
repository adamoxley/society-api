//
//  TakePhotoViewController.swift
//  Society
//
//  Created by Adam Oxley on 08/09/2019.
//  Copyright © 2019 Adam Oxley. All rights reserved.
//

import UIKit
import AVFoundation

class TakePhotoViewController: UIViewController {
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var cameraChoice: AVCaptureDevice? = nil
    var deviceInput: AVCaptureDeviceInput? = nil
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var photoPreviewImageView: UIImageView!
    
    var frontFacingCamera = true

    @IBAction func cameraFlipButtonPressed(_ sender: UIButton) {
        if frontFacingCamera {
            cameraChoice = AVCaptureDevice.DiscoverySession(
            deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],
            mediaType: AVMediaType.video,
            position: AVCaptureDevice.Position.back).devices.first
            
            frontFacingCamera = false
        } else {
            cameraChoice = AVCaptureDevice.DiscoverySession(
            deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],
            mediaType: AVMediaType.video,
            position: AVCaptureDevice.Position.front).devices.first
        }

        guard let inputDevice = cameraChoice else {
            return
        }
        
        setupCameraFeed(inputDevice: inputDevice)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Hide photo image view
        photoPreviewImageView.isHidden = true
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        cameraChoice = AVCaptureDevice.DiscoverySession(
        deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],
        mediaType: AVMediaType.video,
        position: AVCaptureDevice.Position.front).devices.first
        
        guard let inputDevice = cameraChoice else {
            return
        }
        
        setupCameraFeed(inputDevice: inputDevice)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    
    func setupCameraFeed(inputDevice: AVCaptureDevice) {
        do {
            if let inputToRemove = deviceInput {
                captureSession.removeInput(inputToRemove)
            }
            
            deviceInput = try AVCaptureDeviceInput(device: inputDevice)
            stillImageOutput = AVCapturePhotoOutput()
            
            guard let deviceInput = deviceInput else {
                return
            }
            
            if captureSession.canAddInput(deviceInput) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(deviceInput)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        } catch let error  {
            print("Error Unable to initialize camera:  \(error.localizedDescription)")
        }
    }
    
    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
            
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.previewView.bounds
            }
        }
    }
}

extension TakePhotoViewController: AVCapturePhotoCaptureDelegate {
    
    @IBAction func didTapOnTakePhotoButton(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        
        let image = UIImage(data: imageData)
        self.photoPreviewImageView.image = image
        
        // Show photo view & hide camera view
        photoPreviewImageView.isHidden = false
        previewView.isHidden = true
    }
}
