//
//  Article.swift
//  Slow News
//
//  Created by Matthew McLaughlin on 12/11/19.
//  Copyright © 2019 Matthew McLaughlin. All rights reserved.
//

import Foundation

struct NewsArticles: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}

struct Article: Codable, Hashable {
    var title: String?
    var author: String?
    var description: String?
    var date: String?
    var content: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case description
        case date = "publishedAt"
        case content
    }
    
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:CodingKeys.self)
        self.title = try? valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.author = try? valueContainer.decode(String.self, forKey: CodingKeys.author)
        self.description = try? valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.date = try? valueContainer.decode(String.self, forKey: CodingKeys.date)
        self.content = try? valueContainer.decode(String.self, forKey: CodingKeys.content)
    }
}
