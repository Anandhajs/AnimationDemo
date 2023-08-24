//
//  AnimateViewController.swift
//  AnimationDemo
//
//  Created by Sparkout on 24/08/23.
//

import UIKit

class AnimateViewController: UIViewController {

    @IBOutlet weak var textLabel: DWAnimatedLabel!
    @IBOutlet weak var animateView: AnimateView!
    
    @IBOutlet weak var increament: UIButton!
    @IBOutlet weak var decreament: UIButton!
    
    @IBOutlet weak var count: UILabel!
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        increament.isUserInteractionEnabled = true
        animateView.config.particle = .confetti(allowedShapes: [.circle, .triangle])
       // animateView.start()
      //  labelSwipe()
        labelAnimation()
    }
    
//    func labelSwipe() {
//        CATransaction.begin()
//
//        CATransaction.setCompletionBlock {
//            let animation = CATransition()
//            animation.duration = 1.5
//            animation.type = .push
//            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//            self.textLabel.layer.add(animation, forKey: "animation")
//            self.textLabel.text = "Initial Text"
//            self.textLabel.textColor = .orange
//        }
//        let swipeRight = CATransition()
//        swipeRight.type = .push
//        swipeRight.duration = 1.5
//        swipeRight.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//        textLabel.layer.add(swipeRight, forKey: "swipe")
//        textLabel.text = "Sliding!"
//        textLabel.textColor = .green
//      CATransaction.commit()
//    }
    
    @IBAction func plus(_ sender: Any) {
      //  count.layer.bottomAnimation(duration: 1.0)
                 counter = counter + 1
         count.text = "\(counter)"
    }
    @IBAction func minue(_ sender: Any) {
        if counter > 0 {
         //   count.layer.topAnimation(duration: 1.0)
                    counter = counter - 1
            count.text = "\(counter)"
                }
    }
    func labelAnimation() {
        textLabel.text = "Hello World"
        textLabel.animationType = .typewriter
        textLabel.placeHolderColor = .red
        textLabel.backgroundColor = .systemTeal
        textLabel.textColor = .green
                
        textLabel.startAnimation(duration: 3.0, nil)
    }
}

extension CALayer {

    func bottomAnimation(duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.duration = duration
        animation.type = .push
     //   animation.subtype = CATransitionSubtype.fromTop
        self.add(animation, forKey: "push")
    }

    func topAnimation(duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.duration = duration
        animation.type = CATransitionType.push
      //  animation.subtype = CATransitionSubtype.fromBottom
        self.add(animation, forKey: "key")
    }
}
