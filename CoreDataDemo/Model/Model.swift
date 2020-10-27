//
//  Model.swift
//  CoreDataDemo
//
//  Created by iMac on 27/10/20.
//  Copyright © 2020 Nikul. All rights reserved.
//

import UIKit

struct UserModel {
    var firstName: String!
    var lastName: String!
    var imageData: Data!

    init(_ fname: String, _ lname: String, _ imgData: Data) {
        firstName = fname
        lastName = lname
        imageData = imgData
    }
}
