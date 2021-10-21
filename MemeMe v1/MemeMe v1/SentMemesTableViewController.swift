//
//  SentMemesTableViewController.swift
//  MemeMe v1
//
//  Created by Helder M Adversi Jr on 21/10/21.
//

import UIKit

class SentMemesTableViewController: UIViewController {
    @IBOutlet weak var memesTableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        let nib = UINib(nibName: "MemeTableViewCell", bundle: nil)
        memesTableView.register(nib, forCellReuseIdentifier: "MemeTableViewCell")
        memesTableView.reloadData()
    }
}

// MARK: UITableViewDataSource
extension SentMemesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate.memes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memeList = AppDelegate.memes
        let currentMeme = memeList[indexPath.row]
        let memeTableViewCell = memesTableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as? MemeTableViewCell

        guard let cell = memeTableViewCell else {
            return MemeTableViewCell()
        }
        cell.setupCell(meme: currentMeme)
        return cell
    }

}

// MARK: UITableViewDelegate
extension SentMemesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // call segue for MemeDetailVC passing meme object
    }
}
