//
//  MeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Shaurya Sinha on 18/02/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class MeViewController: UIViewController {

    
    @IBAction func onHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let user = User.current!
        let dict = user.dictionary!
        print(dict)
        backgroundImageView.af_setImage(withURL: URL(string: "https://pbs.twimg.com/profile_banners/962400815980957696/1518944968/web")!)
        profileImageView.af_setImage(withURL: URL(string: "https://pbs.twimg.com/profile_images/965151470566821888/NPBJ6RMX_400x400.jpg")!)
        nameLabel.text = user.name
        usernameLabel.text = user.screenName
        if let x = dict["statuses_count"] as? Int{
            tweetCountLabel.text = "\(x)"
        }
        if let y = dict["friends_count"] as? Int{
            followerCountLabel.text = "\(y)"
        }
        followersLabel.text = dict["followers_count"] as? String ?? "0"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
