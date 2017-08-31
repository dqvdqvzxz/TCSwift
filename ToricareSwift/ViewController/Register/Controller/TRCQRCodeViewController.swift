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

    @IBOutlet var leftBarView: UIView!
    @IBOutlet weak var leftBarLabel: UILabel!
    @IBOutlet weak var centerBlankView: UIView!
    @IBOutlet weak var topBlankView: UIView!
    @IBOutlet weak var bottomBlankView: UIView!
    @IBOutlet weak var leftBlankView: UIView!
    @IBOutlet weak var rightBlankView: UIView!
    
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
        
        _obj.tabController.tabBar.isHidden = true
    }
    
    //MARK: Config UI
    func configUI() {
        self.navigationItem.title = Localizable(value: "qr_title")
        
        _obj.tabController.tabBar.isHidden = true
        
        self.navigationItem.hidesBackButton = true
        
        leftBarLabel.labelStyle(title: Localizable(value: "back_qr"), fontSize: LABEL_FONT_SIZE, isBold: false, textColor: MAIN_COLOR)
        
        let leftBarButton = UIBarButtonItem(customView: leftBarView)
        let leftTap = UITapGestureRecognizer(target: self, action: #selector(close))
        leftBarView.addGestureRecognizer(leftTap)
        leftBarView.isUserInteractionEnabled = true
        
        self.navigationItem.leftBarButtonItem = leftBarButton
        lblGuide.labelStyle(title: Localizable(value: "guide_qr_code"), fontSize: LABEL_FONT_SIZE, isBold: false, textColor: WHITE_COLOR)
        btnCancel.buttonStyle(title: STRING_CANCEL, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: ERROR_COLOR, radius: BUTTON_RADIUS, backgroundColor: ERROR_COLOR)
        
        btnCancel.addTarget(self, action: #selector(btnCancelDidTap), for: UIControlEvents.touchUpInside)
    }
    
    //MARK: Action
    func close() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func bringViewUp() {
        topBlankView.isHidden = false
        bottomBlankView.isHidden = false
        leftBlankView.isHidden = false
        rightBlankView.isHidden = false

        self.view.bringSubview(toFront: topBlankView)
        self.view.bringSubview(toFront: bottomBlankView)
        self.view.bringSubview(toFront: leftBlankView)
        self.view.bringSubview(toFront: rightBlankView)
        self.view.bringSubview(toFront: self.lblGuide)
        self.view.bringSubview(toFront: self.btnCancel)
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
                self.bringViewUp()
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
        self.showHUD()
        TRCQRRequest().sendQR(qrString, completion: { (data) in
            self.hideHUD()
            if (_obj.objectAccountInfo != nil) {
                _obj.objectAccountInfo.shopStatus = REGISTER_TRUE
            }
            let vc = TRCQRCodeDoneViewController(nibName: "TRCQRCodeDoneViewController", bundle: nil)
            vc.mode = self.mode
            self.navigationController?.pushViewController(vc, animated: true)
        }) { (error) in
            self.hideHUD()
            self.showQRAlert()
        }
    }
    
    func showQRAlert() {
        let alert = UIAlertController(title: Localizable(value: "error"),
                                      message: Localizable(value: "qr_code_not_match"),
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        // add the action
        alert.addAction(UIAlertAction(title: Localizable(value: "OK"),
                                      style: UIAlertActionStyle.default,
                                      handler: { action in
                                        self.hasScannedResult = false
                                        self.capture.start()
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
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
                self.sendQRString(result.text)
            }
        }
    }
}
