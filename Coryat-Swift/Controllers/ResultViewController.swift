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
        case correct
        case incorrect
        case noAnswer
    }
    
    var result = LastResult.noAnswer
    
    @IBOutlet var labelCurrentScore: UILabel!
    @IBOutlet var labelCurrentClue: UILabel!
    @IBOutlet var labelNewScore: UILabel!
    @IBOutlet var labelResponse: UILabel!
    
    @IBOutlet var switchDailyDouble: UISwitch!
    @IBOutlet var switchLachTrash: UISwitch!
    
    @IBOutlet var segmentResult: UISegmentedControl!
    
    var cellIndex: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentResult.addTarget(self, action: #selector(ResultViewController.clueResultSelected(_:)), for: .valueChanged)
        labelCurrentScore.text = "Current total: $\(currentGame.score)"
        labelCurrentClue.text = "Current clue: $\(currentClueValue)"
        labelNewScore.isHidden = true
        labelResponse.isHidden = true
    }

    @IBAction func cancelClue() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func clueResultSelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            labelResponse.isHidden = false
            labelResponse.text = "Correct response: +$\(currentClueValue)"
            labelNewScore.isHidden = false
            labelNewScore.text = "New total: $\(currentGame.score.intValue + currentClueValue)"
            result = LastResult.correct
            
        case 1:
            labelResponse.isHidden = false
            labelNewScore.isHidden = false
            if switchDailyDouble.isOn == true {
                labelResponse.text = "No penalty for incorrect response"
                labelNewScore.text = "New total: $\(currentGame.score)"
                result = LastResult.noAnswer
            } else {
                labelResponse.text = "Incorrect response: $-\(currentClueValue)"
                labelNewScore.text = "New total: $\(currentGame.score.intValue - currentClueValue)"
                result = LastResult.incorrect
            }
            
        case 2:
            labelResponse.isHidden = false
            labelResponse.text = "No response: $0"
            labelNewScore.isHidden = false
            labelNewScore.text = "New total: $\(currentGame.score)"

        default:
            return
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindConfirmedClueSegue" {
            switch segmentResult.selectedSegmentIndex {
            case 0:
                currentGame.score = NSNumber(value: currentGame.score.intValue + currentClueValue as Int)
                currentGame.correctResponses = NSNumber(value: currentGame.correctResponses.intValue + 1 as Int)
                if switchLachTrash.isOn {
                    currentGame.trashCorrect = NSNumber(value: currentGame.trashCorrect.intValue + 1 as Int)
                    currentGame.trashScore = NSNumber(value: currentGame.trashScore.intValue + currentClueValue as Int)
                }
                currentGame.correctArray.append(cellIndex.item)
                
            case 1:
                if switchDailyDouble.isOn {
                    currentGame.noResponses = NSNumber(value: currentGame.noResponses.intValue + 1 as Int)
                    currentGame.noAnswerArray.append(cellIndex.item)
                } else {
                    currentGame.incorrectResponses = NSNumber(value: currentGame.incorrectResponses.intValue + 1 as Int)
                    currentGame.score = NSNumber(value: currentGame.score.intValue - currentClueValue as Int)
                    currentGame.incorrectArray.append(cellIndex.item)
                }
                
            default:
                currentGame.noResponses = NSNumber(value: currentGame.noResponses.intValue + 1 as Int)
                currentGame.noAnswerArray.append(cellIndex.item)
            }
            try? currentGame.managedObjectContext!.save()
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if identifier == "UnwindConfirmedClueSegue" {
            if segmentResult.selectedSegmentIndex == -1 {
                let alert = UIAlertController(title: "Wait!", message: "You must select an outcome from the current clue, or cancel.", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    
    @IBAction func dailyDoubleChange(_ sender: UISwitch) {
        clueResultSelected(segmentResult)
    }
}
