//
//  TRCQRCodeViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/21/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

import ZXingObjC

class TRCQRCodeViewController: TRCBaseViewController {

    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var lblGuide: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    
    var hasScannedResult = false
    var capture = ZXCapture()
    var _captureSizeTransform = CGAffineTransform()
    var mode = String()

    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configScanCodeView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    //MARK: Config UI

    func configUI() {
        self.navigationItem.title = Localizable(value: "qr_title")

        lblGuide.labelStyle(title: Localizable(value: "guide_qr_code"), fontSize: LABEL_FONT_SIZE, isBold: false, textColor: WHITE_COLOR)
        btnCancel.buttonStyle(title: STRING_CANCEL, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: ERROR_COLOR, radius: BUTTON_RADIUS, backgroundColor: ERROR_COLOR)
        
        btnCancel.addTarget(self, action: #selector(btnCancelDidTap), for: UIControlEvents.touchUpInside)
    }
    
    //MARK: Config scan code view
    func configScanCodeView(){
        capture.delegate = self
        capture.camera = capture.back()
        capture.focusMode = .continuousAutoFocus
        capture.layer.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)

        self.view.layer.addSublayer(capture.layer)
        self.view.bringSubview(toFront: lblGuide)
        self.view.bringSubview(toFront: btnCancel)
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
        capture.layer.frame = view.bounds
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
    
    func btnCancelDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension TRCQRCodeViewController: ZXCaptureDelegate{
    func captureResult(_ capture: ZXCapture!, result: ZXResult!) {
        if (!hasScannedResult) {
            hasScannedResult = true
            capture.stop()
            DLog("result capture !!!")
            DLog(result.text)
            if ((result.text) != nil) {
                let vc = TRCQRCodeDoneViewController(nibName: "TRCQRCodeDoneViewController", bundle: nil)
                vc.mode = mode
                self.navigationController?.pushViewController(vc, animated: true)
//                let navController = UINavigationController(rootViewController: vc)
                
//                UIApplication.shared.keyWindow?.rootViewController = navController
            }
        }
    }
}
