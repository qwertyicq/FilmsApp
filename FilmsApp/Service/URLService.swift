//
//  URLService.swift
//  FilmsApp
//
//  Created by Nikolay T on 25.02.2023.
//

import UIKit

class URLService {
    let apiKey: String = "69c8512580941023bb0cbf017ebfd124"

    //let popularURL: URL? = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=69c8512580941023bb0cbf017ebfd124&language=ru-RU&page=1")

    let session = URLSession.shared
    let parser = JSONParsingService()

    func dataRequest() {
        guard let popularURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=ru-RU") else { return }

        let task = session.dataTask(with: popularURL) { data, response, error in
            guard let unwrData = data,
                  (response as? HTTPURLResponse)?.statusCode == 200,
                  error == nil else { return }
            self.parser.parceJSON(parseData: unwrData, parseError: error)
        }
        task.resume()
    }
}
