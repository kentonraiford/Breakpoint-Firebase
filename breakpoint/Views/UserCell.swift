//
//  UserCell.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/6/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell //The tableViewcell inside og the CreateGroupsVC
{

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkMarkImg: UIImageView!
    
    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool)
    {
        self.profileImg.image = image
        self.emailLbl.text = email
        if isSelected //If it is hidden, unhide the check mark.
        {
            self.checkMarkImg.isHidden = false
        }
        else
        {
            self.checkMarkImg.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) // Configure the view for the selected state
    {
        super.setSelected(selected, animated: animated)

        
    }

}
