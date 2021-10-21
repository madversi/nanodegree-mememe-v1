//
//  MemeTableViewCell.swift
//  MemeMe v1
//
//  Created by Helder M Adversi Jr on 21/10/21.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet private weak var memeImageView: UIImageView!
    @IBOutlet private weak var memeLabel: UILabel!

    // MARK: Internal funcs
    func setupCell(meme: Meme) {
        memeImageView.image = meme.memedImage
        memeLabel.text = meme.topText + " " + meme.bottomText
    }
}
