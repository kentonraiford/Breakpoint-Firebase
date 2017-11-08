//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/7/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController
{
    
    @IBOutlet weak var groupFeedTableView: UITableView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupMembersLbl: UILabel!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var sendMessageTextField: InsetTextField!
    
    var group: Group? //holds a variable of group.
    var groupMessages = [Message]() //holds all of our group messages
    
    func initData(forGroup group: Group) //initialize a group and set the value of the top variable to the value we pass in. We will then have access to all of the values.
    {
        self.group = group
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        sendBtnView.bindToKeyboard()
        groupFeedTableView.delegate = self
        groupFeedTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        groupTitleLbl.text = group?.groupTitle
        DataService.instance.getEmailsFor(group: group!, handler:
            { (returnedEmailsArray) in
                self.groupMembersLbl.text = returnedEmailsArray.joined(separator: ", ")
            })
        
        DataService.instance.REF_GROUPS.observe(.value, with:
            { (snapshot) in
                DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (returnedGroupMessages) in
                    self.groupMessages = returnedGroupMessages
                    self.groupFeedTableView.reloadData()
                    
                    if self.groupMessages.count > 0
                    {
                        self.groupFeedTableView.scrollToRow(at: IndexPath.init(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true) //Can scroll to the bottom row 
                    }
                    
                })
            })
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any)
    {
        if sendMessageTextField.text != ""
        {
            sendMessageTextField.isEnabled = false
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: sendMessageTextField.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.groupKey, sendComplete: { (complete) in
                if complete
                {
                    self.sendMessageTextField.text = "" //So we don't sedn the same message twice.
                    self.sendMessageTextField.isEnabled = true
                    self.sendBtn.isEnabled = true
                }
            })
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any)
    {
        dismissDetail()
        //dismiss(animated: true, completion: nil)
    }
}


extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupFeedCell", for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
        let message = groupMessages[indexPath.row]
        DataService.instance.getUsername(forUID: message.senderId, handler:
            { (email) in
                cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: email, content: message.content)
            })
        return cell
    }
    
    
}

