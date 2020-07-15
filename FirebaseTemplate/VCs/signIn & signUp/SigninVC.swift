//
//  SigninVC.swift
//  iVetAR
//
//  Created by Huda on 7/6/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//

import UIKit

class SigninVC: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        Networking.signIn(user: SignInCredentials(email: email, password: password), success: { uid in
            // ✅ Success
            print("You have signed in successfully👌🏼")
            self.performSegue(withIdentifier: "signed", sender: nil)
        }){ error in
            // ❌ Fail
            self.errorMessage(message: "iVet couldn't sign you in with an error: \(error)")
        }
        
        func errorMessage(message: String){
               let alertController = UIAlertController(title: "Opps🙈", message: message , preferredStyle: .alert)
               let okAction = UIAlertAction(title: "Ok", style: .cancel)
               alertController.addAction(okAction)
               present(alertController, animated: true)
           }
    }
    
    @IBAction func forgetPassword(_ sender: Any) {
        Networking.forgetPassword(email: emailTextField.text!)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func errorMessage(message: String){
        let alertController = UIAlertController(title: "Opps🙈", message: message , preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
