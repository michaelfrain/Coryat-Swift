//
//  Coryat-Swift.swift
//  Coryat-Swift
//
//  Created by Michael Frain on 2/7/15.
//  Copyright (c) 2015 Michael Frain. All rights reserved.
//

import Foundation
import CoreData

class Game: NSManagedObject {

    @NSManaged var correctResponses: NSNumber
    @NSManaged var finalResponseCorrect: NSNumber
    @NSManaged var gameDate: NSDate
    @NSManaged var gameIndex: NSNumber
    @NSManaged var gameType: NSNumber
    @NSManaged var incorrectResponses: NSNumber
    @NSManaged var noResponses: NSNumber
    @NSManaged var score: NSNumber
    @NSManaged var trashCorrect: NSNumber
    @NSManaged var trashScore: NSNumber
    @NSManaged var clues: NSOrderedSet
    @NSManaged var inProgress: Bool
    @NSManaged var isRound2: Bool
    @NSManaged var correctArray: Array<Int>
    @NSManaged var incorrectArray: Array<Int>
    @NSManaged var noAnswerArray: Array<Int>
    @NSManaged var currentCategoryArray: Array<String>
    
    enum GameType: Int {
        case RegularPlay = 0, TournamentOfChampions, CollegeTournament, TeenTournament, TeachersTournament, KidsWeek, NumberOfGameTypes
    }

    class func createGame(context: NSManagedObjectContext) -> Game {
        let newGame = NSEntityDescription.insertNewObjectForEntityForName("Game", inManagedObjectContext: context) as! Game
        let oldGames = Game.readAllGames(context)
        newGame.gameIndex = oldGames.count
        return newGame
    }
    
    class func readAllGames(context: NSManagedObjectContext) -> Array<Game> {
        let entityDescription = NSEntityDescription.entityForName("Game", inManagedObjectContext: context)
        var fetchRequest = NSFetchRequest(entityName: "Game")
        
        let sortDescriptor = NSSortDescriptor(key: "gameIndex", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let errorPointer = NSErrorPointer()
        let gameArray = context.executeFetchRequest(fetchRequest, error: errorPointer) as! Array<Game>
        return gameArray
    }
    
    func stringForEnum(gameRawValue: GameType.RawValue) -> String {
        var typeString: String
        let gameEnumValue = GameType(rawValue: gameRawValue)
        
        switch gameEnumValue! {
        case .RegularPlay:
            typeString = "Regular Play"
            
        case .TournamentOfChampions:
            typeString = "Tournament Of Champions"
            
        case .CollegeTournament:
            typeString = "College Tournament"
            
        case .TeenTournament:
            typeString = "Teen Tournament"
            
        case .TeachersTournament:
            typeString = "Teachers Tournament"
            
        case .KidsWeek:
            typeString = "Kids Week"
            
        default:
            typeString = "Other"
        }
        return typeString
    }
}
