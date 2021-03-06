//
//  ImageFilters+Dither.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/6/21.
//

import Accelerate
import CoreGraphics

extension ImageFilters {
    public struct Dither {
        // MARK: Public Static Interface
        
        public static func apply(to image: CGImage, targetWidth: CGFloat? = nil) throws -> CGImage {
            let (imageBuffer, imageFormat) = try apply(to: image, targetWidth: targetWidth)
            
            return try imageBuffer.createCGImage(format: imageFormat)
        }
        
        public static func apply(
            to image: CGImage,
            targetWidth: CGFloat? = nil
        ) throws -> (vImage_Buffer, vImage_CGImageFormat) {
            guard image.alphaInfo == .none else {
                throw Error.willNotDitherImageWithAlphaChannel
            }
            
            // 1. Convert input into vImage buffer.
            
            let inputFormat = try makeInputImageFormat(from: image)
            let inputBuffer = try makeInputImageBuffer(from: image)
            defer {
                inputBuffer.free()
            }
            
            // 2. Convert input image buffer into standard format for processing.
            
            let processingFormat = try makeProcessingImageFormat()
            var processingImageBuffer = try makeProcessingImageBuffer(targeting: inputBuffer, in: processingFormat)
            defer {
                processingImageBuffer.free()
            }
            
            let processingConverter = try makeProcessingImageConverter(from: inputFormat, to: processingFormat)
            try convertInputImage(
                from: inputBuffer,
                toProcessingImageIn: &processingImageBuffer,
                using: processingConverter
            )
            
            // 3. Scale processing image buffer.
            
            var scaledImageBuffer = try makeScaledImageBuffer(
                targeting: processingImageBuffer,
                in: processingFormat,
                targetWidth: targetWidth
            )
            defer {
                scaledImageBuffer.free()
            }
            
            try scale(&processingImageBuffer, into: &scaledImageBuffer)
            
            // 3. Convert processing image buffer to grayscale.
            
            var grayscaleImageBuffer = try makeGrayscaleImageBuffer(targeting: scaledImageBuffer)
            defer {
                grayscaleImageBuffer.free()
            }
            
            try convertProcessingImage(from: &scaledImageBuffer, toGrayscaleImageIn: &grayscaleImageBuffer)
            
            // 4. Dither grayscale image buffer.
            
            var ditheredImageBuffer = try makeDitheredImageBuffer(targeting: grayscaleImageBuffer)
            defer {
                ditheredImageBuffer.free()
            }
            
            try convert8BitGrayscaleImage(
                from: &grayscaleImageBuffer,
                to1BitImageIn: &ditheredImageBuffer,
                usingDitheringMethod: kvImageConvert_DitherAtkinson
            )
            
            try convert1BitDitheredImage(from: &ditheredImageBuffer, backTo8BitImageIn: &grayscaleImageBuffer)
            
            // 5. Return processed image buffer and associated image format.
            
            let grayscaleImageFormat = try makeGrayscaleImageFormat()
            
            return (grayscaleImageBuffer, grayscaleImageFormat)
        }
        
        // MARK: Private Instance Interface
        
        private static func convertInputImage(
            from inputImageBuffer: vImage_Buffer,
            toProcessingImageIn processingImageBuffer: inout vImage_Buffer,
            using imageConverter: vImageConverter
        ) throws {
            do {
                try imageConverter.convert(source: inputImageBuffer, destination: &processingImageBuffer)
            } catch {
                throw Error.cannotConvertInputImageToProcessingImage(base: error)
            }
        }
        
