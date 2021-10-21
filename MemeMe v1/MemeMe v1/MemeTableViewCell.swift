//
//  MemeTableViewCell.swift
//  MemeMe v1
//
//  Created by Helder M Adversi Jr on 21/10/21.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeTextField: UITextField!

    func setupCell(meme: Meme) {
        memeImageView.image = meme.memedImage
        memeTextField.text = meme.topText + meme.bottomText
    }
}
