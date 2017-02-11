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
        newGame.gameIndex = NSNumber(value: allGames.count + 1 as Int)
        NSLog("Game \(newGame.gameIndex.intValue) created")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindNewGame" {
            newGame.gameDate = datePicker.date
            let error: NSErrorPointer = nil
            try? currentContext.save()
        }
    }
}

extension NewGameViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Game.GameType.numberOfGameTypes.hashValue
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        let gameType = Game.GameType(rawValue: row)
        let typeString = newGame.stringForEnum(gameType!.hashValue)
        return typeString
    }
}

extension NewGameViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let gameType = Game.GameType(rawValue: row)
        newGame.gameType = NSNumber(value: gameType!.hashValue as Int)
    }
}

extension NewGameViewController: UIPopoverPresentationControllerDelegate {
    
}
