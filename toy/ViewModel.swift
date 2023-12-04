//import Foundation
//import UIKit
//import CoreImage
//
//class TransformViewModel: ObservableObject {
//    @Published var topLeft = CGPoint(x: 50, y: 50)
//    @Published var topRight = CGPoint(x: 250, y: 50)
//    @Published var bottomLeft = CGPoint(x: 50, y: 250)
//    @Published var bottomRight = CGPoint(x: 250, y: 250)
//    let image: UIImage
//    let overlayImage: UIImage
//    @Published var transformedOverlayImage: UIImage
//
//    init(image: UIImage, overlayImage: UIImage) {
//        self.image = image
//        self.overlayImage = overlayImage
//        self.transformedOverlayImage = overlayImage // Initialize with the original overlay image
//        updateTransformedOverlayImage()
//    }
//
//    func correctedImage() -> UIImage {
//        perspectiveCorrection(image, bottomLeft, bottomRight, topRight, topLeft)
//    }
//    func updateTransformedOverlayImage() {
//        transformedOverlayImage = perspectiveTransform(overlayImage, topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
//    }
//
//  func perspectiveTransform(_ input: UIImage, topLeft: CGPoint, topRight: CGPoint, bottomLeft: CGPoint, bottomRight: CGPoint) -> UIImage {
//      guard let inputImage = CIImage(image: input) else {
//          return input
//      }
//      let context = CIContext(options: nil)
//
//      // Create a CIFilter for perspective correction
//      guard let perspectiveCorrectionFilter = CIFilter(name: "CIPerspectiveCorrection") else {
//          return input
//      }
//
//      // Convert view coordinates (used by the draggable points) to image coordinates
//      let imageSize = inputImage.extent.size
//      let convertedTopLeft = CGPoint(x: imageSize.width * (topLeft.x / UIScreen.main.bounds.width),
//                                     y: imageSize.height * (1 - topLeft.y / UIScreen.main.bounds.height))
//      let convertedTopRight = CGPoint(x: imageSize.width * (topRight.x / UIScreen.main.bounds.width),
//                                      y: imageSize.height * (1 - topRight.y / UIScreen.main.bounds.height))
//      let convertedBottomLeft = CGPoint(x: imageSize.width * (bottomLeft.x / UIScreen.main.bounds.width),
//                                        y: imageSize.height * (1 - bottomLeft.y / UIScreen.main.bounds.height))
//      let convertedBottomRight = CGPoint(x: imageSize.width * (bottomRight.x / UIScreen.main.bounds.width),
//                                         y: imageSize.height * (1 - bottomRight.y / UIScreen.main.bounds.height))
//
//      // Set the corrected points for the perspective transformation
//      perspectiveCorrectionFilter.setValue(CIVector(cgPoint: convertedTopLeft), forKey: "inputTopLeft")
//      perspectiveCorrectionFilter.setValue(CIVector(cgPoint: convertedTopRight), forKey: "inputTopRight")
//      perspectiveCorrectionFilter.setValue(CIVector(cgPoint: convertedBottomLeft), forKey: "inputBottomLeft")
//      perspectiveCorrectionFilter.setValue(CIVector(cgPoint: convertedBottomRight), forKey: "inputBottomRight")
//
//      // Apply the perspective correction filter
//      guard let correctedImage = perspectiveCorrectionFilter.outputImage else {
//          return input
//      }
//
//      // Create a CGImage from the corrected CIImage
//      guard let cgImage = context.createCGImage(correctedImage, from: correctedImage.extent) else {
//          return input
//      }
//
//      return UIImage(cgImage: cgImage)
//  }
//
//
//
//      func perspectiveCorrection(_ input : UIImage, _ bottomLeft : CGPoint, _ bottomRight : CGPoint, _ topRight : CGPoint, _ topLeft : CGPoint) -> UIImage {
//        let inputImage = CIImage(image: input)!
//        let context = CIContext()
//        let transformFilter = CIFilter(name:"CIPerspectiveCorrection")
//        transformFilter?.setValue(inputImage, forKey: kCIInputImageKey)
//        transformFilter?.setValue(CIVector(cgPoint: topLeft), forKey: "inputTopLeft")
//        transformFilter?.setValue(CIVector(cgPoint: topRight), forKey: "inputTopRight")
//        transformFilter?.setValue(CIVector(cgPoint: bottomLeft), forKey: "inputBottomLeft")
//        transformFilter?.setValue(CIVector(cgPoint: bottomRight), forKey: "inputBottomRight")
//        
//        let transformed = transformFilter?.outputImage
//        let cgOutputImage = context.createCGImage(transformed!, from: inputImage.extent)!
//        
//        return UIImage(cgImage: cgOutputImage)
//      }
//}
//
//
////
////
////
////func transformSubmission(submissionZoom: Double, templateZoom: Double, translation: (Double, Double), submission: UIImage, template: UIImage) -> UIImage {
////  // Convert UIImage to CGImage
////  let subCI = CIImage(image: submission)!
////  let context = CIContext(options: nil)
////  let subCG = context.createCGImage(subCI, from: subCI.extent)!
////  let tempCI = CIImage(image: template)!
////  let tempCG = context.createCGImage(tempCI, from: tempCI.extent)!
////  
////  let size = min(Double(subCG.width), Double(subCG.height))
////  let zoomFactor = submissionZoom / templateZoom
////  let newWidth = Int(size/zoomFactor)
////  let newHeight = Int(size/zoomFactor)
////    
////  let diffWidth = Int(size) - newWidth
////  let newX = Int(translation.0 / submissionZoom) + diffWidth/2
////  let newY = Int(translation.1 / submissionZoom) + diffWidth/2
////  print("Translation: \(translation), zoomFactor: \(zoomFactor)")
////  print("X: \(newX), Y: \(newY), width: \(newWidth), height: \(newHeight)")
////  
////  let cropRect = CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
////  
////  // Crop and convert back to UIImage
////  let transformedCG = (subCG.cropping(to: cropRect))!
////  return resizeImage(image: UIImage(cgImage: transformedCG), newWidth: CGFloat(tempCG.width))!
////}
////
////
////
////// https://stackoverflow.com/questions/20021478/add-transparent-space-around-a-uiimage
////extension UIImage {
////
////    func addImagePadding(x: CGFloat, y: CGFloat) -> UIImage? {
////        let width: CGFloat = size.width + x
////        let height: CGFloat = size.height + y
////        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
////        let origin: CGPoint = CGPoint(x: (width - size.width) / 2, y: (height - size.height) / 2)
////        draw(at: origin)
////        let imageWithPadding = UIGraphicsGetImageFromCurrentImageContext()
////        UIGraphicsEndImageContext()
////
////        return imageWithPadding
////    }
////}
////
////// https://stackoverflow.com/questions/31966885/resize-uiimage-to-200x200pt-px
////func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
////
////    let scale = newWidth / image.size.width
////    let newHeight = image.size.height * scale
////    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
////    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
////
////    let newImage = UIGraphicsGetImageFromCurrentImageContext()
////    UIGraphicsEndImageContext()
////
////    return newImage
////}
////
////
////
////
////class ThresholdFilter: CIFilter
////{
////    var inputImage : CIImage?
////    var threshold: Float = 0.1 // This is set to a good value via Otsu's method
////
////    var thresholdKernel =  CIColorKernel(source:
////        "kernel vec4 thresholdKernel(sampler image, float threshold) {" +
////        "  vec4 pixel = sample(image, samplerCoord(image));" +
////        "  const vec3 rgbToIntensity = vec3(0.114, 0.587, 0.299);" +
////        "  float intensity = dot(pixel.rgb, rgbToIntensity);" +
////        "  return intensity < threshold ? vec4(0, 0, 0, 1) : vec4(1, 1, 1, 1);" +
////        "}")
////
////    override var outputImage: CIImage! {
////        guard let inputImage = inputImage,
////            let thresholdKernel = thresholdKernel else {
////                return nil
////        }
////
////        let extent = inputImage.extent
////        let arguments : [Any] = [inputImage, threshold]
////        return thresholdKernel.apply(extent: extent, arguments: arguments)
////    }
////}
////
////extension UIImage {
////    func averageColor(withMask maskImage: UIImage) -> UIColor? {
////        guard let inputCGImage = self.cgImage, let maskCGImage = maskImage.cgImage,
////              let inputPixels = inputCGImage.dataProvider?.data,
////              let maskPixels = maskCGImage.dataProvider?.data else {
////            return nil
////        }
////
////        let inputPixelData = CFDataGetBytePtr(inputPixels)
////        let maskPixelData = CFDataGetBytePtr(maskPixels)
////
////        var totalRed = 0
////        var totalGreen = 0
////        var totalBlue = 0
////        var count = 0
////
////        let width = Int(self.size.width)
////        let height = Int(self.size.height)
////        
////        for x in 0..<width {
////            for y in 0..<height {
////                let pixelIndex = (width * y + x) * 4
////                let maskPixel = maskPixelData?[pixelIndex]
////
////                // Check if the mask pixel is black
////                if maskPixel == 0 {
////                    totalRed += Int(inputPixelData?[pixelIndex + 1] ?? 0)
////                    totalGreen += Int(inputPixelData?[pixelIndex + 2] ?? 0)
////                    totalBlue += Int(inputPixelData?[pixelIndex + 3] ?? 0)
////                    count += 1
////                }
////            }
////        }
////
////        if count == 0 { return nil }
////
////        return UIColor(
////            red: CGFloat(totalRed) / CGFloat(count) / 255.0,
////            green: CGFloat(totalGreen) / CGFloat(count) / 255.0,
////            blue: CGFloat(totalBlue) / CGFloat(count) / 255.0,
////            alpha: 1.0
////        )
////    }
////}
