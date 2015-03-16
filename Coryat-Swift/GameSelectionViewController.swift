//
//  GameSelectionViewController.swift
//  Coryat-Swift
//
//  Created by Michael Frain on 2/2/15.
//  Copyright (c) 2015 Michael Frain. All rights reserved.
//

import UIKit

class GameSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var allGames: Array<Game> {
        let application = UIApplication.sharedApplication()
        let delegate = application.delegate as! AppDelegate
        let moc = delegate.managedObjectContext
        let gameArray = Game.readAllGames(moc!)
        return gameArray
    }
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
            
        }
    }
    
    // MARK: - IBActions
    @IBAction func editGames(sender: UIButton!) {
        
    }
    
    @IBAction func unwindFromNewGamePopover(sender: UIStoryboardSegue!) {
        let sourceController = sender.sourceViewController as! NewGameViewController
        NSLog("Game created!")
    }
    
    // MARK: - UITableViewDataSource and UITableViewDelegate Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.allGames.count
        return rows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let game = self.allGames[indexPath.row]
        let selectionCell = GameSelectionCell.cellForTableView(tableView, withGameDateType: game.stringForEnum(game.gameType.integerValue), withGameStatus: "")
        cell = selectionCell
        return cell
    }
}
