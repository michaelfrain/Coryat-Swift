//
//  FinalJeopardyViewController.swift
//  Coryat-Swift
//
//  Created by Michael Frain on 3/19/15.
//  Copyright (c) 2015 Michael Frain. All rights reserved.
//

import UIKit

class FinalJeopardyViewController: UIViewController {
    @IBOutlet var textFieldResponse: UITextField!
    @IBOutlet var buttonLockResponse: UIButton!
    @IBOutlet var buttonCorrectResponse: UIButton!
    @IBOutlet var buttonIncorrectResponse: UIButton!
    
    var currentGame: Game!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func lockAnswer(sender: UIButton) {
        let alert = UIAlertController(title: "Wait!", message: "Once you lock your response, you cannot unlock it. Are you sure?", preferredStyle: .Alert)
        let confirm = UIAlertAction(title: "OK", style: .Default, handler: {
            self.textFieldResponse.enabled = false
            self.buttonLockResponse.enabled = false
            self.buttonCorrectResponse.enabled = true
            self.buttonIncorrectResponse.enabled = true
            return nil
        }())
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alert.addAction(confirm)
        alert.addAction(cancel)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func setResponseValue(sender: UIButton) {
        if sender == buttonCorrectResponse {
            currentGame.finalResponseCorrect = NSNumber(bool: true)
        } else if sender == buttonIncorrectResponse {
            currentGame.finalResponseCorrect = NSNumber(bool: false)
        }
        self.performSegueWithIdentifier("GameSummarySegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GameSummarySegue" {
            let destinationController = segue.destinationViewController as! GameSummaryViewController
            destinationController.currentGame = currentGame
        }
    }
}
