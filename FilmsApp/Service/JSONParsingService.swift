//
//  JSONParsingService.swift
//  FilmsApp
//
//  Created by Nikolay T on 07.03.2023.
//

import Foundation
import RealmSwift

class JSONParsingService {
    func parceJSON(parseData: Data, parseError: Error?) {
        do {
            let filmObject = try JSONDecoder().decode(MovieList.self, from: parseData)

            let jsonObjects = filmObject.results
            let realm = try Realm()

            try realm.write({
                for item in jsonObjects {
                    let object = FilmObject()

                    if let inwrId = item.id,
                       let inwrPoster = item.poster_path,
                       let unwrTitle = item.original_title,
                       let unwrOverview = item.overview,
                       let unwrYear = item.release_date,
                       let unwrRating = item.vote_average {

                        object.id = inwrId
                        object.filmPic = inwrPoster
                        object.filmTitle = unwrTitle
                        object.overview = unwrOverview
                        object.filmYear = Int(unwrYear.prefix(4) ?? "0000") ?? 0000
                        object.filmRating = unwrRating

                        object.isLiked = false

                        realm.add(object, update: .all)
                    }
                }
            })
        } catch let error {
            print(error)
        }
    }
}
