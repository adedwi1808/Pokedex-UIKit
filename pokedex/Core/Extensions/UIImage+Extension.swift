//
//  UIImage+Extension.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit
import CoreImage

extension UIImage {
    func getAverageColor(completion: @escaping (UIColor?) -> Void) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let inputImage = CIImage(image: self) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            let extentVector = CIVector(x: inputImage.extent.origin.x,
                                        y: inputImage.extent.origin.y,
                                        z: inputImage.extent.size.width,
                                        w: inputImage.extent.size.height)
            
            guard let filter = CIFilter(name: "CIAreaAverage", parameters: [
                kCIInputImageKey: inputImage,
                kCIInputExtentKey: extentVector
            ]), let outputImage = filter.outputImage else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            var bitmap = [UInt8](repeating: 0, count: 4)
            let context = CIContext(options: [.workingColorSpace: kCFNull])
            
            context.render(outputImage,
                           toBitmap: &bitmap,
                           rowBytes: 4,
                           bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                           format: .RGBA8,
                           colorSpace: nil)
            
            let color = UIColor(
                red: CGFloat(bitmap[0]) / 255.0,
                green: CGFloat(bitmap[1]) / 255.0,
                blue: CGFloat(bitmap[2]) / 255.0,
                alpha: 1.0
            )
            
            DispatchQueue.main.async {
                completion(color)
            }
        }
    }
}
