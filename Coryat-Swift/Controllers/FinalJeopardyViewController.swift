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
    
    @IBAction func lockAnswer(_ sender: UIButton) {
        let alert = UIAlertController(title: "Wait!", message: "Once you lock your response, you cannot unlock it. Are you sure?", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "OK", style: .default, handler: {
            self.textFieldResponse.isEnabled = false
            self.buttonLockResponse.isEnabled = false
            self.buttonCorrectResponse.isEnabled = true
            self.buttonIncorrectResponse.isEnabled = true
            return nil
        }())
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(confirm)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func setResponseValue(_ sender: UIButton) {
        if sender == buttonCorrectResponse {
            currentGame.finalResponseCorrect = NSNumber(value: true as Bool)
        } else if sender == buttonIncorrectResponse {
            currentGame.finalResponseCorrect = NSNumber(value: false as Bool)
        }
        self.performSegue(withIdentifier: "GameSummarySegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameSummarySegue" {
            let destinationController = segue.destination as! GameSummaryViewController
            destinationController.currentGame = currentGame
        }
    }
}
