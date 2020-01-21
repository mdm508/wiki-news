//
//  ArticleController.swift
//  Slow News
//
//  Created by Matthew McLaughlin on 12/11/19.
//  Copyright © 2019 Matthew McLaughlin. All rights reserved.
//


import Foundation

class ArticleController {
    static let shared = ArticleController()
    var savedArticles: Set<Article> = [] {
        didSet {
            NotificationCenter.default.post(name: ArticleController.articleSavedNotification, object: self)
        }
    }
    let baseURL = URL(string: "https://newsapi.org/v2/top-headlines")!
    func fetchNews(completionHandler: @escaping (NewsArticles?) -> Void){
        let query: [String: String] = [
            "apiKey" : API_KEY,
            "country": "us"
        ]
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                let newsInfo = try! jsonDecoder.decode(NewsArticles.self,
                                                        from: data)
                completionHandler(newsInfo)
            } else {
                print("Either no data was returned or data was not properly decoded")
                completionHandler(nil)
            }
        }
        task.resume()
    }
    func addToSavedArticles(articleToAdd articleToSave: Article){
        self.savedArticles.insert(articleToSave)
    }
}

extension ArticleController {
    static let articleSavedNotification = Notification.Name("articleSaved")
}


