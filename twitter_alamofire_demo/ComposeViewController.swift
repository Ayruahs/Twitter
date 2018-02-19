//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Shaurya Sinha on 18/02/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    var delegate: ComposeViewControllerDelegate?
    
    @IBOutlet weak var countLabel: UILabel!
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Allow or disallow the new text
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        countLabel.text = "\(newText.characters.count)/140"
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetTextField.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tweetTextField: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextField.delegate = self
        // Do any additional setup after loading the view.
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
