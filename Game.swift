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

    @NSManaged var gameType: NSNumber
    @NSManaged var gameDate: NSDate
    @NSManaged var gameIndex: NSNumber
    @NSManaged var score: NSNumber
    @NSManaged var correctResponses: NSNumber
    @NSManaged var incorrectResponses: NSNumber
    @NSManaged var noResponses: NSNumber
    @NSManaged var finalResponseCorrect: NSNumber
    @NSManaged var trashCorrect: NSNumber
    @NSManaged var trashScore: NSNumber
    @NSManaged var clues: NSSet
    
    class func readAllGames(context: NSManagedObjectContext) -> Array<Game> {
        let entityDescription = NSEntityDescription.entityForName("Game", inManagedObjectContext: context)
        var fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        
        let lowIndex = 0
        let predicate = NSPredicate(format: "gameIndex >= \(lowIndex)")
        fetchRequest.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "gameIndex", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let errorPointer = NSErrorPointer()
        let gameArray = context.executeFetchRequest(fetchRequest, error: errorPointer) as Array<Game>
        return gameArray
    }
}
