//
//  SLScheduleListAddPhotoHomeworkViewController.swift
//  Schedule
//
//  Created by Tatyana Anikina on 02.12.2020.
//

import UIKit

class SLScheduleListAddPhotoHomeworkViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addImageButton(_ sender: UIButton) {
       let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

extension SLScheduleListAddPhotoHomeworkViewController: UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }

        picker.dismiss(animated: true, completion: nil)
    }
}
