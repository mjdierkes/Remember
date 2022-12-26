//
//  AverageColor.swift
//  Remember
//
//  Created by Mason Dierkes on 12/24/22.
//

import UIKit
import SwiftUI

struct AverageColor {
    static func get(from image: UIImage) -> UIColor {
        let inputImage = CIImage(image: image)!
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return UIColor.clear }
        guard let outputImage = filter.outputImage else { return UIColor.clear }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
    
    func getTextColor(forImageAt url: String, completion: @escaping (UIColor) -> Void) {
        let imageUrl = URL(string: url)!
        var textColor: UIColor = .black

        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let data = data {
                let image = UIImage(data: data)!
                let average = AverageColor.get(from: image)
                var red: CGFloat = 0
                var green: CGFloat = 0
                var blue: CGFloat = 0
                var alpha: CGFloat = 0

                average.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                let luminosity = 0.2126 * red + 0.7152 * green + 0.0722 * blue
                print("Luminosity", luminosity)
                if luminosity > 0.5 {
                    textColor = .black
                } else {
                    textColor = .white
                }
                completion(textColor)
            } else {
                print("Error downloading image: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
    }
}
