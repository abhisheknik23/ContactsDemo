//
//  ContactsViewModel.swift
//  ContactsDemoApp
//
//  Created by Abhishek Gupta on 26/06/19.
//  Copyright © 2019 Abhishek Gupta. All rights reserved.
//

import Foundation
import UIKit

class ContactsViewModel: NSObject {
    
    var id: Int?
    var first_name: String?
    var last_name: String?
    var profile_pic: String?
    var favorite: Bool?
    
    init(contact: ContactsModel) {
        self.first_name = contact.first_name
        self.last_name = contact.last_name
        self.profile_pic = contact.profile_pic
        self.favorite = contact.favorite
        self.id = contact.id
    }
}
