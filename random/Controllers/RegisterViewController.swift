//
//  RegisterViewController.swift
//  random
//
//  Created by Pantos, Thomas on 13/7/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register to the NewsApp"
        self.navigationController?.navigationBar.tintColor = UIColor.black

        // Do any additional setup after loading the view.
    }
    @IBAction func registerPressed(_ sender: UIButton) {
        
        let confirmPass = confirmPassTextField.text
        
        if let email = emailTextField.text, let password = passwordTextField.text{
            if confirmPass == password{
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                //Navigate to the ChatViewController
                self.performSegue(withIdentifier: "RegisterToApp", sender: self)
            }
        }
            } else {
                print("pass dont match")
                
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
