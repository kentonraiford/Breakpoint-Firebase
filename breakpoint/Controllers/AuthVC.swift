//
//  AuthVC.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/5/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit

class AuthVC: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

        
    }

    @IBAction func signInWithEmailBtnWasPressed(_ sender: Any)
    {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func googleSignInBtnWasPressed(_ sender: Any)
    {
        
    }
    
    @IBAction func facebookSignInBtnWasPressed(_ sender: Any)
    {
        
    }
    
    
    
}
