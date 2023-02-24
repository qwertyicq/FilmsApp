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
            DispatchQueue.main.async {
                self.favoriteFilmsCollection.reloadData()
            }
        }
    }

    @IBOutlet weak var favoriteFilmsCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteFilmsCollection.delegate = self
        favoriteFilmsCollection.dataSource = self

        let xibFavCell = UINib(nibName: "FilmCollectionViewCell", bundle: nil)

        favoriteFilmsCollection.register(xibFavCell, forCellWithReuseIdentifier: "FilmCell")

        Model.shared.fillFavouriteFilms()
        DispatchQueue.main.async {
            self.favoriteFilmsCollection.reloadData()
        }
    }

}

extension FavoriteFilmsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.shared.favouriteFilmObjects?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favoriteFilmsCollection.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as? FilmCollectionViewCell,
              let likedItem = Model.shared.favouriteFilmObjects?[indexPath.item] else {
            return UICollectionViewCell()
        }

        cell.layer.cornerRadius = 20

        cell.data = likedItem

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let destViewController = storyboard?.instantiateViewController(withIdentifier: "DetailFilmViewControllerS") as? DetailFilmViewController else { return }

        destViewController.destinationIndex = Model.shared.favouriteFilmObjects?[indexPath.item].id ?? 0

        navigationController?.pushViewController(destViewController, animated: true)
    }
}
