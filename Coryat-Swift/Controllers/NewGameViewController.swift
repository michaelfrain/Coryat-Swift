//
//  NewGameViewController.swift
//  Coryat-Swift
//
//  Created by Michael Frain on 2/8/15.
//  Copyright (c) 2015 Michael Frain. All rights reserved.
//

import UIKit
import CoreData

class NewGameViewController: UIViewController {
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var gameTypePicker: UIPickerView!
    
    var currentContext: NSManagedObjectContext!
    var allGames: Array<Game>!
    var newGame: Game!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 600, height: 469)
        newGame = Game.createGame(currentContext)
        newGame.gameIndex = NSNumber(integer: allGames.count + 1)
        NSLog("Game \(newGame.gameIndex.integerValue) created")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UnwindNewGame" {
            newGame.gameDate = datePicker.date
            let error = NSErrorPointer()
            if currentContext.save(error) == true {
                NSLog("Game \(newGame.gameIndex) saved!")
            } else {
                NSLog("Game could not be saved!")
            }
        }
    }
}

extension NewGameViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Game.GameType.NumberOfGameTypes.hashValue
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        let gameType = Game.GameType(rawValue: row)
        let typeString = newGame.stringForEnum(gameType!.hashValue)
        return typeString
    }
}

extension NewGameViewController: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let gameType = Game.GameType(rawValue: row)
        newGame.gameType = NSNumber(integer: gameType!.hashValue)
    }
}

extension NewGameViewController: UIPopoverPresentationControllerDelegate {
    
}
