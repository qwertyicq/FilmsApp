//
//  FullPicViewController.swift
//  FilmsApp
//
//  Created by Nikolay T on 16.07.2022.
//

import UIKit

class FullPicViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var bigPicGalleryCollection: UICollectionView!
    var picturesCounter: Int = 9
    override func viewDidLoad() {
        super.viewDidLoad()
        let xibCell = UINib(nibName: "GalleryCell", bundle: nil)
        bigPicGalleryCollection.register(xibCell, forCellWithReuseIdentifier: "GalleryCell")

        bigPicGalleryCollection.dataSource = self
        bigPicGalleryCollection.delegate = self
    }
}

extension FullPicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picturesCounter
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = bigPicGalleryCollection.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as? GalleryCell else {
            return UICollectionViewCell()
        }

        cell.layer.cornerRadius = 20
        cell.additionaPosterImage.image = UIImage(named: "image1")

        return cell
    }
}
