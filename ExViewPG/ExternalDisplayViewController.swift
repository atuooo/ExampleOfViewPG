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
        if UIScreen.screens().count > 1 {
            let extScreen = UIScreen.screens().last!
            extScreen.overscanCompensation = .None // no scaling will occur. use overscanCompensationInsets to determine the necessary insets to avoid clipping
            let screenBounds = extScreen.bounds
            
            secondWindow = UIWindow(frame: screenBounds)
            secondWindow.backgroundColor = UIColor.whiteColor()
            secondWindow.layer.borderColor = UIColor.blackColor().CGColor
            secondWindow.layer.borderWidth = 5
            secondWindow.screen = extScreen
            
            let label = UILabel(frame: CGRectMake((screenBounds.width - 300)/2, (screenBounds.height - 90)/2, 300, 90))
            label.textAlignment = .Center
            label.font = UIFont(name: "Menlo-Regular", size: 20)
            label.text = "I'm in external window"
            secondWindow.addSubview(label)
            
            secondWindow.hidden = false
            
            stateLabel.text = "Connect \n \(screenBounds)"
        }
    }
    
    func setupScreenConnectionNotificationHandlers() {
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: #selector(ExternalDisplayViewController.handleScreenConnectNotification(_:)), name: UIScreenDidConnectNotification, object: nil)
        center.addObserver(self, selector: #selector(ExternalDisplayViewController.handleScreenDisconnectNotification(_:)), name: UIScreenDidDisconnectNotification, object: nil)
    }
    
    func handleScreenConnectNotification(notification: NSNotification) {
        print("connect")
        let extScreen = notification.object as! UIScreen
        extScreen.overscanCompensation = .None // no scaling will occur. use overscanCompensationInsets to determine the necessary insets to avoid clipping
        let screenBounds = extScreen.bounds

        secondWindow = UIWindow(frame: screenBounds)
        secondWindow.backgroundColor = UIColor.whiteColor()
        secondWindow.layer.borderColor = UIColor.blackColor().CGColor
        secondWindow.layer.borderWidth = 5
        secondWindow.screen = extScreen

        let label = UILabel(frame: CGRectMake((screenBounds.width - 300)/2, (screenBounds.height - 90)/2, 300, 90))
        label.textAlignment = .Center
        label.font = UIFont(name: "Menlo-Regular", size: 20)
        label.text = "I'm in external window"
        secondWindow.addSubview(label)
        
        secondWindow.hidden = false
        
        stateLabel.text = "Connect \n \(screenBounds)"
    }
    
    func handleScreenDisconnectNotification(notification: NSNotification) {
        print("disconnect")
        secondWindow.hidden = true
//        secondWindow.removeFromSuperview()
    }
}
