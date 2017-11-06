//
//  FirstViewController.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/5/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit

class FeedVC: UIViewController
{
    
    @IBOutlet weak var feedTableView: UITableView!
    
    var messageArray = [Message]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        feedTableView.delegate = self
        feedTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataService.instance.getAllFeedMessages //Download all of the messages from Firebase.
            { (returnedMessagesArray) in
                self.messageArray = returnedMessagesArray //Set the value of our variable array to the values of the messages we get from our getAllFeedMessages function.
                self.feedTableView.reloadData()
            }
    }
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = feedTableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCell
            else
            {
                return UITableViewCell() //Return an empty cell if we can't get our cell
            }
        let image = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row] //Pull out all of the messages at each index that we put in from getAllFeedMessages.
        
        cell.configureCell(profileImg: image!, email: message.senderId, content: message.content)
        return cell
    }
    
    
}
