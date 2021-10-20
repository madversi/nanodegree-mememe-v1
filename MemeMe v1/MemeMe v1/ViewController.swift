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
    @IBOutlet private weak var memeContainerView: UIView!
    @IBOutlet private weak var cancelButton: UIBarButtonItem!
    @IBOutlet private weak var shareButton: UIBarButtonItem!
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

    @IBAction func didTapShareButton(_ sender: Any) {
        let memeToShare = mergeImageWithTextFieldsIntoASingleImage()
        let itemsToShare = [memeToShare]
        let activityView = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)

        activityView.completionWithItemsHandler = { [weak self] (_, completed: Bool, _, _) in
            if completed {
                self?.saveMemeIntoPhotos(meme: memeToShare)
            }
        }
        present(activityView, animated: true)
    }

    @IBAction func didTapCancelButton(_ sender: Any) {
        setUpScreen()
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
        setUpScreen()
    }

    // MARK: Private functions
    private func buildImagePickerControllerFor(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        return imagePickerController
    }

    private func setUpScreen(shouldHideTextFields: Bool = true, with image: UIImage? = nil) {
        cameraButton.isEnabled = deviceHasCamera && image == nil
        albumButton.isEnabled = deviceHasPhotoLibrary && image == nil
        shareButton.isEnabled = image != nil ? true : false
        cancelButton.isEnabled = image != nil ? true : false

        topTextField.clearsOnBeginEditing = true
        topTextField.attributedText = buildNSAttributedString(with: "TOP")
        topTextField.isHidden = shouldHideTextFields
        topTextField.delegate = self

        bottomTextField.clearsOnBeginEditing = true
        bottomTextField.attributedText = buildNSAttributedString(with: "BOTTOM")
        bottomTextField.isHidden = shouldHideTextFields
        bottomTextField.delegate = self

        imageView.image = image
    }

    private func buildNSAttributedString(with text: String) -> NSAttributedString {
        let textAttributes: [NSAttributedString.Key : Any] = [.strokeWidth: -2.0,
                                                          .strokeColor: UIColor.black,
                                                          .foregroundColor: UIColor.white]
        return NSAttributedString(string: text, attributes: textAttributes)
    }

    private func mergeImageWithTextFieldsIntoASingleImage() -> UIImage {
        disableAnyCursorActive()
        let renderer = UIGraphicsImageRenderer(size: memeContainerView.bounds.size)
        let image = renderer.image { _ in
            memeContainerView.drawHierarchy(in: memeContainerView.bounds, afterScreenUpdates: true)
        }
        return image
    }

    private func disableAnyCursorActive() {
        topTextField.endEditing(true)
        bottomTextField.endEditing(true)
    }

    private func saveMemeIntoPhotos(meme: UIImage) {
        UIImageWriteToSavedPhotosAlbum(meme, nil, nil, nil)
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
        setUpScreen(shouldHideTextFields: false, with: image)
    }
}

// MARK: UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {}

// MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {}
