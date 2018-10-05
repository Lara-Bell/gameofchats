//
//  Message.swift
//  gameofchats
//
//  Created by dev-mac on 2018/10/03.
//  Copyright © 2018 lara-bell. All rights reserved.
//

import UIKit
import Firebase

@objcMembers
class Message: NSObject {
    var fromId: String?
    var text: String?
    var timestamp: NSNumber?
    var toId: String?
    
    var imageUrl: String?
    
    func chatPartnerId() -> String? {
        return fromId! == Auth.auth().currentUser?.uid ? toId: fromId
    }
}
