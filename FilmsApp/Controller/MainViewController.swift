//
//  ViewController.swift
//  FilmsApp
//
//  Created by Nikolay T on 16.07.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var favFilmsBtn: UIBarButtonItem!
    @IBOutlet weak var sortingBtn: UIBarButtonItem!

    var searchController = UISearchController()

    let model: Model = Model()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        Model.shared.sortedTestArray = Model.shared.testArray

        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Find Film"

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self

        let xibCell = UINib(nibName: "FilmCollectionViewCell", bundle: nil)
        mainCollectionView.register(xibCell, forCellWithReuseIdentifier: "FilmCell")

        Model.shared.ratingSort()

        Model.shared.refillFavoriteFilms()

        mainCollectionView.reloadData()
    }

    @IBAction func sortBtnTouchUpInside(_ sender: Any) {
        Model.shared.sortAcending = !Model.shared.sortAcending

        sortingBtn.image = Model.shared.sortAcending ? UIImage(systemName: "arrow.up") : UIImage(systemName: "arrow.down")

        Model.shared.ratingSort()

        mainCollectionView.reloadData()
    }

    @IBAction func favFilmBtnTouchUpInside(_ sender: Any) {
        guard let destViewController = storyboard?.instantiateViewController(withIdentifier: "FavoriteFilmsViewControllerS") as? FavoriteFilmsViewController else { return }

        //Model.shared.refillFavoriteFilms()

        navigationController?.pushViewController(destViewController, animated: true)
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.shared.sortedTestArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as? FilmCollectionViewCell else {
            return UICollectionViewCell()
        }

        NSLayoutConstraint.activate([
            cell.widthAnchor.constraint(equalToConstant: 180),
            cell.heightAnchor.constraint(equalToConstant: 358)
        ])

        cell.layer.cornerRadius = 20

        cell.data = Model.shared.sortedTestArray[indexPath.item]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let destViewController = storyboard?.instantiateViewController(withIdentifier: "DetailFilmViewControllerS") as? DetailFilmViewController else { return }

        destViewController.destinationIndex = Model.shared.ratingSort()[indexPath.item].id ?? 0
        //    .sortedTestArray[indexPath.row].id ?? 0
        navigationController?.pushViewController(destViewController, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {

}
