//
//  GameSummaryViewController.swift
//  Coryat-Swift
//
//  Created by Michael Frain on 3/19/15.
//  Copyright (c) 2015 Michael Frain. All rights reserved.
//

import UIKit

class GameSummaryViewController: UIViewController {
    var currentGame: Game!
    
    @IBOutlet var labelScore: UILabel!
    @IBOutlet var labelRecord: UILabel!
    @IBOutlet var labelFinal: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        labelScore.text = "SCORE: $\(currentGame.score) ($\(currentGame.trashScore) TRASH)"
        labelRecord.text = "\(currentGame.correctResponses) CORRECT, \(currentGame.incorrectResponses) INCORRECT"
        var finalString = "FINAL JEOPARDY: "
        if currentGame.finalResponseCorrect.boolValue == true {
            finalString += "CORRECT"
        } else {
            finalString += "INCORRECT"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let error: NSErrorPointer = nil
        currentGame.inProgress = false
        currentGame.isRound2 = false
        currentGame.isFinished = true
        try? currentGame.managedObjectContext!.save()
    }
}
