//
//  InsertDataVC.swift
//  CoreDataDemo
//
//  Created by nikunj on 16/03/20.
//  Copyright © 2020 Nikul. All rights reserved.
//

import CoreData
import UIKit
class InsertDataVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastnameField: UITextField!
    @IBOutlet var avtarImgView: UIImageView!
    @IBOutlet var insertView: UIView!
    @IBOutlet var operationView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        insertView.setViewShadow(clr: .red)
        operationView.setViewShadow(clr: .red)
    }

    // SELECT AVTAR IMAGE
    @IBAction func onClickSelectAvtar() {
        cameraButtonPressed()
    }

    // Display All Record
    @IBAction func onClickShowUserData() {
        performSegue(withIdentifier: "DisplayDataVC", sender: nil)
    }

    // Update Record
    @IBAction func onClickUpdateUserData() {
        performSegue(withIdentifier: "UpdateDataVC", sender: nil)
    }

    // Delete/Search Record
    @IBAction func onClickSearchUserData() {
        performSegue(withIdentifier: "SearchVC", sender: nil)
    }

    // Save Record
    @IBAction func onClickSaveUserData() {
        CoreManager.shared.saveUserData(firstName: firstNameField.text!,
                                        lastName: lastnameField.text!,
                                        avtarImage: avtarImgView.image)
        { [self] success in
            if success {
                firstNameField.text = ""
                lastnameField.text = ""
                avtarImgView.image = UIImage(named: "avatar")
            }
        }
    }

    @objc func cameraButtonPressed() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let userPickedImage = info[.editedImage] as? UIImage else { return }
        avtarImgView.image = userPickedImage.scale(toSize: CGSize(width: 150, height: 150))
        picker.dismiss(animated: true)
    }
}
