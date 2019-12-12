//
//  Extensions.swift
//  Slow News
//
//  Created by Matthew McLaughlin on 12/11/19.
//  Copyright © 2019 Matthew McLaughlin. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self,
                                       resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map
            { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
