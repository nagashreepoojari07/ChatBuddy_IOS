//
//  ViewController.swift
//  ChatBuddy
//
//  Created by Nagashree,Nagashree on 03/11/22.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: CLTypingLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = K.appName
        
//        welcomeLabel.text=""
//        let text = "⚡️ChatBuddy"
//        var x = 0.0
//        for letter in text {
//            Timer.scheduledTimer(withTimeInterval: 0.1 * x, repeats: false) { timer in
//                self.welcomeLabel.text?.append(letter)
//            }
//            x += 1.5
//
//        }
    }


}

