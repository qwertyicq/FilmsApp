//
//  FilmCollectionViewCell.swift
//  FilmsApp
//
//  Created by Nikolay T on 18.07.2022.
//

import UIKit
import RealmSwift

class FilmCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterPreviewImageView: UIImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!

    var id: Int?

    var data: FilmObject? {

        didSet {
            guard let unwrData = data else { return }

            posterPreviewImageView.image = UIImage(named: unwrData.filmPic)
            filmTitleLabel.text = unwrData.filmTitle
            releaseYearLabel.text = String(unwrData.filmYear)
            rateLabel.text = String(unwrData.filmRating)
            likeBtn.setTitle("", for: .normal)
            likeBtn.setImage(unwrData.isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)

            id = unwrData.id
        }
    }

    @IBAction func likeBtnTouchUpInside(_ sender: Any) {
        guard let id = self.id else { return }
        Model.shared.updateLike(index: id)
        guard let films = Model.shared.filmObjects else { return }
        likeBtn.setImage(films[id].isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
    }
}
