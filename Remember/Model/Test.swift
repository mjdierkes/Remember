//
//  Test.swift
//  Remember
//
//  Created by Mason Dierkes on 12/24/22.
//

import Foundation

let endpoint = "https://api.bing.microsoft.com/v7.0/images/search"
let apiKey = "ce0c2cd18d134997a67b63b0e20c4314"
let query = "Cat"

// MARK: - JSON Models
struct Images: Decodable {
    var nextOffset: Int?
    var totalEstimatedMatches: Int?
    var value: [MyImage]?
    var webSearchUrl: String?
}

struct MyImage: Decodable {
    var accentColor: String?
    var contentSize: String?
    var contentUrl: String?
    var datePublished: String?
    var encodingFormat: String?
    var height: Int?
    var hostPageDisplayUrl: String?
    var hostPageUrl: String?
    var imageId: String?
    var imageInsightsToken: String?
    var insightsMetadata: InsightsMetadata?
    var name: String?
    var thumbnail: MediaSize?
    var thumbnailUrl: String?
    var webSearchUrl: String?
    var width: Int?
}

struct InsightsMetadata: Decodable {
    var availableSizesCount: Int?
    var pagesIncludingCount: Int?
}

struct MediaSize: Decodable {
    var height: Int?
    var width: Int?
}

// MARK: - Private methods
func searchImages(query: String, imageUrl: String, completionHandler: @escaping (Images) -> Void) {

    var components = URLComponents(string: endpoint)!
    components.queryItems = [
        URLQueryItem(name: "q", value: query),
        URLQueryItem(name: "count", value: "150"),
        URLQueryItem(name: "offset", value: "0"),
        URLQueryItem(name: "minHeight", value: "32"),
        URLQueryItem(name: "minWidth", value: "32"),
        URLQueryItem(name: "safeSearch", value: "Off"),
        URLQueryItem(name: "imageUrl", value: imageUrl)
    ]

    var request = URLRequest(url: components.url!)
    request.addValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            fatalError(error.localizedDescription)
        }

        guard let data = data else {
            fatalError("Empty response")
        }

        let decoder = JSONDecoder()
        let images = try! decoder.decode(Images.self, from: data)

        print(images.value?.count ?? 0)

        completionHandler(images)
    }

    task.resume()
}
