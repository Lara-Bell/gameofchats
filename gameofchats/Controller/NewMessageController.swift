//
//  NewMessageController.swift
//  gameofchats
//
//  Created by dev-mac on 2018/09/30.
//  Copyright © 2018 lara-bell. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {

    let cellId = "cellId"
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        fetchUser()
    }
    
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: {(snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User()
                user.id = snapshot.key
                // if you use this setter, your app will crash if your class properties dont exactly match up with the firebase tionary keys
                user.setValuesForKeys(dictionary)
                self.users.append(user)
                
                // this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                // user.name = dictionary["name"]
            }
        }, withCancel: nil)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        if let profileImageUrl = user.profileImageUrl {
            cell.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
//            let url = NSURL(string: profileImageUrl)
//            URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
//                if error != nil {
//                    print(error)
//                    return
//                }
//                DispatchQueue.main.async {
//                    cell.profileImageView.image = UIImage(data: data!)
//                }
//            }).resume()
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    var messagesController: MessagesController?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            print("Dismiss completed")
            let user = self.users[indexPath.row]
            self.messagesController?.showChatControllerForUser(user: user)
        }
    }
    
}

