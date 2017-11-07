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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
    }

    @IBAction func doneBtnWasPressed(_ sender: Any)
    {
        
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any)
    {
        
    }
    
}

extension CreateGroupsVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else { return UITableViewCell() }
        let profileImage = UIImage(named: "defaultProfileImage")
        
        cell.configureCell(profileImage: profileImage!, email: "rick@morty.com", isSelected: true)
        
        return cell
    }
    
    
}
