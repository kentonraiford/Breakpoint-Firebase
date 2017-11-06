//
//  LoginVC.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/5/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit

class LoginVC: UIViewController
{
    
    @IBOutlet weak var emailTxtField: InsetTextField!
    @IBOutlet weak var passwordTextField: InsetTextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        emailTxtField.delegate = self
        passwordTextField.delegate = self
       
    }

    @IBAction func signInBtnWasPressed(_ sender: Any)
    {
        if emailTxtField.text != nil && passwordTextField.text != nil
        { //If both the txt fields are not empty
            AuthService.instance.loginUser(withEmail: emailTxtField.text!, andPassword: passwordTextField.text!, loginComplete:
                { (success, loginError) in
                    if success //The user was a nle to login successfully
                    {
                        self.dismiss(animated: true, completion: nil)
                    }
                    else //If there is an error logging in.
                    {
                        print(String(describing: loginError?.localizedDescription))
                    }
                    
                    AuthService.instance.registerUser(withEmail: self.emailTxtField.text!, andPassword: self.passwordTextField.text!, userCreationComplete: //If they don't have an account then there will be an error and we will attempt to create an account for them.
                        { (success, registrationError) in
                            if success //If we can successfully create a user
                            {
                                AuthService.instance.loginUser(withEmail: self.emailTxtField.text!, andPassword: self.passwordTextField.text!, loginComplete:
                                    { (success, nil) in
                                        self.dismiss(animated: true, completion: nil)
                                        print("Login successful")
                                    })
                            }
                            else //Could not register user
                            {
                                print(String(describing: registrationError?.localizedDescription))
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

extension LoginVC: UITextFieldDelegate
{
    
}
