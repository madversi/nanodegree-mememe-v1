//
//  ViewController.swift
//  MemeMe v1
//
//  Created by Helder M Adversi Jr on 16/08/21.
//

import AVFoundation
import UIKit

class MemeEditViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet private weak var memeContainerView: UIView!
    @IBOutlet private weak var cancelButton: UIBarButtonItem!
    @IBOutlet private weak var shareButton: UIBarButtonItem!
    @IBOutlet private weak var cameraButton: UIBarButtonItem!
    @IBOutlet private weak var albumButton: UIBarButtonItem!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var topTextField: UITextField!
    @IBOutlet private weak var bottomTextField: UITextField!

    // MARK: Private Properties
    private var deviceHasCamera: Bool {
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    private var deviceHasPhotoLibrary: Bool {
        return UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScreen()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
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
        shareButton.isEnabled = image != nil

        setupTextField(textField: topTextField, text: "TOP", shouldHide: shouldHideTextFields)
        setupTextField(textField: bottomTextField, text: "BOTTOM", shouldHide: shouldHideTextFields)

        imageView.image = image
    }

    private func setupTextField(textField: UITextField, text: String, shouldHide: Bool) {
        textField.clearsOnBeginEditing = true
        textField.attributedText = buildNSAttributedString(with: text)
        textField.returnKeyType = .done
        textField.isHidden = shouldHide
        textField.delegate = self
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

    private func saveMeme(meme: Meme) {
        UIImageWriteToSavedPhotosAlbum(meme.memedImage, nil, nil, nil)
        addInMemeList(meme: meme)
    }

    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    private func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

    private func addInMemeList(meme: Meme) {
        AppDelegate.memes.append(meme)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
            view.setNeedsLayout()
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
            view.setNeedsLayout()
        }
    }

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
        guard let originalImage = imageView.image else {
            print("Isn't usual to make a meme without an image :P ")
            return
        }
        let meme = Meme(topText: topTextField.text ?? "",
                        bottomText: bottomTextField.text ?? "",
                        originalImage: originalImage,
                        memedImage: mergeImageWithTextFieldsIntoASingleImage())

        let itemsToShare = [meme.memedImage]
        let activityView = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)

        activityView.completionWithItemsHandler = { [weak self] (_, completed: Bool, _, _) in
            if completed {
                self?.saveMeme(meme: meme)
                self?.dismiss(animated: true, completion: nil)
            }
        }
        present(activityView, animated: true)
    }

    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        guard let textFieldText = sender.text else {
            sender.attributedText = buildNSAttributedString(with: "")
            return
        }
        sender.attributedText = buildNSAttributedString(with: textFieldText)
    }

}

// MARK: UIImagePickerControllerDelegate
extension MemeEditViewController: UIImagePickerControllerDelegate {
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
extension MemeEditViewController: UINavigationControllerDelegate {}

// MARK: UITextFieldDelegate
extension MemeEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
