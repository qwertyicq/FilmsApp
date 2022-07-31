//
//  JSONModel.swift
//  FilmsApp
//
//  Created by Nikolay T on 18.07.2022.
//

import Foundation

class JSONModel: Codable {
    var originalTitle: String?
    var posterPath: String?
    var releaseDate: String?
    var overview: Double?
    var backdropPath: String?
}

class TestModel {
    var testPic: String?
    var testTitle: String?
    var testYear: String?
    var testRating: String?

    init(testPic: String?,
         testTitle: String?,
         testYear: String?,
         testRating: String?) {
        self.testPic = testPic
        self.testYear = testYear
        self.testTitle = testTitle
        self.testRating = testRating
    }
}
