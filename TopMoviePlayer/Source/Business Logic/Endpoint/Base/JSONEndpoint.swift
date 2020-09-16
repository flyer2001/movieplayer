//
//  JSONEndpoint.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 16.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Apexy

protocol JsonEndpoint: Endpoint, URLRequestBuildable where Content: Decodable {}

extension JsonEndpoint {

    /// Request body encoder.
    internal var encoder: JSONEncoder { return JSONEncoder.default }

    public func content(from response: URLResponse?, with body: Data) throws -> Content {
        let resource = try JSONDecoder.default.decode(ResponseData<Content>.self, from: body)
        return resource.data
    }
}

// MARK: - Response

private struct ResponseData<Resource>: Decodable where Resource: Decodable {
    let data: Resource
}
