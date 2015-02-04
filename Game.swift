//
//  Coryat-Swift.swift
//  Coryat-Swift
//
//  Created by Michael Frain on 2/3/15.
//  Copyright (c) 2015 Michael Frain. All rights reserved.
//

import Foundation
import CoreData

class Game: NSManagedObject {

    @NSManaged var gameDate: NSDate
    @NSManaged var score: NSNumber
    @NSManaged var correctResponses: NSNumber
    @NSManaged var incorrectResponses: NSNumber
    @NSManaged var noResponses: NSNumber
    @NSManaged var finalResponseCorrect: NSNumber
    @NSManaged var trashCorrect: NSNumber
    @NSManaged var trashScore: NSNumber
    @NSManaged var clues: NSSet
}
