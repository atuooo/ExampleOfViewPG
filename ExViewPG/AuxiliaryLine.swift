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
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {

        let context = UIGraphicsGetCurrentContext()
        
        let bezierRect = UIBezierPath(rect: self.bounds)
        UIColor.yellowColor().setStroke()
        bezierRect.lineWidth = 4
        CGContextSaveGState(context)
        CGContextSetLineDash(context, 2, [4, 3], 2)
        bezierRect.stroke()
        CGContextRestoreGState(context)
    }
}
