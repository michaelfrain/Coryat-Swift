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
        let delegate = application.delegate as AppDelegate
        let moc = delegate.managedObjectContext
        let gameArray = Game.readAllGames(moc!)
        return gameArray
    }
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - IBActions
    @IBAction func editGames(sender: UIButton!) {
        
    }
    
    // MARK: - UITableViewDataSource and UITableViewDelegate Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.allGames.count
        return rows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let game = self.allGames[indexPath.row]
        
    }
}
