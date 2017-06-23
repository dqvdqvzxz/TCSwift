//
//  Alert.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

private func presentViewController(alert: UIAlertController, animated flag: Bool, completion: (() -> Void)?) -> Void {
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: flag, completion: completion)
}

extension UIViewController{
    func Alert(title: String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: kAlertOk, style: .default, handler: nil)
        alert.addAction(action)
        presentViewController(alert: alert, animated: true, completion: nil)
    }
    
    func Alert2(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: kAlertOk, style: .default, handler: nil)
        alert.addAction(action)
        presentViewController(alert: alert, animated: true, completion: nil)
    }
}

extension NSError {
    func isNoInternetConnectionError() -> Bool {
        return (self.domain == NSURLErrorDomain && (self.code == NSURLErrorNotConnectedToInternet || self.code == NSURLErrorNetworkConnectionLost || self.code == NSURLErrorCannotConnectToHost));
    }
    
    func isRequestTimeOutError() -> Bool {
        return self.code == NSURLErrorTimedOut
    }
}

extension HTTPURLResponse {
    func isServerNotFound() -> Bool {
        return self.statusCode == 404
    }
    
    func isInternalError() -> Bool {
        return self.statusCode == 500
    }
}
