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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentScore.text = "Score: \(currentGame.score) - Record: \(currentGame.correctResponses) / \(currentGame.incorrectResponses) / \(currentGame.noResponses)"
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GameBoardViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return nil
    }
}
