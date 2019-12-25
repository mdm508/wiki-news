//
//  HistoryTableViewController.swift
//  Slow News
//
//  Created by Matthew McLaughlin on 12/9/19.
//  Copyright © 2019 Matthew McLaughlin. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    var newsArticles = [Article]() 
    var observers = Set<NSObject>()
    override func viewDidLoad() {
        super.viewDidLoad()
        newsArticles = Array(ArticleController.shared.savedArticles)
    }
    override func viewDidAppear(_ animated: Bool) {
        let obs = NotificationCenter.default.addObserver(forName: ArticleController.articleSavedNotification, object: nil, queue: nil, using: { [unowned self] _ in
            self.newsArticles = Array(ArticleController.shared.savedArticles)
            self.tableView.reloadData()
        })
        self.observers.insert(obs as! NSObject)
    }
    deinit {
        for o in self.observers {
             NotificationCenter.default.removeObserver(o)
         }
         self.observers.removeAll()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCellIdentifier", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HistorySegue" {
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


