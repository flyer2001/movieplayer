//
//  PopularFilmsEndpoint.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 16.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Foundation

/// Endpoint для получения списка популярных фильмов
struct PopularFilmsEndpoint: JsonEndpoint {

    typealias Content = [Film]
    let page: Int

    func makeRequest() throws -> URLRequest {
        let queryItem = [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name: "language", value: Constants.russianLocale),
            URLQueryItem(name: "page", value: String(page))
        ]
        var request = get(URL(string: "movie/popular")!, queryItems: queryItem)
        request.timeoutInterval = Constants.timeOutIntervale

        return request
    }

    func content(from response: URLResponse?, with body: Data) throws -> [Film] {
        let decoder = JSONDecoder.default
        let resource = try decoder.decode(ResponseData.self, from: body)
        return resource.results
    }


}

private struct ResponseData: Decodable {
    let results: [Film]
}
