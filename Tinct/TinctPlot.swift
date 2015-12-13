//
//  TinctPlot.swift
//  Tinct
//
//  Created by Cassius Chen on 11/11/15.
//  Copyright © 2015 Cassius Chen. All rights reserved.
//

import UIKit
import EZAudio

class TinctPlot : EZAudioPlot {
    override func setupPlot() {
        print(self.waveformLayer)
    }
    
    override func redraw() {
        var frame : EZRect = self.waveformLayer.frame
        //var path : CGPathRef = self.createPathWithPoints(self.points, pointCount: self.pointCount, inRect: frame)
        
    }
    
    override func createPathWithPoints(points: UnsafeMutablePointer<CGPoint>, pointCount: UInt32, inRect rect: EZRect) -> Unmanaged<CGPath>! {
        var path : CGMutablePathRef
        if pointCount > 0 {
            path = CGPathCreateMutable()
            
            var halfHeight = floor(rect.size.height / 2.0)
            let translateY = halfHeight + rect.origin.y
            var xf = CGAffineTransformMakeTranslation(50, 50)
            CGPathAddEllipseInRect(path, &xf, CGRectMake(0, 0, 80, 80))
            
        }
        return path
        
    }
    
    func drawCircle(points: CGPoint, pointCount: Int, inRect rect: EZRect) -> CGPathRef {
        
    }
    
}
