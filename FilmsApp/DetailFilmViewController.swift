//
//  DetailFilmViewController.swift
//  FilmsApp
//
//  Created by Nikolay T on 16.07.2022.
//

import UIKit

class DetailFilmViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var galleryCollection: UICollectionView!
    @IBOutlet weak var descriptionTextView: UITextView!

    var destinationIndex: Int = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        posterImageView.image = UIImage(named: testArray[destinationIndex].testPic ?? "image1")
        filmTitleLabel.text = testArray[destinationIndex].testTitle
        releaseYearLabel.text = testArray[destinationIndex].testYear
        rateLabel.text = testArray[destinationIndex].testRating
    }

    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
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
