//
//  LoginViewController.swift
//  ChatBuddy
//
//IB Designables Group//  Created by Nagashree,Nagashree on 03/11/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        if let email = emailField.text,let password = passwordField.text{
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                if let e = error {
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                    print(e.localizedDescription)
                    let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
    
}
