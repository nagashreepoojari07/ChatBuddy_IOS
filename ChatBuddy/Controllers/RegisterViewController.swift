//
//  RegisterViewController.swift
//  ChatBuddy
//
//  Created by Nagashree,Nagashree on 03/11/22.
//

import UIKit
import FirebaseAuth


class RegisterViewController: UIViewController {
    
    

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
   
    @IBOutlet weak var dobField: UITextField!

    var uidatePicker = UIDatePicker()
    
    let dateFormatter = DateFormatter()
    
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        dobField.delegate=self
        uidatePicker.datePickerMode = .date
        uidatePicker.preferredDatePickerStyle = .inline
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
        
//        uidatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        uidatePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //dobField.inputView  = UIDatePicker()
        
        
       // datePicker.calendar = .current
        
//        DateFormatter.dateFormat(fromTemplate: "dd/MM/yyyy" , options: 0, locale: nil)
//        dobField.text = dateFormatter.string(from: datePicker.date)
//        datePicker.datePickerMode = UIDatePicker.Mode.date
    }
    

    
    @IBAction func registerPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        if let email = emailField.text, let password = passwordField.text{
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                    print(e.localizedDescription)
                    let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)

                }
                else{
//                    DispatchQueue.main.async {
//                        self.activityIndicator.startAnimating()
//                    }
//                    
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }

}

extension RegisterViewController:UITextFieldDelegate{
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        print("datechanged")
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        //DateFormatter.dateFormat(fromTemplate: "dd/MM/yyyy" , options: 0, locale: nil)
        
        dobField.text = dateFormatter.string(from: sender.date)
        print(dateFormatter.string(from: sender.date))
        
//        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
//        if let day = components.day, let month = components.month, let year = components.year {
//            print("\(day) \(month) \(year)")
//            dobField.text = "\(day) \(month) \(year)"
//        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("hey")
        textField.inputView=uidatePicker
        uidatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
}
