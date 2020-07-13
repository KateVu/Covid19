//
//  Utility.swift
//  Covid19
//
//  Created by Kate Vu (Quyen) on 5/6/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//

import UIKit
import SystemConfiguration

class Utility {
    static var errorView: UIView?
    static var noConnectionImageView: UIImageView?
    static var errorLabel: UILabel?
    static var retryButton: UIButton?
    static var currentRetryCommand: Selector?
    static var stackView: UIStackView?
    static var isErrorViewActive = false
    
 
    //
    // http://stackoverflow.com/questions/39558868/check-internet-connection-ios-10
    //
    class func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    class func topupErrorLayer(overController controller: UIViewController, errorMessage: String, retryCommand: Selector) {
        
        if errorView == nil {
            errorView = UIView()
            errorView?.backgroundColor = UIColor(white: 0.9, alpha: 1.0)

            noConnectionImageView = UIImageView(image: UIImage(named: "NoConnection"))
            noConnectionImageView?.frame = CGRect(x: 0, y: 0, width: 128, height: 128)
            noConnectionImageView?.contentMode = .scaleToFill
            
            errorLabel = UILabel()
            
            retryButton = UIButton(type: .roundedRect)
            retryButton?.setTitle("Try Again", for: .normal)
            
            stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            stackView?.axis = .vertical
            stackView?.distribution = .equalSpacing
            stackView?.alignment = .center
            stackView?.spacing = 5.0
            
            stackView?.addArrangedSubview(noConnectionImageView!)
            stackView?.addArrangedSubview(errorLabel!)
            stackView?.addArrangedSubview(retryButton!)
            
            errorView?.addSubview(stackView!)
        }
        
        if let errorView = errorView {
            // remove from super view if has
            if isErrorViewActive {
                errorView.removeFromSuperview()
            }

            errorView.frame = controller.view.bounds
            errorLabel?.text = errorMessage
            
            if currentRetryCommand != nil {
                retryButton?.removeTarget(controller, action: currentRetryCommand, for: .touchUpInside)
            }
            retryButton?.addTarget(controller, action: retryCommand, for: .touchUpInside)
            currentRetryCommand = retryCommand
            
            stackView?.center.x = errorView.frame.size.width / 2
            stackView?.center.y = errorView.frame.size.height / 2
            
            controller.view.addSubview(errorView)
            controller.view.bringSubviewToFront(errorView)
            isErrorViewActive = true
        }
    }
    
    class func removeErrorLayer(onController controller: UIViewController) {
        if isErrorViewActive {
            if let errorView = errorView {
                errorView.removeFromSuperview()
            }
            isErrorViewActive = false
        }
    }
}