        private static func convertProcessingImage(
            from processingImageBuffer: inout vImage_Buffer,
            toGrayscaleImageIn grayscaleImageBuffer: inout vImage_Buffer
        ) throws {
            let redCoefficient: Float = 0.2126
            let greenCoefficient: Float = 0.7152
            let blueCoefficient: Float = 0.0722
            
            let divisor: Int32 = 0x1000
            let fDivisor = Float(divisor)

            var coefficientsMatrix = [
                Int16(redCoefficient * fDivisor),
                Int16(greenCoefficient * fDivisor),
                Int16(blueCoefficient * fDivisor)
            ]
            
            let preBias: [Int16] = [0, 0, 0, 0]
            let postBias: Int32 = 0
            
            do {
                try throwableVectorImageAction {
                    vImageMatrixMultiply_ARGB8888ToPlanar8(
                        &processingImageBuffer,
                        &grayscaleImageBuffer,
                        &coefficientsMatrix,
                        divisor,
                        preBias,
                        postBias,
                        vImage_Flags(kvImageNoFlags)
                    )
                }
            } catch {
                throw Error.cannotPerformMatrixMultiplicationForGrayscale(base: error)
            }
        }
        
        private static func convert1BitDitheredImage(
            from ditheredImageBuffer: inout vImage_Buffer,
            backTo8BitImageIn originalImageBuffer: inout vImage_Buffer
        ) throws {
            do {
                try throwableVectorImageAction {
                    vImageConvert_Planar1toPlanar8(
                        &ditheredImageBuffer,
                        &originalImageBuffer,
                        vImage_Flags(kvImageNoFlags)
                    )
                }
            } catch {
                throw Error.cannotConvertDitheringImageBufferToGrayscaleImageBuffer(base: error)
            }
        }
        
        private static func convert8BitGrayscaleImage(
            from grayscaleImageBuffer: inout vImage_Buffer,
            to1BitImageIn ditheredImageBuffer: inout vImage_Buffer,
            usingDitheringMethod ditheringMethod: UInt32
        ) throws {
            do {
                try throwableVectorImageAction {
                    vImageConvert_Planar8toPlanar1(
                        &grayscaleImageBuffer,
                        &ditheredImageBuffer,
                        nil,
                        Int32(ditheringMethod),
                        vImage_Flags(kvImageNoFlags)
                    )
                }
            } catch {
                throw Error.cannotConvertGrayscaleImageBufferToDitheringImageBuffer(base: error)
            }
        }
        
        private static func makeDitheredImageBuffer(
            targeting targetImageBuffer: vImage_Buffer
        ) throws -> vImage_Buffer {
            do {
                return try vImage_Buffer(
                    width: Int(targetImageBuffer.width),
                    height: Int(targetImageBuffer.height),
                    bitsPerPixel: 1
                )
            } catch {
                throw Error.cannotCreateImageBufferForDithering(base: error)
            }
        }
        
        private static func makeGrayscaleImageBuffer(
            targeting targetImageBuffer: vImage_Buffer
        ) throws -> vImage_Buffer {
            do {
                return try vImage_Buffer(
                    width: Int(targetImageBuffer.width),
                    height: Int(targetImageBuffer.height),
                    bitsPerPixel: 8
                )
            } catch {
                throw Error.cannotCreateImageBufferForGrayscale(base: error)
            }
        }
        
        private static func makeGrayscaleImageFormat() throws -> vImage_CGImageFormat {
            guard
                let grayscaleImageFormat = vImage_CGImageFormat(
                    bitsPerComponent: 8,
                    bitsPerPixel: 8,
                    colorSpace: CGColorSpaceCreateDeviceGray(),
                    bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue),
                    renderingIntent: .defaultIntent
                )
            else {
                throw Error.cannotCreateImageFormatForGrayscale
            }
            
            return grayscaleImageFormat
        }
        
        private static func makeInputImageBuffer(from inputCGImage: CGImage) throws -> vImage_Buffer {
            do {
                return try vImage_Buffer(cgImage: inputCGImage)
            } catch {
                throw Error.cannotCreateImageBufferForInput(base: error)
            }
        }
        
        private static func makeInputImageFormat(from inputCGImage: CGImage) throws -> vImage_CGImageFormat {
            guard let inputImageFormat = vImage_CGImageFormat(cgImage: inputCGImage) else {
                throw Error.cannotCreateInputImageFormat
            }
            
            return inputImageFormat
        }
        
