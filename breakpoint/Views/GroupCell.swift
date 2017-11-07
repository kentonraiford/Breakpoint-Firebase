//
//  GroupCell.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/7/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell
{
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescriptionLbl: UILabel!
    @IBOutlet weak var memberCountLbl: UILabel!
    
    func configureCell(title: String, description: String, memberCount: Int)
    {
        self.groupTitleLbl.text = title
        self.groupDescriptionLbl.text = description
        self.memberCountLbl.text = "\(memberCount) Members"
    }

}
