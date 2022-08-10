//
//  ViewController.swift
//  FilmsApp
//
//  Created by Nikolay T on 16.07.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var filmSearchBar: UISearchBar!
    @IBOutlet weak var mainCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self

        filmSearchBar.delegate = self

        let xibCell = UINib(nibName: "FilmCollectionViewCell", bundle: nil)
        mainCollectionView.register(xibCell, forCellWithReuseIdentifier: "FilmCell")

        mainCollectionView.reloadData()
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as? FilmCollectionViewCell else {
            return UICollectionViewCell()
        }

        NSLayoutConstraint.activate([
            cell.widthAnchor.constraint(equalToConstant: 180),
            cell.heightAnchor.constraint(equalToConstant: 358)
        ])

        cell.posterPreviewImageView.image = UIImage(named: testArray[indexPath.row].testPic ?? "image1")
        cell.filmTitleLabel.text = testArray[indexPath.row].testTitle
        cell.releaseYearLabel.text = testArray[indexPath.row].testYear
        cell.rateLabel.text = testArray[indexPath.row].testRating
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let destViewController = storyboard?.instantiateViewController(withIdentifier: "DetailFilmViewControllerS") as? DetailFilmViewController else { return }

        destViewController.destinationIndex = indexPath.row
        navigationController?.pushViewController(destViewController, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {

}
