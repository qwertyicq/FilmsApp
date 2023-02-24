//
//  PosterFullViewController.swift
//  FilmsApp
//
//  Created by Nikolay T on 10.08.2022.
//

import UIKit

class PosterFullViewController: UIViewController {

    @IBOutlet weak var fullPosterImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!

    var detailIndexPath: Int = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        fullPosterImageView.image = UIImage(named: testArray[detailIndexPath].testPic ?? "image1")
    }
    @IBAction func closeButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
