//
//  ChatViewController.swift
//  ChatBuddy
//
//  Created by Nagashree,Nagashree on 03/11/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    var messages : [Message] = []
    
    let db = Firestore.firestore()

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var messageField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource=self
        
        messageField.delegate=self
        
        navigationItem.hidesBackButton=true
        navigationItem.title="⚡️ChatBuddy"
        
        //registering the messegecell that we have created
        tableView.register(UINib(nibName: K.tableCellNibName, bundle: nil), forCellReuseIdentifier: K.tableCellIdentifier)
        loadMessages()
        
    }
    
    func loadMessages(){
        
        db.collection(K.dbCollectionName).order(by: K.dbTimeKey).addSnapshotListener { querySnapshot, error in
            if let e = error {
                print(e)
            }else{
                self.messages=[]
                if let docSnapshot = querySnapshot?.documents{
                    for doc in docSnapshot {
                        let data = doc.data()
                        
                        self.messages.append(Message(sender: data[K.dbSenderKey] as! String, body: data[K.dbBodyKey] as! String))
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        }
                        
                    }
                }
            }
        }

        
    }

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
            let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
          
    }
    


}

//MARK: - UITextFieldDelegate

extension ChatViewController:UITextFieldDelegate{

    @IBAction func sendButtonPressed(_ sender: UIButton) {
        
        if let message = messageField.text,let sender = Auth.auth().currentUser?.email{
            db.collection(K.dbCollectionName).addDocument(data: [K.dbSenderKey:sender,
                                                                 K.dbBodyKey:message,
                                                                 K.dbTimeKey:Date.now
                                                                ]) { error in
                if let e = error {
                    print(e)
                }else{
                    print("data stored succesfully")
                }
            }
        }
        messageField.text=""
    
    }
}

//MARK: - UITableViewDataSource
extension ChatViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableCellIdentifier, for: indexPath)
        as! TableViewCell
        if messages.count != 0{
            let sender = messages[indexPath.row].sender
            if sender == Auth.auth().currentUser?.email{
                cell.messageLabel.text = messages[indexPath.row].body
                cell.meImage.isHidden = false
                cell.youImage.isHidden = true
                
                cell.messageBubble.backgroundColor = UIColor(named: "BrandLightPurple")
            }else{
                cell.messageLabel.text = messages[indexPath.row].body
                cell.meImage.isHidden = true
                cell.youImage.isHidden = false
                cell.messageBubble.backgroundColor = UIColor(named: "BrandPurple")
            }
            print(messages)
            return cell
        }else{
            return cell
        }
        
    }
}
