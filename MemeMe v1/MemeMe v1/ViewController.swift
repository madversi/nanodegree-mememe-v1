//
//  ViewController.swift
//  MemeMe v1
//
//  Created by Helder M Adversi Jr on 16/08/21.
//

import AVFoundation
import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
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
        checkCameraAuthorizationStatus()
    }

    // MARK: Private functions
    private func checkCameraAuthorizationStatus() {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraAuthorizationStatus {
        case .denied, .restricted:
            enableCameraButton(false)
            showNeedCameraAuthorizationPopup()
            break
        case .notDetermined:
            enableCameraButton(false)
            askUserForCameraPermission()
            break
        case .authorized:
            enableCameraButton(true)
            break
        default:
            break
        }
    }

    private func showNeedCameraAuthorizationPopup() {
        let alert = UIAlertController(title: "Unable to access camera", message: "You should allow camera access on OS settings.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    private func askUserForCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] cameraAccessAllowed in
            self?.enableCameraButton(cameraAccessAllowed)
        }
    }

    private func enableCameraButton(_ isEnabled: Bool) {
        cameraButton.isEnabled = isEnabled
    }
}

// MARK: UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {

}
