//
//  ContactsModel.swift
//  ContactsDemoApp
//
//  Created by Abhishek Gupta on 26/06/19.
//  Copyright © 2019 Abhishek Gupta. All rights reserved.
//

import Foundation

struct ContactsModel: Decodable {
    
    var id: Int?
    var first_name: String?
    var last_name: String?
    var profile_pic: String?
    var favorite: Bool?
    
    init(first_name: String, last_name: String, profile_pic: String, favorite: Bool, id: Int) {
        self.first_name = first_name
        self.last_name = last_name
        self.profile_pic = profile_pic
        self.favorite = favorite
        self.id = id
    }
}
