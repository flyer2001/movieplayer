//
//  VideoEndpoint.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 18.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Foundation

/// Endpoint для получения ссылок на видео
struct VideoEndpoint: JsonEndpoint {

    typealias Content = [Video]
    let id: Int

    func makeRequest() throws -> URLRequest {
        let queryItem = [ URLQueryItem(name: "api_key", value: Constants.apiKey)]
        let request = get(URL(string: "movie/\(id)/videos")!, queryItems: queryItem)

        return request
    }

    func content(from response: URLResponse?, with body: Data) throws -> [Video] {
        let decoder = JSONDecoder.default
        let resource = try decoder.decode(ResponseData.self, from: body)
        return resource.results
    }
}

private struct ResponseData: Decodable {
    let results: [Video]
}
