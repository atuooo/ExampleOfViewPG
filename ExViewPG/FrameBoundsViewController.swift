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
    var location = CGPointZero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: "rotate:")
        view.addGestureRecognizer(rotateGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: "pan:")
        frontView.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: "pinch:")
        view.addGestureRecognizer(pinchGesture)
    }
    
    // MARK: - gesture action
    func rotate(sender: UIRotationGestureRecognizer) {
        // 对 frontView 进行 transform 操作
        let t1 = CGAffineTransformMakeRotation(angle + sender.rotation)
        let t2 = CGAffineTransformMakeScale(scale, scale)
        frontView.transform = CGAffineTransformConcat(t1, t2) // 先旋转再缩放
     
        // 将transform之后的frontView 的 frame 赋给 backView
        backView.frame = frontView.frame
        
        if sender.state == .Ended {
            angle += sender.rotation
        }
    }
    
    func pinch(sender: UIPinchGestureRecognizer) {
        // 对 frontView 进行 transform 操作
        let t1 = CGAffineTransformMakeRotation(angle)
        let t2 = CGAffineTransformMakeScale(scale + sender.scale - 1, scale + sender.scale - 1)
        frontView.transform = CGAffineTransformConcat(t1, t2)
        
        // 将transform之后的frontView 的 frame 赋给 backView
        backView.frame = frontView.frame
        
        if sender.state == .Ended {
            scale += sender.scale - 1
        }
    }
    
    func pan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        if sender.state == .Began {
            location = frontView.center
        }
        
        frontView.center = CGPoint(x: location.x + translation.x, y: location.y + translation.y)
        backView.frame = frontView.frame
    }
}
