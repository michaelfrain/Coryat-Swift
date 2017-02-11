//
//  GameBoardCell.swift
//  Coryat-Swift
//
//  Created by Michael Frain on 3/18/15.
//  Copyright (c) 2015 Michael Frain. All rights reserved.
//

import UIKit

class GameBoardCell: UICollectionViewCell {
    @IBOutlet var cellValueLabel: UILabel!
    
    var cellValueString: String = "" {
        didSet {
            cellValueLabel.text = cellValueString
        }
    }
    
    var alreadySelected = false
    
    class func cellForCollectionView(_ collectionView: UICollectionView, indexPath: IndexPath, cellValue: String) -> GameBoardCell {
        var newCell: GameBoardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameBoardCell", for: indexPath) as! GameBoardCell
        
        newCell.cellValueString = cellValue
        
        return newCell
    }
}
