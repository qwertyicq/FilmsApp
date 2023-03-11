//
//  ViewController.swift
//  FilmsApp
//
//  Created by Nikolay T on 16.07.2022.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var favFilmsBtn: UIBarButtonItem!
    @IBOutlet weak var sortingBtn: UIBarButtonItem!

    var searchController = UISearchController()

    let dataService: URLService = URLService()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataService.dataRequest()

        print(Model.shared.realm?.configuration.fileURL)

        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Find Your Film"

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self

        let xibCell = UINib(nibName: "FilmCollectionViewCell", bundle: nil)
        mainCollectionView.register(xibCell, forCellWithReuseIdentifier: "FilmCell")

        Model.shared.ratingSort()

        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }

    @IBAction func sortBtnTouchUpInside(_ sender: Any) {
        Model.shared.sortAcending = !Model.shared.sortAcending

        sortingBtn.image = Model.shared.sortAcending ? UIImage(systemName: "arrow.up") : UIImage(systemName: "arrow.down")

        Model.shared.ratingSort()

        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }

    @IBAction func favFilmBtnTouchUpInside(_ sender: Any) {
        guard let destViewController = storyboard?.instantiateViewController(withIdentifier: "FavoriteFilmsViewControllerS") as? FavoriteFilmsViewController else { return }

        navigationController?.pushViewController(destViewController, animated: true)
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return Model.shared.arrayHelper?.count ?? 0
        return Model.shared.filmObjects?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as? FilmCollectionViewCell,
              let item = Model.shared.arrayHelper?[indexPath.row] else {
            return UICollectionViewCell()
        }

        NSLayoutConstraint.activate([
            cell.widthAnchor.constraint(equalToConstant: 180),
            cell.heightAnchor.constraint(equalToConstant: 358)
        ])
        cell.layer.cornerRadius = 20
        cell.data = item

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let destViewController = storyboard?.instantiateViewController(withIdentifier: "DetailFilmViewControllerS") as? DetailFilmViewController else { return }

        //destViewController.destinationIndex = Model.shared.arrayHelper?[indexPath.row].id ?? 0
        destViewController.destinationIndex = indexPath.row

        navigationController?.pushViewController(destViewController, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Model.shared.arrayHelper = Model.shared.filmObjects
        Model.shared.search(searchTextValue: searchText)

        if searchBar.text?.count == 0 {
            Model.shared.arrayHelper = Model.shared.filmObjects
            Model.shared.ratingSort()
        }

        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        Model.shared.arrayHelper = Model.shared.filmObjects

        if searchBar.text?.count == 0 {
            Model.shared.arrayHelper = Model.shared.filmObjects
            Model.shared.ratingSort()
        }
        
        DispatchQueue.main.async {
            Model.shared.ratingSort()
            self.mainCollectionView.reloadData()
        }
    }
}
