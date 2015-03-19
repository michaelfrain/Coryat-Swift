//
//  ResultViewController.swift
//  Coryat-Swift
//
//  Created by Michael Frain on 3/18/15.
//  Copyright (c) 2015 Michael Frain. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var currentGame: Game!
    var currentClueValue = 0
    
    enum LastResult {
        case Correct
        case Incorrect
        case NoAnswer
    }
    
    var result = LastResult.NoAnswer
    
    @IBOutlet var labelCurrentScore: UILabel!
    @IBOutlet var labelCurrentClue: UILabel!
    @IBOutlet var labelNewScore: UILabel!
    @IBOutlet var labelResponse: UILabel!
    
    @IBOutlet var switchDailyDouble: UISwitch!
    @IBOutlet var switchLachTrash: UISwitch!
    
    @IBOutlet var segmentResult: UISegmentedControl!
    
    var cellIndex: NSIndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentResult.addTarget(self, action: Selector(stringLiteral: "clueResultSelected:"), forControlEvents: .ValueChanged)
        labelCurrentScore.text = "Current total: $\(currentGame.score)"
        labelCurrentClue.text = "Current clue: $\(currentClueValue)"
        labelNewScore.hidden = true
        labelResponse.hidden = true
    }

    @IBAction func cancelClue() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func clueResultSelected(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            labelResponse.hidden = false
            labelResponse.text = "Correct response: +$\(currentClueValue)"
            labelNewScore.hidden = false
            labelNewScore.text = "New total: $\(currentGame.score.integerValue + currentClueValue)"
            result = LastResult.Correct
            
        case 1:
            labelResponse.hidden = false
            labelNewScore.hidden = false
            if switchDailyDouble.on == true {
                labelResponse.text = "No penalty for incorrect response"
                labelNewScore.text = "New total: $\(currentGame.score)"
                result = LastResult.NoAnswer
            } else {
                labelResponse.text = "Incorrect response: $-\(currentClueValue)"
                labelNewScore.text = "New total: $\(currentGame.score.integerValue - currentClueValue)"
                result = LastResult.Incorrect
            }
            
        case 2:
            labelResponse.hidden = false
            labelResponse.text = "No response: $0"
            labelNewScore.hidden = false
            labelNewScore.text = "New total: $\(currentGame.score)"

        default:
            return
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UnwindConfirmedClueSegue" {
            switch segmentResult.selectedSegmentIndex {
            case 0:
                currentGame.score = NSNumber(integer: currentGame.score.integerValue + currentClueValue)
                currentGame.correctResponses = NSNumber(integer: currentGame.correctResponses.integerValue + 1)
                if switchLachTrash.on {
                    currentGame.trashCorrect = NSNumber(integer: currentGame.trashCorrect.integerValue + 1)
                    currentGame.trashScore = NSNumber(integer: currentGame.trashScore.integerValue + currentClueValue)
                }
                currentGame.correctArray.append(cellIndex.item)
                
            case 1:
                if switchDailyDouble.on {
                    currentGame.noResponses = NSNumber(integer: currentGame.noResponses.integerValue + 1)
                    currentGame.noAnswerArray.append(cellIndex.item)
                } else {
                    currentGame.incorrectResponses = NSNumber(integer: currentGame.incorrectResponses.integerValue + 1)
                    currentGame.score = NSNumber(integer: currentGame.score.integerValue - currentClueValue)
                    currentGame.incorrectArray.append(cellIndex.item)
                }
                
            default:
                currentGame.noResponses = NSNumber(integer: currentGame.noResponses.integerValue + 1)
                currentGame.noAnswerArray.append(cellIndex.item)
            }
            
            let error = NSErrorPointer()
            if currentGame.managedObjectContext!.save(error) {
                NSLog("Game \(currentGame.gameIndex) saved!")
            } else {
                NSLog("Game could not be saved!")
            }
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "UnwindConfirmedClueSegue" {
            if segmentResult.selectedSegmentIndex == -1 {
                let alert = UIAlertController(title: "Wait!", message: "You must select an outcome from the current clue, or cancel.", preferredStyle: .Alert)
                let dismissAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                alert.addAction(dismissAction)
                self.presentViewController(alert, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    
    @IBAction func dailyDoubleChange(sender: UISwitch) {
        clueResultSelected(segmentResult)
    }
}
