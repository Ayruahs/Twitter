//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var rtButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBAction func replyButton(_ sender: Any) {
        
    }
    @IBAction func retweetButton(_ sender: Any) {
        if(tweet.retweeted){
            tweet.retweeted = false
            tweet.retweetCount -= 1
            
            APIManager.shared.unRetweet(tweet){(tweet: Tweet?, error: Error? ) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
            let image = UIImage(named: "retweet-icon")
            rtButton.setImage(image, for: .normal)
            rtButton.setTitle("\(tweet.retweetCount)", for: .normal)
        }else{
            tweet.retweeted = true
            tweet.retweetCount += 1
            
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
            let image = UIImage(named: "retweet-icon-green")
            rtButton.setImage(image, for: .normal)
            rtButton.setTitle("\(tweet.retweetCount)", for: .normal)
        }
        
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
            }
        }
    }
    @IBAction func favoriteButton(_ sender: Any) {
        if(tweet.favorited!){
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            
            APIManager.shared.unFavorite(tweet){(tweet: Tweet?, error: Error? ) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
            let image = UIImage(named: "favor-icon")
            favButton.setImage(image, for: .normal)
            favButton.setTitle("\(tweet.favoriteCount!)", for: .normal)
        }else{
            tweet.favorited = true
            tweet.favoriteCount! += 1
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            let image = UIImage(named: "favor-icon-red")
            favButton.setImage(image, for: .normal)
            favButton.setTitle("\(tweet.favoriteCount!)", for: .normal)
        }
        
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
            }
        }
    }
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            nameLabel.text = tweet.user.name
            usernameLabel.text = "@" + tweet.user.screenName!
            dateLabel.text = tweet.createdAtString
            rtButton.setTitle("\(tweet.retweetCount)", for: .normal)
            
            var count = "0"
            if let stringCount = tweet.favoriteCount{
                count = "\(stringCount)"
            }
            favButton.setTitle(count, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.bounds.height / 2
        profilePictureImageView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
