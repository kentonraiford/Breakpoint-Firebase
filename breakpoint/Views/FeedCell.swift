//
//  FeedCell.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/6/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell
{

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!

    
    func configureCell(profileImg: UIImage, email: String, content: String)
    {
        self.profileImg.image = profileImg
        self.emailLbl.text = email
        self.contentLbl.text = content
    }
    
}
