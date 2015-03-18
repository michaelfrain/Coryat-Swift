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
        let application = UIApplication.sharedApplication()
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CreateGamePopoverSegue" {
            let application = UIApplication.sharedApplication()
            let delegate = application.delegate as! AppDelegate
            let moc = delegate.managedObjectContext
            
            let destinationController = segue.destinationViewController as! NewGameViewController
            destinationController.currentContext = moc
            destinationController.allGames = allGames
        } else if segue.identifier == "GameStartSegue" {
            let currentGame = allGames[selectedIndex]
            let destinationController = segue.destinationViewController as! CategoryViewController
            destinationController.currentGame = currentGame
        } else if segue.identifier == "GameContinueSegue" {
            
        }
    }
    
    // MARK: - IBActions
    @IBAction func editGames(sender: UIButton!) {
        
    }
    
    @IBAction func unwindFromNewGamePopover(sender: UIStoryboardSegue!) {
        let sourceController = sender.sourceViewController as! NewGameViewController
        gameTable.reloadData()
    }
}

extension GameSelectionViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.allGames.count
        return rows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let game = self.allGames[indexPath.row]
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY"
        let selectionCell = GameSelectionCell.cellForTableView(tableView, withGameDateType: "\(game.stringForEnum(game.gameType.integerValue).uppercaseString) - \(formatter.stringFromDate(game.gameDate).uppercaseString)", withGameStatus: "$\(game.score), \(game.correctResponses)/\(game.incorrectResponses)/\(game.noResponses)")
        cell = selectionCell
        return cell
    }
}

extension GameSelectionViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
        self.performSegueWithIdentifier("GameStartSegue", sender: self)
    }
}
