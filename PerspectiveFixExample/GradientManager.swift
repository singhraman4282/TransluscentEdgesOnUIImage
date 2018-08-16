//
//  GradientManager.swift
//  PerspectiveFixExample
//
//  Created by Raman Singh on 2018-08-16.
//  Copyright © 2018 Raman Singh. All rights reserved.
//

import UIKit

class GradientManager: NSObject {

    let rightImgEdges = RightImageEdges()
    let leftImgEdges = LeftImageEdges()
    let topImgEdges = TopImageEdge()
    let bottimImgEdges = BottomImageEdge()
    
    func blurEdgesOfImage(_ image:UIImage) -> UIImage {
        let firstImage = leftImgEdges.stitchWithLeftBlur(usingImage: image)
        let secondImage = rightImgEdges.stitchWithRightBlur(usingImage: firstImage)
        let thirdImage = topImgEdges.stitchWithTopBlur(usingBlurredImage: secondImage)
        let forthImage = bottimImgEdges.stitchWithBottomBlur(usingBlurredImage: thirdImage)
        
        return forthImage
    }

}

class LeftImageEdges: NSObject {
    
    var imagesArray = [UIImage]()
    
    func stitchWithLeftBlur(usingImage imageForUse:UIImage) -> UIImage {
        
        let maxHeight:CGFloat = imageForUse.size.height
        let maxWidth:CGFloat = imageForUse.size.width
        
        let finalSize = CGSize(width: maxWidth, height: maxHeight)
        
        UIGraphicsBeginImageContext(finalSize)
        
        var runningWidth: CGFloat = 0.0
        
        for index in 0..<20 {
            let cutoutFromMona:CGFloat = 1.0
            let croppedMona = imageForUse.crop(rect: CGRect(x: cutoutFromMona * CGFloat(index), y: 0, width:cutoutFromMona, height: imageForUse.size.height))
            imagesArray.append(croppedMona.alpha((CGFloat(index)/20)))
        }
        
        let remaingMonaLeft = imageForUse.crop(rect: CGRect(x: 20.0, y: 0, width: imageForUse.size.width - 20.0, height: imageForUse.size.height))
        imagesArray.append(remaingMonaLeft)
        
        for image in imagesArray {
            image.draw(in: CGRect(x: runningWidth, y: 0, width: image.size.width, height: image.size.height))
            runningWidth += image.size.width
        }
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        imagesArray = [UIImage]()
        
        return finalImage!
    }
    
}

class RightImageEdges: NSObject {
    
    var imagesArray = [UIImage]()
    
    
    func stitchWithRightBlur(usingImage imageForUse:UIImage) -> UIImage {
        
        let maxHeight:CGFloat = imageForUse.size.height
        let maxWidth:CGFloat = imageForUse.size.width
        
        let finalSize = CGSize(width: maxWidth, height: maxHeight)
        
        UIGraphicsBeginImageContext(finalSize)
        
        var runningWidth: CGFloat = 0.0
        
        let remaingMona = imageForUse.crop(rect: CGRect(x: 0, y: 0, width: imageForUse.size.width - 20.0, height: imageForUse.size.height))
        imagesArray.append(remaingMona)
        
        for index in 0..<20 {
            let cutoutFromMona:CGFloat = 1.0
            let croppedMona = imageForUse.crop(rect: CGRect(x: (imageForUse.size.width - 20) + cutoutFromMona * CGFloat(index), y: 0, width:cutoutFromMona, height: imageForUse.size.height))
            imagesArray.append(croppedMona.alpha((1.0 - CGFloat(index)/20)))
        }
        
        
        
        for image in imagesArray {
            image.draw(in: CGRect(x: runningWidth, y: 0, width: image.size.width, height: image.size.height))
            runningWidth += image.size.width
        }
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        imagesArray = [UIImage]()
        
        return finalImage!
    }
    
}

class TopImageEdge: NSObject {
    
    var imagesArray = [UIImage]()
    
    func stitchWithTopBlur(usingBlurredImage imageForUse:UIImage) -> UIImage {
        
        let maxHeight:CGFloat = imageForUse.size.height
        let maxWidth:CGFloat = imageForUse.size.width
        
        let finalSize = CGSize(width: maxWidth, height: maxHeight)
        
        for index in 0..<20 {
            let cutoutFromMona:CGFloat = 1.0
            let croppedMona = imageForUse.crop(rect: CGRect(x: 0, y: cutoutFromMona * CGFloat(index), width:imageForUse.size.width, height: cutoutFromMona))
            imagesArray.append(croppedMona.alpha((CGFloat(index)/20)))
        }
        
        UIGraphicsBeginImageContext(finalSize)
        
        var runningHeight: CGFloat = 0.0
        
        for image in imagesArray {
            image.draw(in: CGRect(x: 0, y: runningHeight, width: image.size.width, height: image.size.height))
            runningHeight += image.size.height
        }
        
        let blurredImageWithTopCroppedOff = imageForUse.crop(rect: CGRect(x: 0, y: 20, width: imageForUse.size.width, height: imageForUse.size.height - 20))
        
        blurredImageWithTopCroppedOff.draw(in: CGRect(x: 0, y: 20, width: blurredImageWithTopCroppedOff.size.width, height: blurredImageWithTopCroppedOff.size.height))
        
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        imagesArray = [UIImage]()
        return finalImage!
    }
    
}

class BottomImageEdge: NSObject {
    
    var imagesArray = [UIImage]()
    
    func stitchWithBottomBlur(usingBlurredImage imageForUse:UIImage) -> UIImage {
        
        let maxHeight:CGFloat = imageForUse.size.height - 1.0
        let maxWidth:CGFloat = imageForUse.size.width
        
        let finalSize = CGSize(width: maxWidth, height: maxHeight)
        
        for index in 0..<20 {
            let cutoutFromMona:CGFloat = 1.0
            let croppedMona = imageForUse.crop(rect: CGRect(x: 0, y: imageForUse.size.height - (cutoutFromMona * CGFloat(index) + 1), width:imageForUse.size.width, height: cutoutFromMona))
            imagesArray.append(croppedMona.alpha((CGFloat(index)/20)))
            print(((1.0 - (CGFloat(index)/20))))
        }
        
        UIGraphicsBeginImageContext(finalSize)
        
        var runningHeight:CGFloat = 1.0
        
        
        
        for image in imagesArray {
            image.draw(in: CGRect(x: 0, y: imageForUse.size.height - runningHeight, width: image.size.width, height: image.size.height))
            runningHeight += image.size.height
            print(runningHeight)
        }
        
        
        
        let blurredImageWithBottomCroppedOff = imageForUse.crop(rect: CGRect(x: 0, y: 0, width: imageForUse.size.width, height: imageForUse.size.height - 20))
        UIImageWriteToSavedPhotosAlbum(blurredImageWithBottomCroppedOff, nil, nil, nil)
        
        blurredImageWithBottomCroppedOff.draw(in: CGRect(x: 0, y: 0, width: blurredImageWithBottomCroppedOff.size.width, height: blurredImageWithBottomCroppedOff.size.height))
        
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        
        
        UIGraphicsEndImageContext()
        imagesArray = [UIImage]()
        
        return finalImage!
    }
    
}

