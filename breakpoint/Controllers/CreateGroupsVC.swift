//
//  CreateGroupsVC.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/6/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit

class CreateGroupsVC: UIViewController
{
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var emailSearchTextField: InsetTextField!
    @IBOutlet weak var groupsTableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var addPeopleToGroupLbl: UILabel!
    
    
    var emailArray = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
        emailSearchTextField.delegate = self
        emailSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange()
    {
        if emailSearchTextField.text == ""
        {
            emailArray = []
            groupsTableView.reloadData()
        }
        else //If there is something to populate
        {
            DataService.instance.getEmail(forSearchQuery: emailSearchTextField.text!, handler:  //We are passing in all of the text from the textfield as it's being typed. We return the email array and set its value to our global emailArray variable.
                { (returnedEmailArray) in
                    self.emailArray = returnedEmailArray
                    self.groupsTableView.reloadData()
                })
        }
    }
    

    @IBAction func doneBtnWasPressed(_ sender: Any)
    {
        
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreateGroupsVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else { return UITableViewCell() }
        let profileImage = UIImage(named: "defaultProfileImage")
        
        cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        
        return cell
    }
}

extension CreateGroupsVC: UITextFieldDelegate
{
    
}