        private static func makeProcessingImageBuffer(
            targeting targetImageBuffer: vImage_Buffer,
            in processingFormat: vImage_CGImageFormat
        ) throws -> vImage_Buffer {
            do {
                return try vImage_Buffer(
                    width: Int(targetImageBuffer.width),
                    height: Int(targetImageBuffer.height),
                    bitsPerPixel: processingFormat.bitsPerPixel
                )
            } catch {
                throw Error.cannotCreateImageBufferForProcessing(base: error)
            }
        }
        
        private static func makeProcessingImageConverter(
            from inputFormat: vImage_CGImageFormat,
            to outputFormat: vImage_CGImageFormat
        ) throws -> vImageConverter {
            do {
                return try vImageConverter.make(
                    sourceFormat: inputFormat,
                    destinationFormat: outputFormat
                )
            } catch {
                throw Error.cannotCreateImageConverterForProcessing(base: error)
            }
        }
        
        private static func makeScaledImageBuffer(
            targeting targetImageBuffer: vImage_Buffer,
            in format: vImage_CGImageFormat,
            targetWidth: CGFloat?
        ) throws -> vImage_Buffer {
            let scale: Double = {
                guard let targetWidth = targetWidth else {
                    return 1
                }
                
                return Double(targetWidth) / Double(targetImageBuffer.width)
            }()
            let scaledWidth = Double(targetImageBuffer.width) * scale
            let scaledHeight = Double(targetImageBuffer.height) * scale
            
            do {
                return try vImage_Buffer(
                    width: Int(scaledWidth),
                    height: Int(scaledHeight),
                    bitsPerPixel: format.bitsPerPixel
                )
            } catch {
                throw Error.cannotCreateImageBufferForScaling(base: error)
            }
        }
        
        /// Creates an ARGB888 image format.
        private static func makeProcessingImageFormat() throws -> vImage_CGImageFormat {
            guard
                let processingImageFormat = vImage_CGImageFormat(
                    bitsPerComponent: 8,
                    bitsPerPixel: 32,
                    colorSpace: CGColorSpaceCreateDeviceRGB(),
                    bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.first.rawValue),
                    renderingIntent: .defaultIntent
                )
            else {
                throw Error.cannotCreateImageFormatForProcessing
            }
            
            return processingImageFormat
        }
        
        private static func scale(
            _ inputImageBuffer: inout vImage_Buffer,
            into outputImageBuffer: inout vImage_Buffer
        ) throws {
            do {
                try throwableVectorImageAction {
                    vImageScale_ARGB8888(
                        &inputImageBuffer,
                        &outputImageBuffer,
                        nil,
                        UInt32(kvImageEdgeExtend) >> UInt32(kvImageHighQualityResampling)
                    )
                }
            } catch {
                throw Error.cannotScaleProcessingImageBuffer(base: error)
            }
        }
    }
}

// MARK: - ImageFilters.Dither.Error Definition

extension ImageFilters.Dither {
    enum Error: Swift.Error {
        case cannotConvertInputImageToProcessingImage(base: Swift.Error)
        case cannotConvertDitheringImageBufferToGrayscaleImageBuffer(base: Swift.Error)
        case cannotConvertGrayscaleImageBufferToDitheringImageBuffer(base: Swift.Error)
        case cannotCreateCGImageForGrayscale(base: Swift.Error)
        case cannotCreateImageBufferForDithering(base: Swift.Error)
        case cannotCreateImageBufferForGrayscale(base: Swift.Error)
        case cannotCreateImageBufferForInput(base: Swift.Error)
        case cannotCreateImageBufferForProcessing(base: Swift.Error)
        case cannotCreateImageConverterForProcessing(base: Swift.Error)
        case cannotCreateImageBufferForScaling(base: Swift.Error)
        case cannotCreateImageFormatForGrayscale
        case cannotCreateImageFormatForProcessing
        case cannotCreateInputCGImage
        case cannotCreateInputImageFormat
        case cannotPerformMatrixMultiplicationForGrayscale(base: Swift.Error)
        case cannotScaleProcessingImageBuffer(base: Swift.Error)
        case willNotDitherImageWithAlphaChannel
    }
}
