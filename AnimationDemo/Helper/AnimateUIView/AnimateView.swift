//
//  AnimateView.swift
//  AnimationDemo
//
//  Created by Sparkout on 24/08/23.
//

import UIKit

public class AnimateView: UIView {
    public var config = Configuration()
    var emitter: CAEmitterLayer?

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        isUserInteractionEnabled = false
    }
    /// Start animation
    public func start() {
        stop()
        
        let yOrigin: CGFloat = 0
        let yMultiplier: CGFloat = 1
        
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: bounds.width / 2, y: yOrigin)
        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterSize = CGSize(width: bounds.width, height: 1)
        emitter.renderMode = CAEmitterLayerRenderMode.additive
        
        // This combination will ensure that all color/image combinations are evenly distributed.
        // For example, if you have only one color, then we still want to make sure
        // that all "allowed" particle types are represented in the result.
        let combinations = Array<(UIColor, UIImage)>.createAllCombinations(
            from: config.colors,
            and: pickImages()
        )
        
        let beginTime = CACurrentMediaTime()
        
        let cells: [CAEmitterCell] = combinations.reduce([]) { (accum, combination) in
            let cell = CAEmitterCell()
            cell.birthRate = 5
            cell.beginTime = beginTime
            cell.lifetime = 10.0
            cell.lifetimeRange = 10
            cell.velocity = 200 * yMultiplier
            cell.velocityRange = 30
            cell.emissionLongitude = CGFloat.pi
            cell.emissionRange = CGFloat.pi * 0.2
            cell.spinRange = 5
            cell.scale = 0.3
            cell.scaleRange = 0.2
            cell.color = combination.0.cgColor
            cell.alphaSpeed = -0.1
            cell.contents = combination.1.cgImage
            cell.xAcceleration = 10
            cell.yAcceleration = 30 * yMultiplier
            cell.redRange = config.colorRange
            cell.greenRange = config.colorRange
            cell.blueRange = config.colorRange
            
            return accum + [cell]
        }
        
        emitter.emitterCells = cells
        
        config.customize?(cells)
        
        let rootLayer: CALayer? = layer
        rootLayer?.addSublayer(emitter)
        
        self.emitter = emitter
    }
    
    /// Stop animation
    public func stop() {
        emitter?.birthRate = 0
    }
    
    func pickImages() -> [UIImage] {
        let generator = ImageGenerator()
        
        switch config.particle {
        case .confetti(let allowedShapes):
            return allowedShapes
                .map { generator.confetti(shape: $0) }
                .compactMap({ $0 })
        case .image(let images):
            return images
        case .text(let size, let strings):
            return strings.compactMap({ generator.generate(size: size, string: $0) })
        }
    }
}
