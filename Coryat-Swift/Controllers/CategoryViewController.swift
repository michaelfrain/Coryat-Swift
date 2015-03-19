//
//  CategoryViewController.swift
//  Coryat-Swift
//
//  Created by Michael Frain on 3/18/15.
//  Copyright (c) 2015 Michael Frain. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    var currentGame: Game!
    @IBOutlet var txtCategory1: UITextField!
    @IBOutlet var txtCategory2: UITextField!
    @IBOutlet var txtCategory3: UITextField!
    @IBOutlet var txtCategory4: UITextField!
    @IBOutlet var txtCategory5: UITextField!
    @IBOutlet var txtCategory6: UITextField!
    
    var isRound2 = false
    
    override func viewDidLoad() {
        currentGame.currentCategoryArray = ["", "", "", "", "", ""]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        txtCategory1.text = ""
        txtCategory2.text = ""
        txtCategory3.text = ""
        txtCategory4.text = ""
        txtCategory5.text = ""
        txtCategory6.text = ""
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "BeginGameSegue" {
            let destinationController = segue.destinationViewController as! GameBoardViewController
            destinationController.currentGame = currentGame
            currentGame.inProgress = true
            if isRound2 == false {
                destinationController.roundNumber = 1
            } else {
                destinationController.roundNumber = 2
            }
            currentGame.correctArray = []
            currentGame.incorrectArray = []
            currentGame.noAnswerArray = []
        }
    }
    
    @IBAction func unwindForRound2(sender: UIStoryboardSegue) {
        isRound2 = true
        let sourceController = sender.sourceViewController as! GameBoardViewController
        currentGame = sourceController.currentGame
        currentGame.isRound2 = true
    }
}

extension CategoryViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        switch textField {
        case txtCategory1:
            currentGame.currentCategoryArray[0] = txtCategory1.text
            
        case txtCategory2:
            currentGame.currentCategoryArray[1] = txtCategory2.text
            
        case txtCategory3:
            currentGame.currentCategoryArray[2] = txtCategory3.text
            
        case txtCategory4:
            currentGame.currentCategoryArray[3] = txtCategory4.text
            
        case txtCategory5:
            currentGame.currentCategoryArray[4] = txtCategory5.text
            
        case txtCategory6:
            currentGame.currentCategoryArray[5] = txtCategory6.text
            
        default:
            return
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case txtCategory1:
            txtCategory2.becomeFirstResponder()
            
        case txtCategory2:
            txtCategory3.becomeFirstResponder()
            
        case txtCategory3:
            txtCategory4.becomeFirstResponder()
            
        case txtCategory4:
            txtCategory5.becomeFirstResponder()
            
        case txtCategory5:
            txtCategory6.becomeFirstResponder()
            
        case txtCategory6:
            textField.resignFirstResponder()
            
        default:
            textField.resignFirstResponder()
            
        }
        return true
    }
}
