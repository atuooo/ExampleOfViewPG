//
//  FrameBoundsViewController.swift
//  ExViewPG
//
//  Created by Atuooo on 12/27/15.
//  Copyright © 2015 xyz. All rights reserved.
//

import UIKit

class FrameBoundsViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var frontView: UIImageView!
    
    var angle = CGFloat(0)
    var scale = CGFloat(1)
    var location = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(FrameBoundsViewController.rotate(_:)))
        view.addGestureRecognizer(rotateGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(FrameBoundsViewController.pan(_:)))
        frontView.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(FrameBoundsViewController.pinch(_:)))
        view.addGestureRecognizer(pinchGesture)
    }
    
    // MARK: - gesture action
    func rotate(_ sender: UIRotationGestureRecognizer) {
        // 对 frontView 进行 transform 操作
        let t1 = CGAffineTransform(rotationAngle: angle + sender.rotation)
        let t2 = CGAffineTransform(scaleX: scale, y: scale)
        frontView.transform = t1.concatenating(t2) // 先旋转再缩放
     
        // 将transform之后的frontView 的 frame 赋给 backView
        backView.frame = frontView.frame
        
        if sender.state == .ended {
            angle += sender.rotation
        }
    }
    
    func pinch(_ sender: UIPinchGestureRecognizer) {
        // 对 frontView 进行 transform 操作
        let t1 = CGAffineTransform(rotationAngle: angle)
        let t2 = CGAffineTransform(scaleX: scale + sender.scale - 1, y: scale + sender.scale - 1)
        frontView.transform = t1.concatenating(t2)
        
        // 将transform之后的frontView 的 frame 赋给 backView
        backView.frame = frontView.frame
        
        if sender.state == .ended {
            scale += sender.scale - 1
        }
    }
    
    func pan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            location = frontView.center
        }
        
        frontView.center = CGPoint(x: location.x + translation.x, y: location.y + translation.y)
        backView.frame = frontView.frame
    }
}
