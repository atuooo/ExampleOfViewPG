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
        imageView.image = image.resizableImage(withCapInsets: edgeInsets, resizingMode: .stretch)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(StretchableViewController.pinch(_:)))
        self.view.addGestureRecognizer(pinchGesture)
    }

    func pinch(_ sender: UIPinchGestureRecognizer) {
        imageView.frame.size = CGSize(width: 100*scale*sender.scale, height: 100)
        imageView.center = CGPoint(x: view.center.x, y: imageView.center.y)
        
        if sender.state == .ended {
            scale = sender.scale * scale
        }
    }
}
