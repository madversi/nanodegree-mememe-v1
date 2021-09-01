//
//  ViewController.swift
//  MemeMe v1
//
//  Created by Helder M Adversi Jr on 16/08/21.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {

    // MARK: Outlets
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!

    // MARK: Button actions
    @IBAction func didTapCameraButton(_ sender: Any) {
    }

    @IBAction func didTapAlbumButton(_ sender: Any) {
    }

}

// MARK: UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {

}
