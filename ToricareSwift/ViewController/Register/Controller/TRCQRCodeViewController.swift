//
//  TRCQRCodeViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/21/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

import ZXingObjC

class TRCQRCodeViewController: UIViewController {

    @IBOutlet weak var imgView: UIView!
    
    var capture = ZXCapture()
    var _captureSizeTransform = CGAffineTransform()
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        configScanCodeView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Config UI
    
    //MARK: Config scan code view
    func configScanCodeView(){
        capture.delegate = self
        capture.camera = capture.back()
        capture.focusMode = .continuousAutoFocus
        capture.layer.frame = self.view.frame
        
        self.view.layer.addSublayer(capture.layer)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: {(_ context: UIViewControllerTransitionCoordinatorContext) -> Void in
        }, completion: {(_ context: UIViewControllerTransitionCoordinatorContext) -> Void in
            self.applyOrientation()
        })
    }
    
    func applyOrientation() {
        let orientation: UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
        var scanRectRotation: Float
        var captureRotation: Float
        switch orientation {
        case .portrait:
            captureRotation = 0
            scanRectRotation = 90
        case .landscapeLeft:
            captureRotation = 90
            scanRectRotation = 180
        case .landscapeRight:
            captureRotation = 270
            scanRectRotation = 0
        case .portraitUpsideDown:
            captureRotation = 180
            scanRectRotation = 270
        default:
            captureRotation = 0
            scanRectRotation = 90
        }
        
        applyRectOfInterest(orientation)
        let transform = CGAffineTransform(rotationAngle: (CGFloat)(captureRotation / 180 * .pi))
        capture.transform = transform
        capture.rotation = CGFloat(scanRectRotation)
        capture.layer.frame = view.frame
    }
    
    
    func applyRectOfInterest(_ orientation: UIInterfaceOrientation) {
        var scaleVideo: CGFloat
        var scaleVideoX: CGFloat
        var scaleVideoY: CGFloat
        var videoSizeX: CGFloat
        var videoSizeY: CGFloat
        var transformedVideoRect: CGRect = imgView.frame
        if (capture.sessionPreset == AVCaptureSessionPreset1920x1080) {
            videoSizeX = 1080
            videoSizeY = 1920
        }else {
            videoSizeX = 720
            videoSizeY = 1280
        }
        if UIInterfaceOrientationIsPortrait(orientation) {
            scaleVideoX = view.frame.size.width / videoSizeX
            scaleVideoY = view.frame.size.height / videoSizeY
            scaleVideo = max(scaleVideoX, scaleVideoY)
            if scaleVideoX > scaleVideoY {
                transformedVideoRect.origin.y += (scaleVideo * videoSizeY - view.frame.size.height) / 2
            }else {
                transformedVideoRect.origin.x += (scaleVideo * videoSizeX - view.frame.size.width) / 2
            }
            _captureSizeTransform = CGAffineTransform(scaleX: 1 / scaleVideo, y: 1 / scaleVideo)
        }
        capture.scanRect = transformedVideoRect.applying(_captureSizeTransform)
    }
}

extension TRCQRCodeViewController: ZXCaptureDelegate{
    func captureResult(_ capture: ZXCapture!, result: ZXResult!) {
        print(result)
    }
}
