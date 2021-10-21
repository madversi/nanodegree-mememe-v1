//
//  MemeDetailViewController.swift
//  MemeMe v1
//
//  Created by Helder M Adversi Jr on 21/10/21.
//

import UIKit

class MemeDetailViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet private weak var imageView: UIImageView!

    // MARK: Properties
    var meme: Meme!

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let meme = meme else {
            return
        }
        imageView.image = meme.memedImage
    }
}
