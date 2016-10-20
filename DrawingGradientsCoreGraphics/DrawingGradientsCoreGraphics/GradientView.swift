//
//  GradientView.swift
//  DrawingGradientsCoreGraphics
//
//  Created by don't touch me on 10/19/16.
//  Copyright © 2016 trvl, LLC. All rights reserved.
//

import UIKit

class GradientView: UIView {

    override func draw(_ rect: CGRect) {
        
        //1 UIGraphicsGetCurrentContext gets the graphical context, this can be thought of as a canvas where can be painted on
        guard let currentContext = UIGraphicsGetCurrentContext() else { return }
        
        //2 graphical context is saved, so it can later be restored
        currentContext.saveGState()
        
        //3 CGColorSpace is a container for a range of colors. always RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        //4 difinin a start and an end color of the gradient. cgColor object is a low-level defintion of the color components. components method extracts the color components. components method extracts the color components from the cgColor object
        let startColor = UIColor.red
        guard let startColorComponents = startColor.cgColor.components else { return }
        
        let endColor = UIColor.blue
        guard let endColorComponents = endColor.cgColor.components else { return }
        
        //5 in this array, the RGB and alpha color components are written to an array
        let colorComponents: [CGFloat]
        
            = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
        
        //6 location for each color provided in components
        let locations:[CGFloat] = [0.0, 1.0]
        
        //7 CGGradient object is created containing the gradient info
        guard let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colorComponents, locations: locations,count: 2) else { return }
        
        let startPoint = CGPoint(x: 0, y: self.bounds.height)
        let endPoint = CGPoint(x: self.bounds.width, y: self.bounds.height)
        
        //8 gradient will be drawn following the vertical axis
        currentContext.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        
        //9 graphical context is restored
        currentContext.restoreGState()
        
    }


}
