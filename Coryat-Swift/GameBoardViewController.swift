//
//  GameBoardViewController.swift
//  Coryat-Swift
//
//  Created by Michael Frain on 3/18/15.
//  Copyright (c) 2015 Michael Frain. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {
    var currentGame: Game!
    
    @IBOutlet var gameBoard: UICollectionView!
    @IBOutlet var endRound: UIButton!
    @IBOutlet var currentScore: UILabel!
    
    var categoryArray: Array<String>!
    var roundNumber = 1
    var selectedCell: NSIndexPath!
    
    var selectedClue = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentScore.text = "Score: \(currentGame.score) - Record: \(currentGame.correctResponses) / \(currentGame.incorrectResponses) / \(currentGame.noResponses)"
        categoryArray = currentGame.currentCategoryArray
        if roundNumber == 1 {
            endRound.setTitle("End Round 1", forState: .Normal)
        } else if roundNumber == 2 {
            endRound.setTitle("End Round 2", forState: .Normal)
        } else {
            assert(false, "Only two rounds, something went wrong.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CellSelectionSegue" {
            let destinationController = segue.destinationViewController as! ResultViewController
            destinationController.currentGame = currentGame
            destinationController.currentClueValue = selectedClue
            destinationController.cellIndex = selectedCell
        } else if segue.identifier == "UnwindRoundSegue" {
            currentGame.correctArray = []
            currentGame.incorrectArray = []
            currentGame.noAnswerArray = []
        }
    }

    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "UnwindRoundSegue" && roundNumber == 2 {
            return false
        } else if identifier == "FinalJeopardySegue" && roundNumber == 1 {
            return false
        }
        return true
    }
    
    @IBAction func unwindConfirmedClueResult(sender: UIStoryboardSegue) {
        let sourceController = sender.sourceViewController as! ResultViewController
        let previousCellIndex = sourceController.cellIndex
        let previousCell = gameBoard.cellForItemAtIndexPath(previousCellIndex) as! GameBoardCell
        if sourceController.result == ResultViewController.LastResult.Incorrect {
            previousCell.cellValueLabel.backgroundColor = UIColor.redColor()
        } else if sourceController.result == ResultViewController.LastResult.Correct {
            previousCell.cellValueLabel.backgroundColor = UIColor.greenColor()
        } else {
            previousCell.cellValueLabel.backgroundColor = UIColor.grayColor()
        }
        previousCell.alreadySelected = true
        currentGame = sourceController.currentGame
        currentScore.text = "Score: \(currentGame.score) - Record: \(currentGame.correctResponses) / \(currentGame.incorrectResponses) / \(currentGame.noResponses)"
    }
    
    @IBAction func unwindCanceledClueResult(sender: UIStoryboardSegue) {
        
    }
}

extension GameBoardViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cellValueString: String
        if roundNumber == 1 {
            switch indexPath.item {
            case 0...5:
                cellValueString = currentGame.currentCategoryArray[indexPath.item]
                
            case 6...11:
                cellValueString = "$200"
                
            case 12...17:
                cellValueString = "$400"
                
            case 18...23:
                cellValueString = "$600"
                
            case 24...29:
                cellValueString = "$800"
                
            case 30...35:
                cellValueString = "$1000"
                
            default:
                cellValueString = ""
            }
        } else {
            switch indexPath.item {
            case 0...5:
                cellValueString = currentGame.currentCategoryArray[indexPath.item]
                
            case 6...11:
                cellValueString = "$400"
                
            case 12...17:
                cellValueString = "$800"
                
            case 18...23:
                cellValueString = "$1200"
                
            case 24...29:
                cellValueString = "$1600"
                
            case 30...35:
                cellValueString = "$2000"
                
            default:
                cellValueString = ""
            }
        }
        
        let boardCell = GameBoardCell.cellForCollectionView(collectionView, indexPath: indexPath, cellValue: cellValueString)
        
        if currentGame.inProgress {
            if find(currentGame.correctArray, indexPath.item) != nil {
                boardCell.cellValueLabel.backgroundColor = UIColor.greenColor()
                boardCell.alreadySelected = true
            } else if find(currentGame.incorrectArray, indexPath.item) != nil {
                boardCell.cellValueLabel.backgroundColor = UIColor.redColor()
                boardCell.alreadySelected = true
            } else if find(currentGame.noAnswerArray, indexPath.item) != nil {
                boardCell.cellValueLabel.backgroundColor = UIColor.grayColor()
                boardCell.alreadySelected = true
            }
        }
        
        return boardCell
    }
}

extension GameBoardViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var boardCell = collectionView.cellForItemAtIndexPath(indexPath) as! GameBoardCell
        if boardCell.alreadySelected == true {
            return
        }
        
        if roundNumber == 1 {
            switch indexPath.item {
            case 6...11:
                selectedClue = 200
                
            case 12...17:
                selectedClue = 400
                
            case 18...23:
                selectedClue = 600
                
            case 24...29:
                selectedClue = 800
                
            case 30...35:
                selectedClue = 1000
                
            default:
                selectedClue = 0
            }
        } else if roundNumber == 2 {
            switch indexPath.item {
            case 6...11:
                selectedClue = 400
                
            case 12...17:
                selectedClue = 800
                
            case 18...23:
                selectedClue = 1200
                
            case 24...29:
                selectedClue = 1600
                
            case 30...35:
                selectedClue = 2000
                
            default:
                selectedClue = 0
            }
        }
        selectedCell = indexPath
        if indexPath.item > 5 {
            self.performSegueWithIdentifier("CellSelectionSegue", sender: self)
        }
    }
}
