//
//  ViewController.swift
//  PerspectiveFixExample
//
//  Created by Raman Singh on 2018-08-15.
//  Copyright © 2018 Raman Singh. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    
    
    let originalMonaLisa = #imageLiteral(resourceName: "monalisa")
    
    @IBOutlet var imageView: UIImageView!
    
    let gradientManager = GradientManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = gradientManager.blurEdgesOfImage(originalMonaLisa)

    }
    
}


extension UIImage {
    
    func crop( rect: CGRect) -> UIImage {
        var rect = rect
        rect.origin.x*=self.scale
        rect.origin.y*=self.scale
        rect.size.width*=self.scale
        rect.size.height*=self.scale
        
        let imageRef = self.cgImage!.cropping(to: rect)
        let image = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
        return image
    }
    
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
}

