//
//  ViewController.swift
//  MemeMe v1
//
//  Created by Helder M Adversi Jr on 16/08/21.
//

import AVFoundation
import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    // MARK: Private Properties
    private var deviceHasCamera: Bool {
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    private var deviceHasPhotoLibrary: Bool {
        return UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
    }

    // MARK: Outlets
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!

    // MARK: Button actions
    @IBAction func didTapCameraButton(_ sender: Any) {
    }

    @IBAction func didTapAlbumButton(_ sender: Any) {
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.isEnabled = deviceHasCamera
        albumButton.isEnabled = deviceHasPhotoLibrary
    }

    // MARK: Private functions
}

// MARK: UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {

}
