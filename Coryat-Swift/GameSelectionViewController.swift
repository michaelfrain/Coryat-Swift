//
//  GameSelectionViewController.swift
//  Coryat-Swift
//
//  Created by Michael Frain on 2/2/15.
//  Copyright (c) 2015 Michael Frain. All rights reserved.
//

import UIKit

class GameSelectionViewController: UIViewController {
    @IBOutlet var gameTable: UITableView!
    var allGames: Array<Game> {
        let application = UIApplication.shared
        let delegate = application.delegate as! AppDelegate
        let moc = delegate.managedObjectContext
        let gameArray = Game.readAllGames(moc!)
        return gameArray
    }
    
    var selectedIndex = 0
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateGamePopoverSegue" {
            let application = UIApplication.shared
            let delegate = application.delegate as! AppDelegate
            let moc = delegate.managedObjectContext
            
            let destinationController = segue.destination as! NewGameViewController
            destinationController.currentContext = moc
            destinationController.allGames = allGames
        } else if segue.identifier == "GameStartSegue" {
            let currentGame = allGames[selectedIndex]
            let destinationController = segue.destination as! CategoryViewController
            destinationController.currentGame = currentGame
        } else if segue.identifier == "ResumeGameSegue" {
            let destinationController = segue.destination as! GameBoardViewController
            let currentGame = allGames[selectedIndex]
            destinationController.currentGame = currentGame
        } else if segue.identifier == "GameReviewSegue" {
            let destinationController = segue.destination as! GameSummaryViewController
            let currentGame = allGames[selectedIndex]
            destinationController.currentGame = currentGame
        }
    }
    
    // MARK: - IBActions
    @IBAction func editGames(_ sender: UIButton!) {
        
    }
    
    @IBAction func unwindFromNewGamePopover(_ sender: UIStoryboardSegue!) {
        let sourceController = sender.source as! NewGameViewController
        gameTable.reloadData()
    }
    
    @IBAction func unwindFromEndOfGame(_ sender: UIStoryboardSegue!) {
        gameTable.reloadData()
    }
}

extension GameSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.allGames.count
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let game = self.allGames[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY"
        var statusString = "$\(game.score), \(game.correctResponses)/\(game.incorrectResponses)/\(game.noResponses)"
        if !game.inProgress {
            statusString += " (NEW)"
        }
        if game.isFinished {
            statusString += " (FINISHED)"
        }
        let selectionCell = GameSelectionCell.cellForTableView(tableView, withGameDateType: "\(game.stringForEnum(game.gameType.intValue).uppercased()) - \(formatter.string(from: game.gameDate).uppercased())", withGameStatus: statusString)
        cell = selectionCell
        return cell
    }
}

extension GameSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        let selectedGame = allGames[indexPath.row]
        if selectedGame.inProgress {
            self.performSegue(withIdentifier: "ResumeGameSegue", sender: self)
        } else if selectedGame.isFinished {
            self.performSegue(withIdentifier: "GameReviewSegue", sender: self)
        } else {
            self.performSegue(withIdentifier: "GameStartSegue", sender: self)
        }
    }
}
