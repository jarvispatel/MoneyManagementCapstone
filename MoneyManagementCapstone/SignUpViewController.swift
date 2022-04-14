//
//  SignUpViewController.swift
//  MoneyManagementCapstone
//
//  Created by Rutvik
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signUpButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
     
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        signUpButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        
    }
    
    
    
    
    @objc private func didTapButton(){
        print("Continue Button Tap")
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
            //Going to Tab Bar controller
        else{
            print("Missing field data")
            return
        }
        //Get Auth Instance
        //Attempt Sign In
        //If Failure , present alert to create account
        //if user continues , create account
        //check sign in on app launch
        //allow user to sign out with button
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in guard let strongSelf = self else{
            return
        }
            guard error == nil else{
            //show account creation
                strongSelf.showCreateAccount(email: email, password: password)
            return
        }
        print("You have signed in ")
        })
    }
    
    func showCreateAccount(email: String, password: String){
        let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self] result, error in
                
                guard let strongSelf = self else{
                    return
                }
                    guard error == nil else{
                    //show account creation
                        alert.addAction(UIAlertAction(title: "Account already exists", style: .default, handler: nil))
                        print("Account creation failed")
                    return
                }
                
                print("You have created account succesfully")
               
                
                strongSelf.emailTextField.resignFirstResponder()
                strongSelf.passwordTextField.resignFirstResponder()
            })
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            
        }))
        
        present(alert, animated: true)
    }
    
    
}
