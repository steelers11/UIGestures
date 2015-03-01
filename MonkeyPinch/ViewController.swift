//
//  ViewController.swift
//  MonkeyPinch
//
//  Created by Michael on 2/28/15.
//  Copyright (c) 2015 Michael. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        // translation is to track how long the user holds their finger on the object
        let translation = recognizer.translationInView(self.view)
        // the 'view!.center' refernces to the image and its bounds
        recognizer.view!.center = CGPoint(x:recognizer.view!.center.x + translation.x, y:recognizer.view!.center.y + translation.y)
        // you need this line to stop the gesture from moving any longer
        recognizer.setTranslation(CGPointZero, inView: self.view)
        
        // everything after this line is for the sliding effect
        if recognizer.state == UIGestureRecognizerState.Ended {
    
            let velocity = recognizer.velocityInView(self.view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 200
            println("magnitude: \(magnitude), slide multiplier: \(slideMultiplier)")
            
            let slideFactor = 0.1 * slideMultiplier
           
            var finalPoint = CGPoint(x: recognizer.view!.center.x + (velocity.x * slideFactor),
                y: recognizer.view!.center.y + (velocity.y * slideFactor))
            
            finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
            finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
            
            UIView.animateWithDuration(Double(slideFactor * 2), delay: 0, options: UIViewAnimationOptions.CurveEaseOut,
                animations: {recognizer.view!.center = finalPoint},
                completion: nil)
            
        }
    }
}