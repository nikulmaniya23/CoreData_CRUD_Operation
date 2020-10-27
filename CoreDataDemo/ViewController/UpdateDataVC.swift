//
//  UpdateDataVC.swift
//  CoreDataDemo
//
//  Created by nikunj on 16/03/20.
//  Copyright © 2020 Nikul. All rights reserved.
//

import CoreData
import UIKit
class UpdateDataVC: UIViewController {
    @IBOutlet var nameToUpdateField: UITextField!
    @IBOutlet var firstNameToUpdate: UITextField!
    @IBOutlet var lastNameToUpdate: UITextField!
    @IBOutlet var updateView: UIView!

    @IBOutlet var statusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView.setViewShadow(clr: .red)
    }

    @IBAction func onClickUpdateRecord() {
        updateDataByName(searchText: nameToUpdateField.text!)
    }

    func updateDataByName(searchText: String) {
        CoreManager.shared.updateDataByName(searchText: searchText, firstName: firstNameToUpdate.text!, lastName: lastNameToUpdate.text!) { [self] success in
            switch success {
            case true:
                resetTextField()
                self.statusLabel.text = "Record Updated"
            case false:
                self.statusLabel.text = "Not Found"
            }
        }
    }

    func resetTextField() {
        firstNameToUpdate.text = ""
        lastNameToUpdate.text = ""
        nameToUpdateField.text = ""
    }
}
