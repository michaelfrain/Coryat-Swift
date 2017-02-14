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
    var selectedCell: IndexPath!
    
    var selectedClue = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentScore.text = "Score: \(currentGame.score) - Record: \(currentGame.correctResponses) / \(currentGame.incorrectResponses) / \(currentGame.noResponses)"
        categoryArray = currentGame.currentCategoryArray
        if roundNumber == 1 {
            endRound.setTitle("End Round 1", for: UIControlState())
        } else if roundNumber == 2 {
            endRound.setTitle("End Round 2", for: UIControlState())
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CellSelectionSegue" {
            let destinationController = segue.destination as! ResultViewController
            destinationController.currentGame = currentGame
            destinationController.currentClueValue = selectedClue
            destinationController.cellIndex = selectedCell
        } else if segue.identifier == "UnwindRoundSegue" {
            currentGame.correctArray = []
            currentGame.incorrectArray = []
            currentGame.noAnswerArray = []
        } else if segue.identifier == "FinalJeopardySegue" {
            let destinationController = segue.destination as! FinalJeopardyViewController
            destinationController.currentGame = currentGame
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if identifier == "UnwindRoundSegue" && roundNumber == 2 {
            performSegue(withIdentifier: "FinalJeopardySegue", sender: self)
            return false
        } else if identifier == "FinalJeopardySegue" && roundNumber == 1 {
            return false
        }
        return true
    }
    
    @IBAction func unwindConfirmedClueResult(_ sender: UIStoryboardSegue) {
        let sourceController = sender.source as! ResultViewController
        let previousCellIndex = sourceController.cellIndex
        let previousCell = gameBoard.cellForItem(at: previousCellIndex!) as! GameBoardCell
        if sourceController.result == ResultViewController.LastResult.incorrect {
            previousCell.cellValueLabel.backgroundColor = UIColor.red
        } else if sourceController.result == ResultViewController.LastResult.correct {
            previousCell.cellValueLabel.backgroundColor = UIColor.green
        } else {
            previousCell.cellValueLabel.backgroundColor = UIColor.gray
        }
        previousCell.alreadySelected = true
        currentGame = sourceController.currentGame
        currentScore.text = "Score: \(currentGame.score) - Record: \(currentGame.correctResponses) / \(currentGame.incorrectResponses) / \(currentGame.noResponses)"
    }
    
    @IBAction func unwindCanceledClueResult(_ sender: UIStoryboardSegue) {
        
    }
}

extension GameBoardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
            if currentGame.correctArray.contains(indexPath.item) {
                boardCell.cellValueLabel.backgroundColor = UIColor.green
                boardCell.alreadySelected = true
            } else if currentGame.incorrectArray.contains(indexPath.item) {
                boardCell.cellValueLabel.backgroundColor = UIColor.red
                boardCell.alreadySelected = true
            } else if currentGame.noAnswerArray.contains(indexPath.item) {
                boardCell.cellValueLabel.backgroundColor = UIColor.gray
                boardCell.alreadySelected = true
            } else {
                boardCell.cellValueLabel.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1)
                boardCell.alreadySelected = false
            }
        }
        
        return boardCell
    }
}

extension GameBoardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var boardCell = collectionView.cellForItem(at: indexPath) as! GameBoardCell
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
        if indexPath.item <= 5 {
            let alert = UIAlertController(title: "Category Name", message: "Please type in the new category.", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.currentGame.currentCategoryArray[indexPath.row] = alert.textFields![0].text!
            })
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(action)
            alert.addAction(cancel)
            present(alert, animated: true) {
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            }
        } else {
            self.performSegue(withIdentifier: "CellSelectionSegue", sender: self)
        }
    }
}
