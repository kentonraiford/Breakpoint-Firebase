//
//  InsetTextField.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/5/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit

class InsetTextField: UITextField
{
    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0) // UIEInsets createsa  rectangle with a certain amount of insets around it. Padding allows us to shift the rectangle. Here we are shifting it 20 to the right.
    
    override func awakeFromNib()
    {
        setupView()
        super.awakeFromNib()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect //For when you are looking at the text in the textField without editing it. Where the text is held. The default size of the rectangle for the textfield is bounds.
    {
        return UIEdgeInsetsInsetRect(bounds, padding) //Pass in the size of the rectangle plus the padding.
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect //When you are typing text
    {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect //Where the palceholder is.
    {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    func setupView()
    {
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]) //Setup our palceholder text so it is white. We can set specific attributes because it's attributed. We unwrap placeholder because the palceholder text is there for sure.
        
        self.attributedPlaceholder = placeholder
    }
    
}
