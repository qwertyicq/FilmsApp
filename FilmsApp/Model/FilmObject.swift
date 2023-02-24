//
//  FilmObject.swift
//  FilmsApp
//
//  Created by Nikolay T on 20.02.2023.
//

import Foundation
import RealmSwift

class FilmObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var filmPic: String = ""
    @objc dynamic var filmTitle: String = ""
    @objc dynamic var filmYear: Int = 0
    @objc dynamic var filmRating: Double = 0
    @objc dynamic var isLiked: Bool = false

    override class func primaryKey() -> String? {
        return "id"
    }
}
