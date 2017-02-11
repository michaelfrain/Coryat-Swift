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
    @NSManaged var gameDate: Date
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
    @NSManaged var isFinished: Bool
    
    enum GameType: Int {
        case regularPlay = 0, tournamentOfChampions, collegeTournament, teenTournament, teachersTournament, kidsWeek, numberOfGameTypes
    }

    class func createGame(_ context: NSManagedObjectContext) -> Game {
        let newGame = NSEntityDescription.insertNewObject(forEntityName: "Game", into: context) as! Game
        let oldGames = Game.readAllGames(context)
        newGame.gameIndex = NSNumber(value: oldGames.count)
        return newGame
    }
    
    class func readAllGames(_ context: NSManagedObjectContext) -> Array<Game> {
        let fetchRequest = NSFetchRequest<Game>(entityName: "Game")
        
        let sortDescriptor = NSSortDescriptor(key: "gameIndex", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let gameArray = try? context.fetch(fetchRequest)
        return gameArray!
    }
    
    func stringForEnum(_ gameRawValue: GameType.RawValue) -> String {
        var typeString: String
        let gameEnumValue = GameType(rawValue: gameRawValue)
        
        switch gameEnumValue! {
        case .regularPlay:
            typeString = "Regular Play"
            
        case .tournamentOfChampions:
            typeString = "Tournament Of Champions"
            
        case .collegeTournament:
            typeString = "College Tournament"
            
        case .teenTournament:
            typeString = "Teen Tournament"
            
        case .teachersTournament:
            typeString = "Teachers Tournament"
            
        case .kidsWeek:
            typeString = "Kids Week"
            
        default:
            typeString = "Other"
        }
        return typeString
    }
}
