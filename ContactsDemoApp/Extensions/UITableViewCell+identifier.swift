//
//  UITableViewCell+identifier.swift
//  ContactsDemoApp
//
//  Created by Abhishek Gupta on 29/06/19.
//  Copyright © 2019 Abhishek Gupta. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var identifier:String{
        return String(describing: self)
    }
}
