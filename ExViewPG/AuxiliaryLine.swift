//
//  ImageView.swift
//  ExViewPG
//
//  Created by Atuooo on 12/27/15.
//  Copyright © 2015 xyz. All rights reserved.
//

import UIKit

class AuxiliaryLine: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {

        let context = UIGraphicsGetCurrentContext()!
        
        let bezierRect = UIBezierPath(rect: self.bounds)
        UIColor.yellow.setStroke()
        bezierRect.lineWidth = 4
        context.saveGState()
        
        context.setLineDash(phase: 2, lengths: [4, 3])
        bezierRect.stroke()
        context.restoreGState()
    }
}
