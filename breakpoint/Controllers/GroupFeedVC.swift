//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/7/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController
{
    
    @IBOutlet weak var groupFeedTableView: UITableView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupMembersLbl: UILabel!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var sendMessageTextField: InsetTextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        sendBtnView.bindToKeyboard()
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any)
    {
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
}
