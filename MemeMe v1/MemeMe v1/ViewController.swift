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

    // MARK: Actions
    @IBAction func didTapCameraButton(_ sender: Any) {
        let imagePickerController = buildImagePickerControllerFor(sourceType: .camera)
        present(imagePickerController, animated: true)
    }

    @IBAction func didTapAlbumButton(_ sender: Any) {
        let imagePickerController = buildImagePickerControllerFor(sourceType: .photoLibrary)
        present(imagePickerController, animated: true)
    }

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        guard let textFieldText = sender.text else {
            sender.attributedText = buildNSAttributedString(with: "")
            return
        }
        sender.attributedText = buildNSAttributedString(with: textFieldText)
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScreenElementsVisibility()
        setUpDefaultTextFields()
    }

    // MARK: Private functions
    private func buildImagePickerControllerFor(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        return imagePickerController
    }

    private func setUpScreenElementsVisibility() {
        cameraButton.isEnabled = deviceHasCamera
        albumButton.isEnabled = deviceHasPhotoLibrary
        topTextField.isHidden = true
        bottomTextField.isHidden = true
    }

    private func setUpDefaultTextFields(shouldHide: Bool = true) {
        topTextField.clearsOnBeginEditing = true
        topTextField.attributedText = buildNSAttributedString(with: "TOP")
        topTextField.isHidden = shouldHide
        topTextField.delegate = self

        bottomTextField.clearsOnBeginEditing = true
        bottomTextField.attributedText = buildNSAttributedString(with: "BOTTOM")
        bottomTextField.isHidden = shouldHide
        bottomTextField.delegate = self
    }

    private func buildNSAttributedString(with text: String) -> NSAttributedString {
        let textAttributes: [NSAttributedString.Key : Any] = [.strokeWidth: -2.0,
                                                          .strokeColor: UIColor.black,
                                                          .foregroundColor: UIColor.white]
        return NSAttributedString(string: text, attributes: textAttributes)
    }
}

// MARK: UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            print("Failed to pick the image.")
            return
        }
        imageView.image = image
        setUpDefaultTextFields(shouldHide: false)
    }
}

// MARK: UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
}

// MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
}
