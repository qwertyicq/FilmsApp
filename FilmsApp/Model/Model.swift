//
//  Model.swift
//  FilmsApp
//
//  Created by Nikolay T on 17.08.2022.
//

import Foundation
import RealmSwift

/*class Item {
    var id: Int?
    var testPic: String?
    var testTitle: String?
    var testYear: Int?
    var testRating: Double?
    var isLiked: Bool?

    init(id: Int?,
         testPic: String?,
         testTitle: String?,
         testYear: Int?,
         testRating: Double?,
         isLiked: Bool?) {
        self.id = id
        self.testPic = testPic
        self.testYear = testYear
        self.testTitle = testTitle
        self.testRating = testRating
        self.isLiked = isLiked
    }
}*/

class Model {
    public static let shared = Model()

    let realm = try? Realm()

    var filmObjects: Results<FilmObject>? {
        return realm?.objects(FilmObject.self)
    }
    var arrayHelper: Results<FilmObject>?
    var favouriteFilmObjects: Results<FilmObject>?
    
    /*var testArray: [Item] = [
        Item(id: 0, testPic: "image1", testTitle: "Фильм 1", testYear: 2009, testRating: 4.6, isLiked: false),
        Item(id: 1, testPic: "image2", testTitle: "Фильм 2", testYear: 2009, testRating: 1.6, isLiked: true),
        Item(id: 2, testPic: "image3", testTitle: "Фильм 3", testYear: 2009, testRating: 3.6, isLiked: false),
        Item(id: 3, testPic: "image4", testTitle: "Фильм 4", testYear: 2009, testRating: 8.6, isLiked: true),
        Item(id: 4, testPic: "image5", testTitle: "Фильм 5", testYear: 2009, testRating: 3.7, isLiked: false),
        Item(id: 5, testPic: "image6", testTitle: "Фильм 6", testYear: 2009, testRating: 5.6, isLiked: false),
        Item(id: 6, testPic: "image7", testTitle: "Фильм 7", testYear: 2009, testRating: 4.6, isLiked: false),
        Item(id: 7, testPic: "image8", testTitle: "Фильм 8", testYear: 2009, testRating: 6.6, isLiked: false),
        Item(id: 9, testPic: "image9", testTitle: "Фильм 9", testYear: 2009, testRating: 4.6, isLiked: false),
        Item(id: 10, testPic: "image10", testTitle: "Фильм 10", testYear: 2009, testRating: 4.6, isLiked: false),
        Item(id: 11, testPic: "image11", testTitle: "Фильм 11", testYear: 2009, testRating: 4.6, isLiked: false),
        Item(id: 12, testPic: "image12", testTitle: "Фильм 12", testYear: 2009, testRating: 4.6, isLiked: false),
        Item(id: 13, testPic: "image13", testTitle: "Фильм 13", testYear: 2009, testRating: 4.6, isLiked: false),
        Item(id: 14, testPic: "image14", testTitle: "Фильм 14", testYear: 2009, testRating: 4.6, isLiked: false),
        Item(id: 15, testPic: "image15", testTitle: "Фильм 15", testYear: 2009, testRating: 4.6, isLiked: false)
    ]*/

    var sortAcending: Bool = false
    //var sortedTestArray: [Item] = []
    //var favoriteArray: [Item] = []
    //var newTestArray: [Item] = []

    /*func ratingSort() -> [Item] {
        self.testArray.sort {
            sortAcending ? $0.testRating ?? 0 < $1.testRating ?? 0 : $0.testRating ?? 0 > $1.testRating ?? 0
        }

        sortedTestArray = testArray
        return sortedTestArray
    }*/

    func ratingSort() {
        arrayHelper = filmObjects?.sorted(byKeyPath: "filmRating", ascending: sortAcending)
    }

    /*func search(searchTextValue: String) {
        newTestArray = []

        if searchTextValue == "" {
            newTestArray = ratingSort()
        } else {
            for item in ratingSort() {
                guard let unwrItem = item.testTitle else { return }

                if unwrItem.contains(searchTextValue) {
                    newTestArray.append(item)
                }
            }
        }

        newTestArray = testArray.filter({
            $0.testTitle?.range(of: searchTextValue, options: .caseInsensitive) != nil
        })
    }*/

    func search(searchTextValue: String) {
        let predicate = NSPredicate(format: "filmTitle CONTAINS [c]$@", searchTextValue)
        arrayHelper = filmObjects?.filter(predicate)
    }

    func updateLike(index: Int) {
        if let film = filmObjects?[index] {
            do {
                try realm?.write({
                    film.isLiked = !film.isLiked
                })
            } catch {
                print("Ошибка сохранения данных, \(error)")
            }
        }
    }

    func fillFavouriteFilms() {
        let likeFilter = NSPredicate(format: "isLiked = true")

        favouriteFilmObjects = filmObjects?.filter(likeFilter)
    }

    /*func addToFavorite(index: Int) {
        ratingSort()[index].isLiked = true

        favoriteArray.append(ratingSort()[index])
    }

    func removeFromFavorite(id: Int) {
        ratingSort().first(where: { $0.id == id })?.isLiked = false
        
        favoriteArray.removeAll(where: { out in
            out.id == id
        })
    }

    func refillFavoriteFilms() {
        favoriteArray.removeAll()

        for item in sortedTestArray where item.isLiked! {
            favoriteArray.append(item)
        }

        for item in filmObject! .where({ itm in
            itm.isLiked == true
        }) {
            favoriteArray.append(Item(id: item.id, testPic: item.filmPic, testTitle: item.filmTitle, testYear: item.filmYear, testRating: item.filmRating, isLiked: item.isLiked))
        }
    }*/
}
