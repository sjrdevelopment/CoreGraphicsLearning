//
//  MedalView.swift
//  CoreGraphicsLearning
//
//  Created by Stuart Robinson on 03/11/2015.
//  Copyright © 2015 Stuart Robinson. All rights reserved.
//

import UIKit

class MedalView: UIImageView {
    lazy var medalImage:UIImage = self.createMedalImage()
    
    func showMedal(show:Bool) {
        if show {
            image = medalImage
        } else {
            image = nil
        }
    }
    
    func createMedalImage() -> UIImage {
        print("creating Medal Image")
        
        let size = CGSize(width: 136, height: 200)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        //Gold colors
        let darkGoldColor = UIColor(red: 0.6, green: 0.5, blue: 0.15, alpha: 1.0)
        let midGoldColor = UIColor(red: 0.86, green: 0.73, blue: 0.3, alpha: 1.0)
        let lightGoldColor = UIColor(red: 1.0, green: 0.98, blue: 0.9, alpha: 1.0)
        
        
        //Lower Ribbon
        var lowerRibbonPath = UIBezierPath()
        lowerRibbonPath.moveToPoint(CGPointMake(0, 0))
        lowerRibbonPath.addLineToPoint(CGPointMake(60,0))
        lowerRibbonPath.addLineToPoint(CGPointMake(90, 70))
        lowerRibbonPath.addLineToPoint(CGPointMake(30, 70))
        lowerRibbonPath.closePath()
        UIColor.redColor().setFill()
        lowerRibbonPath.fill()
        
        
        
        //Clasp
        
        var claspPath = UIBezierPath(roundedRect:
            CGRectMake(16, 62, 84, 16),
            cornerRadius: 5)
        claspPath.lineWidth = 5
        darkGoldColor.setStroke()
        claspPath.stroke()
        
        
        
        //Medallion
        
        var medallionPath = UIBezierPath(ovalInRect:
            CGRect(origin: CGPointMake(8, 72),
                size: CGSizeMake(100, 100)))
        CGContextSaveGState(context)
        medallionPath.addClip()
        let gradient = CGGradientCreateWithColors(
            CGColorSpaceCreateDeviceRGB(),
            [darkGoldColor.CGColor,
                midGoldColor.CGColor,
                lightGoldColor.CGColor],
            [0, 0.51, 1])
        CGContextDrawLinearGradient(context,
            gradient,
            CGPointMake(40, 40),
            CGPointMake(100,162),
            CGGradientDrawingOptions(rawValue: 0))
        CGContextRestoreGState(context)
        
        
        //Create a transform
        //Scale it, and translate it right and down
        var transform = CGAffineTransformMakeScale(0.8, 0.8)
        transform = CGAffineTransformTranslate(transform, 15, 30)
        
        medallionPath.lineWidth = 2.0
        
        //apply the transform to the path
        medallionPath.applyTransform(transform)
        medallionPath.stroke()
        
        
        
        //Upper Ribbon
        var upperRibbonPath = UIBezierPath()
        upperRibbonPath.moveToPoint(CGPointMake(80, 0))
        upperRibbonPath.addLineToPoint(CGPointMake(140,0))
        upperRibbonPath.addLineToPoint(CGPointMake(90, 70))
        upperRibbonPath.addLineToPoint(CGPointMake(30, 70))
        upperRibbonPath.closePath()
        
        UIColor.blueColor().setFill()
        upperRibbonPath.fill()
        
        
        
        
        //Number One
        
        //Must be NSString to be able to use drawInRect()
        let numberOne = "1"
        let numberOneRect = CGRectMake(47, 100, 50, 50)
        let font = UIFont(name: "Academy Engraved LET", size: 60)
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle()
        let numberOneAttributes = [
            NSFontAttributeName: font!,
            NSForegroundColorAttributeName: darkGoldColor]
        numberOne.drawInRect(numberOneRect,
            withAttributes:numberOneAttributes)
        
        
        //Add Shadow
        CGContextBeginTransparencyLayer(context, nil)
        
        let shadow:UIColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        let shadowOffset = CGSizeMake(1.0, 3.0)
        let shadowBlurRadius: CGFloat = 12
        
        CGContextSetShadowWithColor(context,
            shadowOffset,
            shadowBlurRadius,
            shadow.CGColor)
        
        CGContextEndTransparencyLayer(context)
        
        
        //This code must always be at the end of the playground
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        
        
        UIGraphicsEndImageContext()
        
        return image
        
    }

}
