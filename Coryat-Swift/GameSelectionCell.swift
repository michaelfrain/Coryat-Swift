//
//  GameSelectionCell.swift
//  Coryat-Swift
//
//  Created by Michael Frain on 2/4/15.
//  Copyright (c) 2015 Michael Frain. All rights reserved.
//

import UIKit

class GameSelectionCell: UITableViewCell {

    @IBOutlet var lblGameDateType: UILabel!
    @IBOutlet var lblGameStatus: UILabel!
    
    var gameDateType: String = "" {
        didSet {
            lblGameDateType.text = gameDateType
        }
    }
    var gameStatus: String = "" {
        didSet {
            lblGameStatus.text = gameStatus
        }
    }
    
    class func cellForTableView(_ tableView: UITableView, withGameDateType: String, withGameStatus: String) -> GameSelectionCell {
        var newCell = tableView.dequeueReusableCell(withIdentifier: "GameSelectionCell") as! GameSelectionCell
        
        newCell.gameDateType = withGameDateType
        newCell.gameStatus = withGameStatus
        
        return newCell
    }
}
