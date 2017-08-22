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

    @IBOutlet weak var lblGuide: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    
    var hasScannedResult = false
    var capture = ZXCapture()
    var _captureSizeTransform = CGAffineTransform()
    var mode = String()

    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showHUD()
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
        DispatchQueue.global(qos: .userInitiated).async { // 1
            self.capture.delegate = self
            self.capture.camera = self.capture.back()
            self.capture.focusMode = .continuousAutoFocus
            DispatchQueue.main.async { // 2
                self.capture.layer.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
                self.view.layer.addSublayer(self.capture.layer)
                self.view.bringSubview(toFront: self.lblGuide)
                self.view.bringSubview(toFront: self.btnCancel)
                self.hideHUD()
            }
        }
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
        
        let transform = CGAffineTransform(rotationAngle: (CGFloat)(captureRotation / 180 * .pi))
        capture.transform = transform
        capture.rotation = CGFloat(scanRectRotation)
        capture.layer.frame = view.bounds
    }
    
    func btnCancelDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func sendQRString(_ qrString: String) {
        
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
            }
        }
    }
}
