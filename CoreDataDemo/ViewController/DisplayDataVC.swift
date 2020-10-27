//
//  DisplayDataVC.swift
//  CoreDataDemo
//
//  Created by nikunj on 14/03/20.
//  Copyright © 2020 Nikul. All rights reserved..
//

import CoreData
import UIKit

class DisplayDataVC: UIViewController {
    var fetchRecord = [UserModel]()

    @IBOutlet var tableView: UITableView!
    @IBOutlet var centerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        fetchData()
    }

    // Fetch Data From User Entity
    func fetchData() {
        CoreManager.shared.fetchData { [self] managedObj in
            for obj in managedObj {
                let firstName = obj.value(forKey: "firstname") as! String
                let lastName = obj.value(forKey: "lastname") as! String
                var imageData = obj.value(forKey: "imagedata") as? Data

                if imageData == nil {
                    imageData = UIImage(named: "avatar")?.pngData()
                }
                fetchRecord.append(UserModel(firstName, lastName, imageData!))
            }
            self.tableView.reloadData()
        }
    }
}

// Table Delegate
extension DisplayDataVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchRecord.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        cell.dataArray = fetchRecord[indexPath.row]
        cell.mainView.setViewShadow(clr: .black)
        return cell
    }
}
