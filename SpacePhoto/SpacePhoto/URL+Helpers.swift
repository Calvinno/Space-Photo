//
//  URL+Helpers.swift
//  SpacePhoto
//
//  Created by Calvin Cantin on 2019-02-06.
//  Copyright © 2019 Calvin Cantin. All rights reserved.
//

import Foundation
extension URL
{
    func withQueries(_ queries: [String: String]) -> URL?
    {
        var component = URLComponents(url: self, resolvingAgainstBaseURL: true)
        component?.queryItems = queries.compactMap{ URLQueryItem(name: $0.0, value: $0.1)}
        return component?.url
    }
}
