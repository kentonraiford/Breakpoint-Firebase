//
//  CreateGroupsVC.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/6/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupsVC: UIViewController
{
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var emailSearchTextField: InsetTextField!
    @IBOutlet weak var groupsTableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var addPeopleToGroupLbl: UILabel!
    
    
    var emailArray = [String]()
    var chosenUserArray = [String]() //Holds all the user we have selected from the search results.
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
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
        if titleTextField.text != "" && descriptionTextField.text != ""
        {
            DataService.instance.getIDs(forUsernames: chosenUserArray, handler:
                { (idsArray) in
                    var userIds = idsArray
                    userIds.append((Auth.auth().currentUser?.uid)!) //We won't be inside of the current group so we have to append ourselves to the group. So we need to add our UID.
                    
                    DataService.instance.createGroup(withTitle: self.titleTextField.text!, andDescription: self.descriptionTextField.text!, forUserUIDs: userIds, handler:
                        { (groupCreated) in
                            if groupCreated
                            {
                                self.dismiss(animated: true, completion: nil)
                            }
                            else
                            {
                                print("Group could not be created.")
                            }
                        })
                })
        }
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
        
        if chosenUserArray.contains(emailArray[indexPath.row])
        {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        }
        else
        {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !chosenUserArray.contains(cell.emailLbl.text!) //If it does not contain an email we have already selected. This prevents adding the same user twice.
        {
            chosenUserArray.append(cell.emailLbl.text!) //Append the cell's text to the chosenUserArray.
            addPeopleToGroupLbl.text = chosenUserArray.joined(separator: ", ") //Concatenate the values with a ", " seperator
            doneBtn.isHidden = false
        }
        else //If they aren't in the array
        {
            chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLbl.text! }) //We need to remove the selected user from the array. Return everyone who does not equal the current user who has been tapped. The temporary variable $0 is used in the filter which is similar to a for loop.
            if chosenUserArray.count >= 1 // If there is at least one person
            {
                addPeopleToGroupLbl.text = chosenUserArray.joined(separator: ", ") //Show the chosenUserArray.
            }
            else
            {
                addPeopleToGroupLbl.text = "add people to your group"
                doneBtn.isHidden = true
            }
        }
    }
}

extension CreateGroupsVC: UITextFieldDelegate
{
    
}

