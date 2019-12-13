//
//  ArticleViewController.swift
//  Slow News
//
//  Created by Matthew McLaughlin on 12/9/19.
//  Copyright © 2019 Matthew McLaughlin. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    var article: Article!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contentTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = article.title
        authorLabel.text = article.author
        dateLabel.text = article.date
        contentTextView.text = article.content
        
        
    }
    




}
