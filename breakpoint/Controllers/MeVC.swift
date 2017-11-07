//
//  MeVC.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/5/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController
{
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func signOutBtnWasPressed(_ sender: Any)
    {
        let logoutPopup = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .actionSheet) //The action sheet is the list of options they give you when you want to share something.
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive)
        { (buttonTapped) in
            do
            {
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            }
            catch
            { //If we can't instantiate the view controller
                print(error)
            }
        }
        logoutPopup.addAction(logoutAction) //Add the action to alertcontroller.
        present(logoutPopup, animated: true, completion: nil)
    }
    
}
