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

        guard let unwrFilmPic = Model.shared.filmObjects?[self.detailIndexPath].filmPic,
              let posterURL = URL(string: Model.shared.address + unwrFilmPic) else { return }

        //Model.shared.urlService.getSetPoster(withURL: posterURL, imageView: fullPosterImageView)
        Model.shared.urlService.getSetPoster(url: posterURL) { image in
            self.fullPosterImageView.image = image
        }

        //fullPosterImageView.image = UIImage(named: testArray[detailIndexPath].testPic ?? "image1")
    }
    @IBAction func closeButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
