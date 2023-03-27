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

    var imageCache = NSCache<NSString, UIImage>()

    func dataRequest() {
        guard let popularURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-EN") else { return }

        let task = session.dataTask(with: popularURL) { data, response, error in
            guard let unwrData = data,
                  (response as? HTTPURLResponse)?.statusCode == 200,
                  error == nil else { return }
            self.parser.parceJSON(parseData: unwrData, parseError: error)
        }
        task.resume()
    }

/*    func getSetPoster (withURL url: URL, imageView: UIImageView) {
        let downloadTask = session.dataTask(with: url) { pictures, response, error in
            guard let pic = try? Data(contentsOf: url) else { return }

            DispatchQueue.main.async {
                imageView.image = UIImage(data: pic)
            }
        }
        downloadTask.resume()
    }*/

    func getSetPoster (url: URL, complition: @escaping (UIImage) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            complition(cachedImage)
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)

            let downloadTask = session.dataTask(with: request) { [weak self] data, response, error in
                guard error == nil,
                      let unwrData = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let self = self else {
                    return
                }

                guard let image = UIImage(data: unwrData) else {
                    return
                }

                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)

                DispatchQueue.main.async {
                    complition(image)
                }
            }

            downloadTask.resume()
        }
    }
}
