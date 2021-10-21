//
//  MemeCollectionViewCell.swift
//  MemeMe v1
//
//  Created by Helder M Adversi Jr on 21/10/21.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    func setupCell(meme: Meme) {
        imageView.image = meme.memedImage
    }
}
