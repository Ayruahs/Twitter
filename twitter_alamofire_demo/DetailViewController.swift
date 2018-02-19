//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Shaurya Sinha on 17/02/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {
    var tweet: Tweet?
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        usernameLabel.text = tweet?.user.screenName
        nameLabel.text = tweet?.user.name
        tweetLabel.text = tweet?.text
        dateLabel.text = tweet?.createdAtString
        if let v = tweet?.retweetCount{
            retweetCountLabel.text = "\(v)"
        }
        
        if let u = tweet?.favoriteCount{
            favoriteLabel.text = "\(u)"
        }
    
        profilePictureImageView.af_setImage(withURL: URL(string: (tweet?.profilePictureURL)!)!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
