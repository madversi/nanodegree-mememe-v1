//
//  SentMemesCollectionViewController.swift
//  MemeMe v1
//
//  Created by Helder M Adversi Jr on 21/10/21.
//

import UIKit

class SentMemesCollectionViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: Properties
    private var memeList: [Meme] {
        get {
            return AppDelegate.shared.memes
        }
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlowLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }


    // MARK: Private funcs
    private func setupFlowLayout() {
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
}

// MARK: UICollectionViewDataSource
extension SentMemesCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentMeme = memeList[indexPath.row]
        let memeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? MemeCollectionViewCell

        guard let cell = memeCollectionViewCell else {
            return MemeCollectionViewCell()
        }
        cell.setupCell(meme: currentMeme)
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension SentMemesCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeDetailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as? MemeDetailViewController

        guard let detailController = memeDetailController else {
            return
        }
        detailController.meme = memeList[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }
}
