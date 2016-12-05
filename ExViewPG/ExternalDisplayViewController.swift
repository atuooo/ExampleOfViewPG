//
//  ExternalDisplayViewController.swift
//  ExViewPG
//
//  Created by Atuooo on 12/27/15.
//  Copyright © 2015 xyz. All rights reserved.
//

import UIKit

class ExternalDisplayViewController: UIViewController {

    @IBOutlet weak var stateLabel: UILabel!
    var secondWindow = UIWindow()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreenConnectionNotificationHandlers()
        checkForExistingScreenAndInitializeIfPresent()
        // Do any additional setup after loading the view.
    }
    
    func checkForExistingScreenAndInitializeIfPresent() {
        if UIScreen.screens.count > 1 {
            let extScreen = UIScreen.screens.last!
            extScreen.overscanCompensation = .none // no scaling will occur. use overscanCompensationInsets to determine the necessary insets to avoid clipping
            let screenBounds = extScreen.bounds
            
            secondWindow = UIWindow(frame: screenBounds)
            secondWindow.backgroundColor = UIColor.white
            secondWindow.layer.borderColor = UIColor.black.cgColor
            secondWindow.layer.borderWidth = 5
            secondWindow.screen = extScreen
            
            let label = UILabel(frame: CGRect(x: (screenBounds.width - 300)/2, y: (screenBounds.height - 90)/2, width: 300, height: 90))
            label.textAlignment = .center
            label.font = UIFont(name: "Menlo-Regular", size: 20)
            label.text = "I'm in external window"
            secondWindow.addSubview(label)
            
            secondWindow.isHidden = false
            
            stateLabel.text = "Connect \n \(screenBounds)"
        }
    }
    
    func setupScreenConnectionNotificationHandlers() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(ExternalDisplayViewController.handleScreenConnectNotification(_:)), name: NSNotification.Name.UIScreenDidConnect, object: nil)
        center.addObserver(self, selector: #selector(ExternalDisplayViewController.handleScreenDisconnectNotification(_:)), name: NSNotification.Name.UIScreenDidDisconnect, object: nil)
    }
    
    func handleScreenConnectNotification(_ notification: Notification) {
        print("connect")
        let extScreen = notification.object as! UIScreen
        extScreen.overscanCompensation = .none // no scaling will occur. use overscanCompensationInsets to determine the necessary insets to avoid clipping
        let screenBounds = extScreen.bounds

        secondWindow = UIWindow(frame: screenBounds)
        secondWindow.backgroundColor = UIColor.white
        secondWindow.layer.borderColor = UIColor.black.cgColor
        secondWindow.layer.borderWidth = 5
        secondWindow.screen = extScreen

        let label = UILabel(frame: CGRect(x: (screenBounds.width - 300)/2, y: (screenBounds.height - 90)/2, width: 300, height: 90))
        label.textAlignment = .center
        label.font = UIFont(name: "Menlo-Regular", size: 20)
        label.text = "I'm in external window"
        secondWindow.addSubview(label)
        
        secondWindow.isHidden = false
        
        stateLabel.text = "Connect \n \(screenBounds)"
    }
    
    func handleScreenDisconnectNotification(_ notification: Notification) {
        print("disconnect")
        secondWindow.isHidden = true
//        secondWindow.removeFromSuperview()
    }
}
