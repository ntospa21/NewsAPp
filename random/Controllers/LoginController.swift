//
//  LoginViewController.swift
//  random
//
//  Created by Pantos, Thomas on 13/7/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

 
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var pressed: UIButton!
    
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
       
    }
    
    @IBAction func pressed(_ sender: UIButton) {
        if let email = emailTextfield.text , let password = passwordTextfield.text {
            
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let e = error{
                print(e)
            } else {
                self?.performSegue(withIdentifier: "LoginToApp", sender: self)
            }
//          guard let strongSelf = self else { return }
          // ...
        }
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login to the NewsApp"
        self.navigationController?.navigationBar.tintColor = UIColor.black

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

