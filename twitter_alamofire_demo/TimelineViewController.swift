//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate {
    func did(post: Tweet) {

    }
    
    @IBAction func onProfile(_ sender: Any) {
        performSegue(withIdentifier: "profile", sender: nil)
    }
    
    var tweets: [Tweet] = []
    
    @IBAction func onCompose(_ sender: Any) {
        performSegue(withIdentifier: "compose", sender: nil)
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        if(cell.tweet.favorited!){
            if let image = UIImage(named: "favor-icon-red"){
                cell.favButton.setImage(image, for: .normal)
            }
        }else{
            if let image = UIImage(named: "favor-icon"){
                cell.favButton.setImage(image, for: .normal)
            }
        }
        
        let urlString = URL(string: cell.tweet.profilePictureURL)
        cell.profilePictureImageView.af_setImage(withURL: urlString!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapLogout(_ sender: Any) {
        User.current = nil
        APIManager.shared.logout()
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl){
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
        refreshControl.endRefreshing()
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if (segue.identifier == "showDetail"){
            let destination = segue.destination as! DetailViewController
            destination.tweet = tweets[(tableView.indexPathForSelectedRow?.row)!]
        }
        
        if (segue.identifier == "compose"){
            let destination = segue.destination as! ComposeViewController
            destination.delegate = self
        }
        
    }
    
    
}
