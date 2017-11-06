//
//  ShadowView.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/5/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit

class ShadowView: UIView
{

    override func awakeFromNib()
    {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = #colorLiteral(red: 0.6212110519, green: 0.8334299922, blue: 0.3770503998, alpha: 1)
        super.awakeFromNib()
    }

}
