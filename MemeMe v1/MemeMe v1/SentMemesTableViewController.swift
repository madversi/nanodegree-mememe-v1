//
//  SentMemesTableViewController.swift
//  MemeMe v1
//
//  Created by Helder M Adversi Jr on 21/10/21.
//

import UIKit

class SentMemesTableViewController: UIViewController {
    @IBOutlet weak var memesTableView: UITableView!
}

extension SentMemesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate.memes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memeList = AppDelegate.memes
        let memeTableViewCell = MemeTableViewCell()
        memeTableViewCell.setupCell(meme: memeList[indexPath.row])
        return memeTableViewCell
    }

}

extension SentMemesTableViewController: UITableViewDelegate {

}
