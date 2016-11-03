//
//  imageController.swift
//  EcoTouch.iOS.UI
//
//  Created by Eco on 11/4/15.
//  Copyright © 2015 Grupo Eco. All rights reserved.
//

import UIKit

public class imageController{
    
    // tsss te lo choteaste del ecoTOCH
    
    public static func imageResize (imageObj:UIImage)-> UIImage{
        let size = imageObj.size.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))
        
        let hasAlpha = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        imageObj.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
    
    public static func resizeSignature(image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage {
        //let scale = newWidth / image.size.width
        //let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth,height: newHeight))
        image.draw(in:  CGRect(x: 0,y: 0, width:newWidth,height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    // public static func ToBase64(image: UIImage) -> String {
    //     let imageData = UIImageJPEGRepresentation(image, 0.5)
    //     //(.Encoding64CharacterLineLength)
    //     return imageBase64
    // }
    //
    // public static func ResizePhoto(image: UIImage) -> UIImage {
    //     let kMaxResolution = CGFloat(320)
    //
    //     //CGImageRef
    //     let imgRef = image.cgImage
    //
    //     let width = CGFloat(imgRef!.width)
    //     let height = CGFloat(imgRef!.height)
    //
    //     //CGAffineTransform
    //     var transform = CGAffineTransform.identity  ;
    //
    //     var bounds = CGRect(x:0,y: 0,width: width,height: height)
    //     if (width > kMaxResolution || height > kMaxResolution) {
    //         //CGFloat
    //         let ratio = width/height;
    //         if (ratio > 1) {
    //             bounds.size.width = kMaxResolution;
    //             bounds.size.height = bounds.size.width / ratio
    //         }
    //         else {
    //             bounds.size.height = kMaxResolution;
    //             bounds.size.width = bounds.size.height * ratio
    //         }
    //     }
    //
    //     let scaleRatio = CGFloat(bounds.size.width / width)
    //     //CGSize
    //     let imageSize = CGSize(width: CGFloat(imgRef!.width),height:  CGFloat(imgRef!.height))
    //     var boundHeight: CGFloat
    //     //UIImageOrientation
    //     let orient = image.imageOrientation;
    //     switch(orient) {
    //
    //
    //     case .up: //EXIF = 1
    //         transform = CGAffineTransform.identity;
    //         break;
    //
    //     case .upMirrored: //EXIF = 2
    //         transform =   CGAffineTransform(translationX: imageSize.width, y: 0.0);
    //         transform = transform.scaledBy(x: -1.0, y: 1.0);
    //         break;
    //
    //     case .down: //EXIF = 3
    //         transform = CGAffineTransform(translationX: imageSize.width, y: imageSize.height);
    //         transform = transform.rotated(by: CGFloat(M_PI));
    //         break;
    //
    //     case .downMirrored: //EXIF = 4
    //         transform = CGAffineTransform(translationX: 0.0, y: imageSize.height);
    //         transform = transform.scaledBy(x: 1.0, y: -1.0);
    //         break;
    //
    //     case .leftMirrored: //EXIF = 5
    //         boundHeight = bounds.size.height;
    //         bounds.size.height = bounds.size.width;
    //         bounds.size.width = boundHeight;
    //         transform = CGAffineTransform(translationX: imageSize.height, y: imageSize.width);
    //         transform = transform.scaledBy(x: -1.0, y: 1.0);
    //         transform = transform.rotated(by: 3.0 * CGFloat(M_PI) / 2.0);
    //         break;
    //
    //     case .left: //EXIF = 6
    //         boundHeight = bounds.size.height;
    //         bounds.size.height = bounds.size.width;
    //         bounds.size.width = boundHeight;
    //         transform = CGAffineTransform(translationX: 0.0, y: imageSize.width);
    //         transform = transform.rotated(by: 3.0 * CGFloat(M_PI) / 2.0);
    //         break;
    //
    //     case .rightMirrored: //EXIF = 7
    //         boundHeight = bounds.size.height;
    //         bounds.size.height = bounds.size.width;
    //         bounds.size.width = boundHeight;
    //         transform = CGAffineTransform(scaleX: -1.0, y: 1.0);
    //         transform = transform.rotated(by: CGFloat(M_PI) / 2.0);
    //         break;
    //
    //     case .right: //EXIF = 8
    //         boundHeight = bounds.size.height;
    //         bounds.size.height = bounds.size.width;
    //         bounds.size.width = boundHeight;
    //         transform = CGAffineTransform(translationX: imageSize.height, y: 0.0);
    //         transform = transform.rotated(by: CGFloat(M_PI) / 2.0);
    //         break;
    //     }
    //
    //     UIGraphicsBeginImageContext(bounds.size);
    //
    //     //CGContextRef
    //     let context = UIGraphicsGetCurrentContext();
    //
    //     if (orient == .Right || orient == .left) {
    //         context!.scaleBy(x: -scaleRatio, y: scaleRatio);
    //         context!.translateBy(x: -height, y: 0);
    //     }
    //     else {
    //         context!.scaleBy(x: scaleRatio, y: -scaleRatio);
    //         context!.translateBy(x: 0, y: -height);
    //     }
    //
    //     context!.concatenate(transform);
    //
    //     draw(UIGraphicsGetCurrentContext()!, CGRect(x:0, y:0,width: width, height:height), imgRef!);
    //     //UIImage *
    //     let imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    //     UIGraphicsEndImageContext();
    //
    //     return imageCopy!;
    //
    // }
    //
    // extension UIImage{
    //    public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
    //        //        let radiansToDegrees: (CGFloat) -> CGFloat = {
    //        //            return $0 * (180.0 / CGFloat(M_PI))
    //        //        }
    //        let degreesToRadians: (CGFloat) -> CGFloat = {
    //            return $0 / 180.0 * CGFloat(M_PI)
    //        }
    //
    //        // calculate the size of the rotated view's containing box for our drawing space
    //        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
    //        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
    //        rotatedViewBox.transform = t
    //        let rotatedSize = rotatedViewBox.frame.size
    //
    //        // Create the bitmap context
    //        UIGraphicsBeginImageContext(rotatedSize)
    //        let bitmap = UIGraphicsGetCurrentContext()
    //
    //        // Move the origin to the middle of the image so we will rotate and scale around the center.
    //        bitmap!.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0);
    //
    //        //   // Rotate the image context
    //        bitmap!.rotate(by: degreesToRadians(degrees));
    //
    //        // Now, draw the rotated/scaled image into the context
    //        var yFlip: CGFloat
    //
    //        if(flip){
    //            yFlip = CGFloat(-1.0)
    //        } else {
    //            yFlip = CGFloat(1.0)
    //        }
    //        
    //        bitmap!.scaleBy(x: yFlip, y: -1.0)
    //        CGContextDrawImage(bitmap!, CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height), CGImage!)
    //        
    //        let newImage = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //        
    //        return newImage!
    //    }
    // }
    //
    // extension UIColor {
    //    convenience init(hex: Int, alpha: Double = 1.0) {
    //        self.init(red: CGFloat((hex>>16)&0xFF)/255.0, green: CGFloat((hex>>8)&0xFF)/255.0, blue: CGFloat((hex)&0xFF)/255.0, alpha: CGFloat(255 * alpha) / 255)
    //    }
}
