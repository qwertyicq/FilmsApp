//
//  FavoriteFilmsViewController.swift
//  FilmsApp
//
//  Created by Nikolay T on 16.07.2022.
//

import UIKit

class FavoriteFilmsViewController: UIViewController {

    var isListEdit: Bool = Bool(){
        didSet {
            self.favoriteFilmsCollection.reloadData()
        }
    }

    @IBOutlet weak var favoriteFilmsCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteFilmsCollection.delegate = self
        favoriteFilmsCollection.dataSource = self

        let xibFavCell = UINib(nibName: "FilmCollectionViewCell", bundle: nil)

        favoriteFilmsCollection.register(xibFavCell, forCellWithReuseIdentifier: "FilmCell")

        favoriteFilmsCollection.reloadData()
    }

}

extension FavoriteFilmsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.shared.favoriteArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favoriteFilmsCollection.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as? FilmCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.layer.cornerRadius = 20

        cell.data = Model.shared.favoriteArray[indexPath.item]

        return cell
    }
}
