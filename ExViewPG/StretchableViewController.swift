//
//  StretchableViewController.swift
//  ExViewPG
//
//  Created by Atuooo on 12/27/15.
//  Copyright © 2015 xyz. All rights reserved.
//

import UIKit

class StretchableViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var scale = CGFloat(1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "stretchImage")!
        let edgeInsets = UIEdgeInsetsMake(30, 30, 30, 30)
        imageView.image = image.resizableImageWithCapInsets(edgeInsets, resizingMode: .Stretch)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(StretchableViewController.pinch(_:)))
        self.view.addGestureRecognizer(pinchGesture)
    }

    func pinch(sender: UIPinchGestureRecognizer) {
        imageView.frame.size = CGSizeMake(100*scale*sender.scale, 100)
        imageView.center = CGPointMake(view.center.x, imageView.center.y)
        
        if sender.state == .Ended {
            scale = sender.scale * scale
        }
    }
}
