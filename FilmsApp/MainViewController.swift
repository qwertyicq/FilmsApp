//
//  ViewController.swift
//  FilmsApp
//
//  Created by Nikolay T on 16.07.2022.
//

import UIKit

class MainViewController: UIViewController {

    var testArray: [TestModel] = [
    TestModel(testPic: "image1", testTitle: "Фильм 1", testYear: "2009", testRating: "4.6"),
    TestModel(testPic: "image2", testTitle: "Фильм 2", testYear: "2009", testRating: "4.6"),
    TestModel(testPic: "image3", testTitle: "Фильм 3", testYear: "2009", testRating: "4.6"),
    TestModel(testPic: "image4", testTitle: "Фильм 4", testYear: "2009", testRating: "4.6"),
    TestModel(testPic: "image5", testTitle: "Фильм 5", testYear: "2009", testRating: "4.6"),
    TestModel(testPic: "image6", testTitle: "Фильм 6", testYear: "2009", testRating: "4.6"),
    TestModel(testPic: "image7", testTitle: "Фильм 7", testYear: "2009", testRating: "4.6"),
    TestModel(testPic: "image8", testTitle: "Фильм 8", testYear: "2009", testRating: "4.6"),
    TestModel(testPic: "image9", testTitle: "Фильм 9", testYear: "2009", testRating: "4.6"),
    TestModel(testPic: "image10", testTitle: "Фильм 10", testYear: "2009", testRating: "4.6"),
    TestModel(testPic: "image11", testTitle: "Фильм 11", testYear: "2009", testRating: "4.6"),
    TestModel(testPic: "image12", testTitle: "Фильм 12", testYear: "2009", testRating: "4.6"),
    TestModel(testPic: "image13", testTitle: "Фильм 13", testYear: "2009", testRating: "4.6"),
    TestModel(testPic: "image14", testTitle: "Фильм 14", testYear: "2009", testRating: "4.6"),
    TestModel(testPic: "image15", testTitle: "Фильм 15", testYear: "2009", testRating: "4.6")
    ]

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
}

extension MainViewController: UISearchBarDelegate {

}
