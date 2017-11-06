//
//  UIViewExt.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/5/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit


extension UIView
{
    
    func bindToKeyboard()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil) //We are using a notification center to notify us whenever the keyboardWillChange function is called. The observer watches when that happens and performs an action when it does. It will obeserve whenever the keyboard goes up or down. Self, talks about the object we are observing so if we add it to a button then it will observe the button.
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) //To get this to work we need to pass in a notification, which allows us to pass in the notification. The notification that's passed in comes from the observer's selector.
    {
        
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double //We are pulling out the duration from the keyboard and setting it to our constant duration.
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt //Every animationhas a curev, ease in or ease out etc.
        
        let beginningFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue //The frame of the keyboard when it starts. We convert the NSvalue to a CGRect.
        let endFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endFrame.origin.y - beginningFrame.origin.y //Create a value for the change on the Y axis by taking the starting point which is the endframe and subtracting it from the beginning frame so we can get the value of the difference.
        
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: //Sets up key frame animations
            {
                self.frame.origin.y += deltaY //Move it up however much the keyboard moves up.
            }, completion: nil)
    }
    
}
