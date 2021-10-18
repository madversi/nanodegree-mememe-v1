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
    @IBOutlet private weak var cameraButton: UIBarButtonItem!
    @IBOutlet private weak var albumButton: UIBarButtonItem!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var topTextField: UITextField!
    @IBOutlet private weak var bottomTextField: UITextField!

    // MARK: IB Actions
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
        setUpButtonsVisibility()
        setUpTextFields()
    }

    // MARK: Private functions
    private func buildImagePickerControllerFor(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        return imagePickerController
    }

    private func setUpButtonsVisibility() {
        cameraButton.isEnabled = deviceHasCamera
        albumButton.isEnabled = deviceHasPhotoLibrary
    }

    private func setUpTextFields(shouldHide: Bool = true) {
        let attributes: [NSAttributedString.Key : Any] = [.strokeWidth: -1.0,
                                                          .strokeColor: UIColor.black,
                                                          .foregroundColor: UIColor.white]
        let attributedText = NSAttributedString(string: "Text", attributes: attributes)
        topTextField.attributedText = attributedText
        bottomTextField.attributedText = attributedText
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
        setUpTextFields(shouldHide: false)
    }
}

// MARK: UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
}

// MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
}
