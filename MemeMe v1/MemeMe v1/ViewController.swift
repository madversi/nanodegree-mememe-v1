//
//  ViewController.swift
//  MemeMe v1
//
//  Created by Helder M Adversi Jr on 16/08/21.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
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
        let imagePickerController = buildImagePickerControllerFor(sourceType: .camera)
        present(imagePickerController, animated: true)
    }

    @IBAction func didTapAlbumButton(_ sender: Any) {
        let imagePickerController = buildImagePickerControllerFor(sourceType: .photoLibrary)
        present(imagePickerController, animated: true)
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.isEnabled = deviceHasCamera
        albumButton.isEnabled = deviceHasPhotoLibrary
    }

    // MARK: Private functions
    private func buildImagePickerControllerFor(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        return imagePickerController
    }
}

// MARK: UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            print("Fail to pick the image.")
            return
        }

        imageView.image = image
    }
}

// MARK: UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate { }
