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
        if segue.identifier == "UnwindNewGame" {
            
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
        return "Yes"
    }
}

extension NewGameViewController: UIPickerViewDelegate {
    
}

extension NewGameViewController: UIPopoverPresentationControllerDelegate {
    
}
