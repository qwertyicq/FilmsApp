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
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var galleryButton: UIButton!
    var destinationIndex: Int = Int()
    var transition: RoundingTransition = RoundingTransition()


    override func viewDidLoad() {
        super.viewDidLoad()

        let xibCell = UINib(nibName: "GalleryCell", bundle: nil)
        galleryCollection.register(xibCell, forCellWithReuseIdentifier: "GalleryCell")

        galleryCollection.dataSource = self
        galleryCollection.delegate = self

        DispatchQueue.main.async {
            guard let unwrFilmPic = Model.shared.filmObjects?[self.destinationIndex].filmPic,
                  let posterURL = URL(string: Model.shared.address + unwrFilmPic) else { return }
            //Model.shared.urlService.getSetPoster(withURL: posterURL, imageView: self.posterImageView)
            Model.shared.urlService.getSetPoster(url: posterURL) { image in
                self.posterImageView.image = image
            }
            //self.posterImageView.image = UIImage(named: Model.shared.filmObjects?[self.destinationIndex].filmPic ?? "image1")
            self.filmTitleLabel.text = Model.shared.filmObjects?[self.destinationIndex].filmTitle
            self.releaseYearLabel.text = String(Model.shared.filmObjects?[self.destinationIndex].filmYear ?? 0)
            self.rateLabel.text = String(Model.shared.filmObjects?[self.destinationIndex].filmRating ?? 0)
            self.descriptionTextView.text = Model.shared.filmObjects?[self.destinationIndex].overview
            self.likeButton.setTitle("", for: .normal)
            self.likeButton.setImage(Model.shared.filmObjects?[self.destinationIndex].isLiked ?? false ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        }
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

    @IBAction func likeBtnTouchUpInside(_ sender: Any) {
        Model.shared.updateLike(index: self.destinationIndex)
        guard let films = Model.shared.filmObjects else { return }
        likeButton.setImage(films[self.destinationIndex].isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
    }

    @IBAction func galleryBtnTouchUpInside(_ sender: Any) {
        guard let destViewController = storyboard?.instantiateViewController(withIdentifier: "FilmPicsViewControllerS") as? FilmPicsViewController else { return }

        navigationController?.pushViewController(destViewController, animated: true)
    }
}

extension DetailFilmViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = galleryCollection.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as? GalleryCell else {
            return UICollectionViewCell()
        }

        NSLayoutConstraint.activate([
            cell.widthAnchor.constraint(equalToConstant: 128),
            cell.heightAnchor.constraint(equalToConstant: 128)
        ])

        cell.layer.cornerRadius = 20
        cell.additionaPosterImage.image = UIImage(named: "image1")

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let destViewController = storyboard?.instantiateViewController(withIdentifier: "FullPicViewControllerS") as? FullPicViewController else { return }

        destViewController.picturesCounter = 9

        navigationController?.pushViewController(destViewController, animated: true)
    }
}
