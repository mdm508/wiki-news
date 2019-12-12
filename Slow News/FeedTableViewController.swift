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
        // #warning Incomplete implementation, return the number of sections
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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

  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
