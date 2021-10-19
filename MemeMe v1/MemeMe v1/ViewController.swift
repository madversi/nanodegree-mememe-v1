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
        let textAttributes: [NSAttributedString.Key : Any] = [.strokeWidth: -1.0,
                                                          .strokeColor: UIColor.black,
                                                          .foregroundColor: UIColor.white]
        guard let textFieldText = sender.text else {
            return
        }
        let textWithAttributes = NSAttributedString(string: textFieldText, attributes: textAttributes)
        sender.attributedText = textWithAttributes
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
        let textAttributes: [NSAttributedString.Key : Any] = [.strokeWidth: -1.0,
                                                          .strokeColor: UIColor.black,
                                                          .foregroundColor: UIColor.white]
        let topTextWithAttributes = NSAttributedString(string: "TOP", attributes: textAttributes)
        let bottomTextWithAttributes = NSAttributedString(string: "BOTTOM", attributes: textAttributes)
        topTextField.attributedText = topTextWithAttributes
        topTextField.typingAttributes = [.strokeColor: UIColor.black]
        topTextField.isHidden = shouldHide
        topTextField.delegate = self

        bottomTextField.isHidden = shouldHide
        bottomTextField.attributedText = bottomTextWithAttributes
        bottomTextField.delegate = self
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
}
