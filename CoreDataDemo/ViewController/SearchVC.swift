//
//  SearchVC.swift
//  CoreDataDemo
//
//  Created by nikunj on 16/03/20.
//  Copyright © 2020 Nikul. All rights reserved.
//

import CoreData
import UIKit
class SearchVC: UIViewController {
    @IBOutlet var searchField: UITextField!
    @IBOutlet var searchLabel: UILabel!
    @IBOutlet var searchView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.setViewShadow(clr: .red)

        // Do any additional setup after loading the view.
    }

    // Search RECORD
    @IBAction func onClickSearchRecord() {
        searchLabel.text = ""
        searchRecord(searchText: searchField.text!)
    }

    func searchRecord(searchText: String) {
        CoreManager.shared.searchRecord(searchText: searchText) { [self] success, managedObj in
            switch success {
            case true:
                for obj in managedObj {
                    let firstName = obj!.value(forKey: "firstname") as! String
                    let lastName = obj!.value(forKey: "lastname") as! String
                    searchLabel.text = firstName + " " + lastName
                }
            case false:
                searchLabel.text = "Not Found"
            }
        }
    }

    // DELETE RECORD
    @IBAction func onClickDeleteRecord() {
        deleteDataByName(searchText: searchField.text!)
    }

    func deleteDataByName(searchText: String) {
        CoreManager.shared.deleteDataByName(searchText: searchText) { [self] success in
            switch success {
            case true:
                searchLabel.text = "Record Deleted"
                searchField.text = ""
            case false:
                searchLabel.text = "No Record Found"
            }
        }
    }
}
