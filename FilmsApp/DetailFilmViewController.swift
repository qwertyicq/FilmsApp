//
//  DetailFilmViewController.swift
//  FilmsApp
//
//  Created by Nikolay T on 16.07.2022.
//

import UIKit

class DetailFilmViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var galleryCollection: UICollectionView!
    @IBOutlet weak var descriptionTextView: UITextView!

    var destinationIndex: Int = Int()
    var transition: RoundingTransition = RoundingTransition()

    override func viewDidLoad() {
        super.viewDidLoad()

        posterImageView.image = UIImage(named: testArray[destinationIndex].testPic ?? "image1")
        filmTitleLabel.text = testArray[destinationIndex].testTitle
        releaseYearLabel.text = testArray[destinationIndex].testYear
        rateLabel.text = testArray[destinationIndex].testRating
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionProfile = .show
        transition.start = posterImageView.center
        transition.roundColor = UIColor(red: 0, green: 42/255, blue: 92/255, alpha: 0.5)

        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionProfile = .cancel
        transition.start = posterImageView.center
        transition.roundColor = UIColor(red: 0, green: 42/255, blue: 92/255, alpha: 0.5)

        return transition
    }

    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let fullPicPosterVC = segue.destination as? PosterFullViewController else { return }

        fullPicPosterVC.detailIndexPath = destinationIndex

        fullPicPosterVC.transitioningDelegate = self
        fullPicPosterVC.modalPresentationStyle = .custom
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
