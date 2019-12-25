//
//  FeedTableViewController.swift
//  Slow News
//
//  Created by Matthew McLaughlin on 12/9/19.
//  Copyright © 2019 Matthew McLaughlin. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {
    var newsArticles = [Article]()
    let articleController = ArticleController()
    override func viewDidLoad() {
        super.viewDidLoad()
        articleController.fetchNews { (newsArticles: NewsArticles?) in
            if let newsArticles = newsArticles {
                self.updateUI(with: newsArticles)
            }
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCellIdentifier", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FeedSegue" {
            let articleViewConroller = segue.destination as! ArticleViewController
            articleViewConroller.article = newsArticles[tableView.indexPathForSelectedRow!.row]
        }
    }
    func updateUI(with newsArticles: NewsArticles){
        DispatchQueue.main.async {
            self.newsArticles = newsArticles.articles
            self.tableView.reloadData()
        }
    }
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath){
        let article = newsArticles[indexPath.row]
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.description
    }
}
