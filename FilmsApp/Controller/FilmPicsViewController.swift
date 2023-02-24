//
//  FilmPicsViewController.swift
//  FilmsApp
//
//  Created by Nikolay T on 16.07.2022.
//

import UIKit

class FilmPicsViewController: UIViewController {

    @IBOutlet weak var allGalleryCollection: UICollectionView!
    @IBOutlet weak var counterLabel: UILabel!
    var picturesCounter: Int = 9
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let xibCell = UINib(nibName: "GalleryCell", bundle: nil)
        allGalleryCollection.register(xibCell, forCellWithReuseIdentifier: "GalleryCell")

        allGalleryCollection.dataSource = self
        allGalleryCollection.delegate = self
    }
}

extension FilmPicsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picturesCounter
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = allGalleryCollection.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as? GalleryCell else {
            return UICollectionViewCell()
        }

        cell.layer.cornerRadius = 20
        cell.additionaPosterImage.image = UIImage(named: "image1")

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let destViewController = storyboard?.instantiateViewController(withIdentifier: "FullPicViewControllerS") as? FullPicViewController else { return }

        destViewController.picturesCounter = self.picturesCounter

        navigationController?.pushViewController(destViewController, animated: true)
    }
}
